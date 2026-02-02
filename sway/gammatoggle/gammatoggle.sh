#!/usr/bin/env bash

# gammatoggle.sh
#
# Toggle Gammastep on and off
#
# Usage: Applied to middle click on waybar backlight module
#
# Exits:
#   127 - Missing required commands
#   11 - Failed to start Gammastep

set -euo pipefail

readonly gammastep_temp=4500

readonly notification_icon="${HOME}/.icons/gammatoggle/image.png" # optional
readonly notification_expire_time=2000                            # milliseconds

if [[ -f ${notification_icon} ]]; then
	_ICON_ARG="--icon=${notification_icon}"
else
	_ICON_ARG=""
fi
readonly _ICON_ARG

readonly dependencies=(
	"pkill"
	"gammastep"
	"notify-send"
)

for dependency in "${dependencies[@]}"; do
	if ! command -v "${dependency}" &>/dev/null; then
		exit 127
	fi
done

if pkill gammastep >/dev/null 2>&1; then
	gammastep_status="DISABLED"
else
	gammastep -O "${gammastep_temp}" >/dev/null 2>&1 &
	sleep 0.2
	if ! pgrep -x gammastep >/dev/null; then
		exit 11
	fi
	gammastep_status="ENABLED"
fi

notify-send "Gammastep ${gammastep_status}" "${_ICON_ARG}" \
	--expire-time="${notification_expire_time}"
