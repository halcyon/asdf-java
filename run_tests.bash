#!/usr/bin/env bash
set -e
set -Euo pipefail

check_file_uniqueness() {
    local file="$1"
    if [ ! -f "${file}" ]; then
        echo "WARNING: File '${file}' not found, skipping uniqueness check."
        return
    fi
    echo "Checking for duplicate lines in '${file}'..."

    local total_lines
    total_lines=$(wc -l < "${file}")
    local unique_lines
    unique_lines=$(sort -u "${file}" | wc -l)

    if [ "${total_lines}" -ne "${unique_lines}" ]; then
        echo "ERROR: Found duplicate lines in '${file}'."
        echo "The following lines are duplicated:"
        sort "${file}" | uniq -d
        exit 1
    fi
    echo "OK: All ${total_lines} lines in '${file}' are unique."
}

check_entry_present() {
    local entry="$1"
    local file="$2"
    echo "Checking for presence of entry starting with '${entry}' in '${file}'..."

    # Use `grep -q` for a quiet check. `^` anchors the search to the start of the line.
    if grep -q "^${entry}" "${file}"; then
        echo "OK: Entry '${entry}' found."
    else
        echo "ERROR: Entry '${entry}' not found at the start of any line in '${file}'."
        exit 1
    fi
}

echo "--- Verifying uniqueness of all lines in data/*.tsv files ---"
for file in data/*.tsv; do
    check_file_uniqueness "${file}"
done
echo "--- All .tsv files contain unique lines. ---"
echo ""


echo "--- Checking for presence of required entries ---"
check_entry_present "adoptopenjdk-openj9-11" "data/jdk-linux-x86_64.tsv"
check_entry_present "adoptopenjdk-openj9-large_heap-11" "data/jdk-macosx-x86_64.tsv"
check_entry_present "zulu-musl-11" "data/jdk-linux-x86_64.tsv"
check_entry_present "liberica-javafx-16" "data/jdk-linux-arm32-vfp-hflt.tsv"
check_entry_present "liberica-lite-11" "data/jdk-macosx-x86_64.tsv"
check_entry_present "graalvm-21" "data/jdk-linux-aarch64.tsv"
check_entry_present "jetbrains-21" "data/jdk-linux-x86_64.tsv"
check_entry_present "jetbrains-jre-21" "data/jdk-linux-x86_64.tsv"
check_entry_present "adoptopenjdk-21" "data/jdk-linux-x86_64.tsv"
echo "--- All required entries are present. ---"
echo ""

echo "All checks passed successfully."
