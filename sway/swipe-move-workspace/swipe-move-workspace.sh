#!/usr/bin/env bash

# swipe-move-workspace.sh
#
# Move the focused workspace to the previous or next workspace.
# Applied to three-finger swipes on mousepad (left/right).
#
# Exits:
#   127 - Missing required commands - swaymsg or jq
#   11 - No direction specified
#   12 - No focused workspace found
#   13 - Invalid direction
#   14 - Invalid workspace - must be a number
#   15 - Failed to move workspace

set -euo pipefail

readonly dependencies=(
	"swaymsg"
	"jq"
)

for dependency in "${dependencies[@]}"; do
	if ! command -v "${dependency}" &>/dev/null; then
		exit 127
	fi
done

main() {
	local direction="${1:-}"
	[[ -n "${direction}" ]] || exit 11

	local focused_workspace
	focused_workspace=$(swaymsg -t get_workspaces | jq -r '.[] | select(.focused) | .name')
	[[ -n "${focused_workspace}" ]] || exit 12

	if [[ "${direction}" == "prev" ]]; then
		move_workspace "${focused_workspace}" "prev"
	elif [[ "${direction}" == "next" ]]; then
		move_workspace "${focused_workspace}" "next"
	else
		exit 13
	fi
}

move_workspace() {
	local current="${1}"
	local direction="${2}"
	local target

	[[ "${current}" =~ ^[0-9]+$ ]] || exit 14

	case "${direction}" in
	"prev")
		if ((current == 1)); then
			target=10
		else
			target=$((current - 1))
		fi
		;;
	"next")
		if ((current == 10)); then
			target=1
		else
			target=$((current + 1))
		fi
		;;
	*)
		exit 13
		;;
	esac

	if ! swaymsg move workspace "${target}"; then
		exit 15
	fi
}

main "$@"
