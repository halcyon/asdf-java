#!/usr/bin/env bash
set -e
set -Euo pipefail

# See https://joschi.github.io/java-metadata/ for supported values
LIST_OS="linux macosx"
LIST_ARCH="x86_64 aarch64 arm32-vfp-hflt"
LIST_RELEASE_TYPE="ga ea"

DATA_DIR="./data"

if [[ ! -d "${DATA_DIR}" ]]
then
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

for OS in $LIST_OS
do
	for ARCH in $LIST_ARCH
	do
		for RELEASE_TYPE in $LIST_RELEASE_TYPE
		do
			fetch_metadata "$OS" "$ARCH" "$RELEASE_TYPE"
		done
		cat "${DATA_DIR}/jdk-${OS}-${ARCH}"-*.json | jq -s 'add' > "${DATA_DIR}/jdk-${OS}-${ARCH}-all.json"
		ln -s "jdk-${OS}-${ARCH}-ga.json" "${DATA_DIR}/jdk-${OS}-${ARCH}.json"
	done
done

RELEASE_QUERY='.[]
  | select(.file_type | IN("tar.gz", "zip"))
  | .["features"] = (.features | map(select(IN("musl", "javafx", "lite", "large_heap", "crac", "fiber"))))
  | [([.vendor, if (.image_type == "jre") then .image_type else empty end, if (.jvm_impl == "openj9") then .jvm_impl else empty end, if ((.features | length) == 0) then empty else (.features | join("-")) end, .version] | join("-")), .filename, .url, .sha256]
  | @tsv'
for FILE in "${DATA_DIR}"/*.json
do
	TSV_FILE="$(basename "${FILE}" .json).tsv"
	jq -r "${RELEASE_QUERY}" "${FILE}" | sort -V > "${DATA_DIR}/${TSV_FILE}"
done
