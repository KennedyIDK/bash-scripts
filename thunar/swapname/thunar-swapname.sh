#!/usr/bin/env bash

# Name        : thunar_swapname
#
# Description : Swap two filenames via thunar context menu
#
# EXITS:
#   11 - Incorrect number of arguments
#   12 - One or both of the files do not exist, or files are the same, or files in different directories
#   13 - Failed to swap filenames

set -euo pipefail

tmpfile=""

# shellcheck disable=SC2329
cleanup() {
	if [[ -n "${tmpfile}" ]] && [[ -e "${tmpfile}" ]]; then
		mv "${tmpfile}" "${file1}" 2>/dev/null || true
	fi
}

trap cleanup EXIT INT TERM

[[ "${#}" -eq 2 ]] || exit 11

file1="$(realpath "${1}")" || exit 12
file2="$(realpath "${2}")" || exit 12
[[ -e "${file1}" ]] && [[ -e "${file2}" ]] || exit 12

if [[ "${file1}" == "${file2}" ]]; then
	notify-send "Swap Error" "Cannot swap a file with itself"
	exit 12
fi

dir1="$(dirname "$file1")"
dir2="$(dirname "$file2")"

if [[ "$dir1" != "$dir2" ]]; then
	notify-send "Swap Error" "Files must be in the same directory"
	exit 12
fi

tmpfile="$(mktemp -u "${file1}.XXXXXX")" || exit 13

if mv "${file1}" "${tmpfile}" &&
	mv "${file2}" "${file1}" &&
	mv "${tmpfile}" "${file2}"; then
	notify-send "Filenames swapped" "$(basename "${file1}") <-> $(basename "${file2}")"
	tmpfile="" # Clear tmpfile so cleanup doesn't attempt restoration
else
	exit 13
fi
