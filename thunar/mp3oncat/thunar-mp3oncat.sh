#!/usr/bin/env bash

# Name        : thunar_mp3oncat
#
# Description : Concatenate audio files via thunar context menu.
#
# EXITS:
#   127 - Missing required dependencies
#   11 - Less than two audio files are selected
#   12 - Mixed file extensions detected
#   13 - No output file name provided
#   14 - Output file already exists
#   15 - Failed to concatenate audio files

set -euo pipefail

readonly dependencies=(
	"ffmpeg"
	"rofi"
)

for dependency in "${dependencies[@]}"; do
	if ! command -v "${dependency}" &>/dev/null; then
		exit 127
	fi
done

[[ "${#}" -ge 2 ]] || exit 11

output_dir="$(dirname "${1}")"
first_extension="${1##*.}"

for file in "${@}"; do
	file_extension="${file##*.}"
	[[ "${file_extension}" == "${first_extension}" ]] || exit 12
done

# Prompt for a filename.
output_file=$(printf '' | rofi -dmenu -lines 0 -p "Enter output filename (without extension)")
[[ -n "${output_file}" ]] || exit 13

output_file="${output_file}.${first_extension}"
output_path="${output_dir}/${output_file}"
if [[ -e "${output_path}" ]]; then
	exit 14
fi

concat_list=$(printf '%s|' "${@}")
concat_list="${concat_list%|}"

if ! ffmpeg -loglevel error -i "concat:${concat_list}" -c copy "$output_path"; then
	exit 15
fi
