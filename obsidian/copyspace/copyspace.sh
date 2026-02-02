#!/usr/bin/env bash

# copyspace.sh
#
# Quicky append selected text to Obsidian copyspace file using a system wide hotkey.
#
# Options:
#   -t: Add timestamp to the entry

# SETTINGS
# =============================================================================

readonly _DEBUG=false # whether to print debug messages

set -o errexit  # abort on nonzero exitstatus
set -o nounset  # abort on unbound variables
set -o pipefail # don't hide errors within pipes

# VARIABLES
# =============================================================================

readonly _COPYSPACE_FILE="$HOME/notes/COPY.md"

_ADD_TIMESTAMP=false # whether to timestamp the entry to the copyspace file

_NOTIFICATION_ICON="${HOME}/.icons/obsidian/image.png" # optional
_NOTIFICATION_EXPIRE_TIME=2000                         # milliseconds
readonly _NOTIFICATION_ICON _NOTIFICATION_EXPIRE_TIME

_ICON_ARG=""          # set by send_success_notification
_CLIPBOARD_COMMAND="" # set by setup_and_dependencies

# FUNCTIONS
# =============================================================================

main() {
	setup_and_dependencies
	parse_arguments "${@}"
	validate_copyspace_file
	append_to_copyspace_file
	clear_clipboard
}

#######################################
# Check required functions/dependencies and set global variables
#
# EXITS:
#   101 - Failed to source required function
#   102 - Failed to run script setup
#   103 - Failed to create log directory or log file
#   104 - Failed to check required commands
#   127 - Missing required dependencies
#######################################
setup_and_dependencies() {
	local core_functions=(
		"script_setup"
		"check_required_commands"
		"print_exit_code"
		"err"
		"warn"
		"deb"
	)

	local external_commands=()
	case ${XDG_SESSION_TYPE} in
	"wayland") external_commands+=("wl-paste") && _CLIPBOARD_COMMAND="wl-paste" ;;
	"x11") external_commands+=("xclip") && _CLIPBOARD_COMMAND="xclip" ;;
	esac
	readonly _CLIPBOARD_COMMAND

	local required_functions=("${core_functions[@]}")
	readonly _REQUIRED_COMMANDS=("${required_functions[@]}" "${external_commands[@]}")

	local timestamp
	timestamp="$(date +'%Y%m%d%H%M%S')"
	local error_message
	error_message="ERROR/${0##*/} ${timestamp}: Script failed with exit code"

	local functions_dir="${HOME}/bin/.functions"
	for function in "${required_functions[@]}"; do
		local function_file="${functions_dir}/${function}"
		if [[ -s "${function_file}" ]]; then
			# shellcheck source=/dev/null
			source "${function_file}" || {
				printf "%s\n" "${error_message} 101 (Failed to source function ${function})" >&2
				exit 101
			}
		fi
	done

	script_setup || exit 102
}

#######################################
# Parse command line arguments
#
# EXITS:
#   4 - Unknown option provided
#######################################
parse_arguments() {
	while getopts "t" opt; do
		case "${opt}" in
		t)
			_ADD_TIMESTAMP=true
			readonly _ADD_TIMESTAMP
			;;
		*)
			err "Unknown option: ${opt}"
			exit 4
			;;
		esac
	done
}

#######################################
# Validate copyspace file exists and is writable
#
# EXITS:
#   11 - Copyspace file does not exist
#   12 - Copyspace file is not writeable
#######################################
validate_copyspace_file() {
	[[ -e "${_COPYSPACE_FILE}" ]] || exit 11
	[[ -w "${_COPYSPACE_FILE}" ]] || exit 12
}

#######################################
# Get selected text
#
# EXITS:
#   13 - No text selected
#######################################
get_selected_text() {
	local selected_text

	case "${_CLIPBOARD_COMMAND}" in
	"wl-paste")
		selected_text="$(wl-paste --primary --no-newline)"
		;;
	"xclip")
		selected_text="$(xclip -o -selection primary)"
		;;
	esac

	[[ -n "${selected_text}" ]] || exit 13

	printf "%s\n" "${selected_text}"
}

#######################################
# Send notification on success
#######################################
send_success_notification() {
	local text="${1}"
	local notification="Added to Copyspace:\n\n${text}"

	if [[ -f "${_NOTIFICATION_ICON}" ]]; then
		_ICON_ARG="--icon=${_NOTIFICATION_ICON}"
	fi
	readonly _ICON_ARG

	if [[ -n "${_ICON_ARG}" ]]; then
		notify-send --expire-time="${_NOTIFICATION_EXPIRE_TIME}" "${_ICON_ARG}" \
			"${_SCRIPT_NAME}" "${notification}"
	else
		notify-send --expire-time="${_NOTIFICATION_EXPIRE_TIME}" \
			"${_SCRIPT_NAME}" "${notification}"
	fi
}

#######################################
# Append selected text to copyspace file
#
# EXITS:
#   14 - Failed to append text to copyspace file
#######################################
append_to_copyspace_file() {
	local selected_text
	selected_text="$(get_selected_text)"

	local timestamp
	case "${_ADD_TIMESTAMP}" in
	"true")
		timestamp="\n---\n\n###### $(date '+%a %b %d %I:%M:%S %p %Z %Y')"
		;;
	"false")
		timestamp=""
		;;
	esac

	if printf "%b\n> %s\n" "${timestamp}" "${selected_text}" >>"${_COPYSPACE_FILE}"; then
		send_success_notification "${selected_text}"
	else
		exit 14
	fi
}

#######################################
# Clear the clipboard
#######################################
clear_clipboard() {
	case "${_CLIPBOARD_COMMAND}" in
	"wl-paste")
		wl-copy --clear
		;;
	"xclip")
		printf "" | xclip -selection clipboard
		;;
	esac
}

#######################################
# Perform cleanup when script terminates
#
# EXITS:
#   $? - original exit code
#######################################
cleanup() {
	local exit_code=$?
	print_exit_code "${exit_code}"
	exit "${exit_code}"
}

trap 'cleanup' EXIT ERR INT TERM

# =============================================================================

main "$@"
