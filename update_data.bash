#!/usr/bin/env bash
set -e
set -Euo pipefail

# See https://joschi.github.io/java-metadata/ for supported values
LIST_OS="linux macosx"
LIST_ARCH="x86_64 aarch64 arm32-vfp-hflt"

DATA_DIR="./data"

if [[ ! -d "${DATA_DIR}" ]]
then
	mkdir "${DATA_DIR}"
fi

function metadata_url {
	local os=$1
	local arch=$2

	echo "https://joschi.github.io/java-metadata/metadata/ga/${os}/${arch}/jdk.json"
}

function fetch_metadata {
	local os=$1
	local arch=$2
	local url
	url=$(metadata_url "$os" "$arch")

	local args=('-s' '-f' '--compressed' '-H' "Accept: application/json")
	if [[ -n "${GITHUB_API_TOKEN:-}" ]]; then
		args+=('-H' "Authorization: token $GITHUB_API_TOKEN")
	fi

	curl "${args[@]}" -o "${DATA_DIR}/jdk-${os}-${arch}.json" "${url}"
}

for OS in $LIST_OS
do
	for ARCH in $LIST_ARCH
	do
		fetch_metadata "$OS" "$ARCH"
	done
done

RELEASE_QUERY='.[]
  | select(.file_type | IN("tar.gz", "zip"))
  | .["features"] = (.features | map(select(IN("musl", "javafx", "lite", "large_heap"))))
  | [([.vendor, if (.jvm_impl == "openj9") then .jvm_impl else empty end, if ((.features | length) == 0) then empty else (.features | join("-")) end, .version] | join("-")), .filename, .url, .sha256]
  | @tsv'
for FILE in "${DATA_DIR}"/*.json
do
	TSV_FILE="$(basename "${FILE}" .json).tsv"
 	jq -r "${RELEASE_QUERY}" "${FILE}" | sort -V > "${DATA_DIR}/${TSV_FILE}"
done
