#!/usr/bin/env bash
set -e
set -Euo pipefail

# See https://joschi.github.io/java-metadata/ for supported values
LIST_OS="linux macosx"
LIST_ARCH="x86_64 aarch64 arm32-vfp-hflt"
LIST_RELEASE_TYPE="ga ea"

DATA_DIR="./data"

if [[ ! -d "${DATA_DIR}" ]]; then
	mkdir "${DATA_DIR}"
fi

function metadata_url {
	local os=$1
	local arch=$2
	local release=$3

	echo "https://joschi.github.io/java-metadata/metadata/${release}/${os}/${arch}.json"
}

function fetch_metadata {
	local os=$1
	local arch=$2
	local release=$3

	local args=('-s' '-f' '--compressed' '-H' "Accept: application/json")
	if [[ -n "${GITHUB_API_TOKEN:-}" ]]; then
		args+=('-H' "Authorization: token $GITHUB_API_TOKEN")
	fi

	local url
	url=$(metadata_url "$os" "$arch" "$release")
	curl "${args[@]}" -o "${DATA_DIR}/jdk-${os}-${arch}-${release}.json" "${url}"
}

for OS in $LIST_OS; do
	for ARCH in $LIST_ARCH; do
		for RELEASE_TYPE in $LIST_RELEASE_TYPE; do
			fetch_metadata "$OS" "$ARCH" "$RELEASE_TYPE"
		done
		cat "${DATA_DIR}/jdk-${OS}-${ARCH}"-*.json | jq -s 'add' >"${DATA_DIR}/jdk-${OS}-${ARCH}-all.json"
		ln -s "jdk-${OS}-${ARCH}-ga.json" "${DATA_DIR}/jdk-${OS}-${ARCH}.json"
	done
done

# shellcheck disable=SC2016
RELEASE_QUERY='
# Function to generate a canonical key for a release.
# This key is used to group releases that would be duplicates after feature cleanup.
def key($features_to_use):
  [
    .vendor,
    # Add "jre" to the key if the image_type is "jre".
    if .image_type == "jre" then "jre" else empty end,
    # Add "openj9" to the key if the jvm_impl is "openj9".
    if .jvm_impl == "openj9" then "openj9" else empty end,
    # Add the sorted and filtered features to the key if any exist.
    if ($features_to_use | length) > 0 then $features_to_use | join("-") else empty end,
    .version
  ] | join("-");

# Function to parse a version string into an array of numbers for comparison.
# It handles various formats like "11.0.10+9", "8u191+12", "21.0.3+9.0.LTS".
def parse_version:
 [splits("[-.]")]
 | map(tonumber? // 0) ;

# Define the list of allowed features.
["musl", "javafx", "lite", "large_heap", "certified", "crac", "fiber"] as $allowed_features
| [
  .[]
  # Filter for supported file types.
  | select(.file_type | IN("tar.gz", "tgz", "zip"))
  | {
      # Keep the original release data.
      original: .,
      # Generate the canonical key by cleaning and sorting the features.
      key_text: key(.features | map(select(IN($allowed_features[]))) | sort)
    }
]
# Group releases by their canonical key.
| group_by(.key_text)
# For each group of potential duplicates, select the best candidate. The "best"
# is determined by selecting the release with the minimum value based on the
# following criteria (in order):
#  1. The number of features (fewer is better).
#  2. The length of the filename without the version part (shorter is better), the assumption being that the shortest filename has the least additional features.
# As a tie-breaker, releases are pre-sorted by version helping to ensure that the earliest version is always chosen so that it does not change even if new versions are added
# additional tie-breakers are file_type so that the same file_type is chosen each time and finally filename as a fallback.
| map(
  # First, filter the group to ensure we only process valid objects.
  [ .[] | select(type == "object" and .original) ]
  # Pre-sort releases by version (now using the reliable .version field) and file_type
  # to provide a stable tie-breaker for min_by.
  | sort_by([(.original.version | parse_version), .original.file_type, .original.filename])
  # From the sorted list, find the best candidate.
  | min_by([
      # 1. Prefer fewer features.
      (.original.features | length),
      # 2. Prefer shorter sanitized filename.
      ((.original.filename | gsub("\\.(tar\\.gz|tgz|zip)$"; "") | length) - (.original.version | length))
    ])
)
# Flatten the array of selected releases.
| .[]
# Format the final output as a TSV line.
| [
    .key_text,
    .original.filename,
    .original.url,
    .original.sha256
  ] | @tsv
'

for FILE in "${DATA_DIR}"/*.json; do
	TSV_FILE="$(basename "${FILE}" .json).tsv"
	jq -r "${RELEASE_QUERY}" "${FILE}" | sort -V >"${DATA_DIR}/${TSV_FILE}"
done
