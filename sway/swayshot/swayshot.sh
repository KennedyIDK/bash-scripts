#!/usr/bin/env bash

# swayshot.sh
#
# Take a screenshot. If 'named' is provided as an argument, use rofi to prompt for a filename.
#
# EXITS:
#   127 - Missing required commands
#   11 - Failed to create output directory
#   12 - Failed to take screenshot

set -euo pipefail

readonly output_dir="${HOME}/screenshots"

readonly notification_icon="${HOME}/.icons/screenshot/image.png"
readonly notification_expire_time=2000 # milliseconds

if [[ -f ${notification_icon} ]]; then
	_ICON_ARG="--icon=${notification_icon}"
else
	_ICON_ARG=""
fi
readonly _ICON_ARG

readonly dependencies=(
	"grim"
	"slurp"
	"rofi"
)

for dependency in "${dependencies[@]}"; do
	if ! command -v "${dependency}" &>/dev/null; then
		exit 127
	fi
done

if [[ ! -d "$output_dir" ]]; then
	mkdir -p "${output_dir}" || exit 11
fi

readonly named="${1:-}"

if [[ "${named}" == "named" ]]; then
	filename="$(rofi -dmenu -p "Filename" -lines 0)" || exit 0
	[[ -n "${filename}" ]] || exit 0 # User cancelled or provided empty input
	display_name="${filename}.png"
else
	display_name="screenshot.png"
fi

# Timestamp for output file
date_format="$(date +%Y%m%d%H%M%S)"

# Set output file path with timestamp
if [[ "${named}" == "named" ]]; then
	output_file="${output_dir}/${date_format} ${filename}.png"
else
	output_file="${output_dir}/${date_format} screenshot.png"
fi

# Screenshot
grim -g "$(slurp)" "${output_file}" || exit 12

# Copy to clipboard
if command -v wl-copy &>/dev/null; then
	if ! wl-copy <"${output_file}"; then
		if command -v notify-send &>/dev/null; then
			notify-send "Screenshot taken (clipboard copy failed)" "${_ICON_ARG}" \
				--expire-time="${notification_expire_time}"
		fi
		exit 0
	fi
fi

# Notify user
if command -v notify-send &>/dev/null; then
	notify-send "Screenshot taken" "${display_name}" "${_ICON_ARG}" \
		--expire-time="${notification_expire_time}"
fi
