#!/usr/bin/env bash

# appmute.sh
#
# Mute/unmute the audio of a specific application using PulseAudio.
#
# Usage:
#   appmute.sh <application name>
#
# Exits:
#   127 - Missing required commands
#   11 - No application name provided
#   12 - Too many arguments
#   13 - Failed to get sink index
#   14 - Failed to toggle mute
#   15 - No mute status found

set -euo pipefail

readonly dependencies=(
	"pactl"
	"notify-send"
)

for dependency in "${dependencies[@]}"; do
	if ! command -v "${dependency}" &>/dev/null; then
		exit 127
	fi
done

readonly _APP_NAME="${1:-}"
[[ -n "${_APP_NAME}" ]] || exit 11
[[ $# -eq 1 ]] || exit 12

_ICON_ARG=""                                      # set by notify_mute_status
_MUTE_ICON="${HOME}/.icons/appmute/muted.png"     # optional
_UNMUTE_ICON="${HOME}/.icons/appmute/unmuted.png" # optional
_NOTIFICATION_EXPIRE_TIME=2000                    # milliseconds
readonly _MUTE_ICON _UNMUTE_ICON _NOTIFICATION_EXPIRE_TIME

main() {
	mute_unmute_application
}

#######################################
# Get sink index
#######################################
get_sink_index() {
	local result
	result=$(pactl list sink-inputs |
		grep -B 20 "application.name = \"${_APP_NAME}\"" |
		grep "Sink Input #" |
		awk '{print $3}' |
		tr -d '#') || true
	printf '%s' "$result"
}

#######################################
# Notify mute status
#######################################
notify_mute_status() {
	local sink_index="$1"

	local mute_status
	mute_status=$(pactl list sink-inputs | grep -A 15 "Sink Input #${sink_index}" | grep Mute | awk '{print $2}')
	[[ -n "$mute_status" ]] || exit 15

	if [[ -f "${_MUTE_ICON}" && -f "${_UNMUTE_ICON}" ]]; then
		if [[ "$mute_status" == *"yes"* ]]; then
			mute_status="Muted"
			_ICON_ARG="--icon=${_MUTE_ICON}"
		else
			mute_status="Unmuted"
			_ICON_ARG="--icon=${_UNMUTE_ICON}"
		fi
	else
		_ICON_ARG=""
	fi
	readonly _ICON_ARG

	notify-send "${mute_status} ${_APP_NAME}" "${_ICON_ARG}" --expire-time="${_NOTIFICATION_EXPIRE_TIME}"
}

#######################################
# Mute/unmute application
#######################################
mute_unmute_application() {
	local sink_index
	sink_index=$(get_sink_index)

	[[ -n "$sink_index" ]] || exit 13

	pactl set-sink-input-mute "$sink_index" toggle || exit 14

	notify_mute_status "$sink_index"
}

main "$@"
