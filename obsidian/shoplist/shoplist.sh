#!/usr/bin/env bash

# shoplist.sh
#
# Opens a text box to quickly append items to Obsidian shopping list using a
# system wide hotkey. Multiple items should be separated by a comma.
#
# TODO: Account for recipes/regions that use a comma as a decimal separator.
#       For now, update the delimiter below to another character.

# SETTINGS
# =============================================================================

readonly _DEBUG=false # whether to print debug messages

set -o errexit  # abort on nonzero exitstatus
set -o nounset  # abort on unbound variables
set -o pipefail # don't hide errors within pipes

# VARIABLES
# =============================================================================

readonly _SHOPLIST_FILE="${HOME}/notes/SHOP.md"

readonly _INPUT_DELIMITER=","

_NOTIFICATION_ICON="${HOME}/.icons/shoplist/image.png" # optional
_NOTIFICATION_EXPIRE_TIME=2000                         # milliseconds
readonly _NOTIFICATION_ICON _NOTIFICATION_EXPIRE_TIME

_ICON_ARG="" # set by send_success_notification

# FUNCTIONS
# =============================================================================

main() {
	setup_and_dependencies
	validate_shoplist_file
	add_items_to_shopping_list
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

	local additional_functions=(
		"remove_duplicates_from_array"
		"reverse_array"
		"trim_lead_trail_whitespace"
	)

	local external_commands=(
		# Rofi or Zenity checked later in get_items_from_user_input()
	)

	local required_functions=("${core_functions[@]}" "${additional_functions[@]}")
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
# Validate shopping list file exists and is writable
#
# EXITS:
#   11 - Shopping list file does not exist
#   12 - Shopping list file is not writeable
#######################################
validate_shoplist_file() {
	[[ -e "${_SHOPLIST_FILE}" ]] || exit 11
	[[ -w "${_SHOPLIST_FILE}" ]] || exit 12
}

#######################################
# Get items from input using rofi or zenity
#
# EXITS:
#   13 - Rofi or Zenity required but not available
#   14 - No input provided
#######################################
get_items_from_user_input() {
	local title="Obsidian"
	local text_prompt="Add to shopping list"

	local input
	# Use rofi by default
	if command -v rofi &>/dev/null; then
		input=$(rofi -dmenu -p "${text_prompt}" 2>/dev/null)
	elif command -v zenity &>/dev/null; then
		input=$(zenity --entry --title="${title}" --text="${text_prompt}" 2>/dev/null)
	else
		exit 13
	fi
	[[ -n "${input}" ]] || exit 14

	printf "%s\n" "${input}"
}

#######################################
# Process user input: split by delimiter, trim whitespace, and remove duplicates
#
# EXITS:
#   15 - No valid items after processing
#######################################
process_user_input() {
	local input
	input="$(get_items_from_user_input)"

	if [[ "${input}" == *"${_INPUT_DELIMITER}"* ]]; then

		# Split by delimiter
		local items=()
		while [[ "${input}" == *"${_INPUT_DELIMITER}"* ]]; do
			local item="${input%%"${_INPUT_DELIMITER}"*}"
			items+=("${item}")
			input="${input#*"${_INPUT_DELIMITER}"}"
		done
		[[ -n "${input}" ]] && items+=("${input}") # Add the last item

		# Trim whitespace from all items
		local trimmed_items=()
		for item in "${items[@]}"; do
			local trimmed_item
			trimmed_item="$(trim_lead_trail_whitespace "${item}")"
			[[ -n "${trimmed_item}" ]] && trimmed_items+=("${trimmed_item}")
		done
		[[ ${#trimmed_items[@]} -gt 0 ]] || exit 15

		# Remove duplicates
		local unique_items=()
		readarray -t unique_items < <(remove_duplicates_from_array "${trimmed_items[@]}")
		[[ ${#unique_items[@]} -gt 0 ]] || exit 15

		printf "%s\n" "${unique_items[@]}"
	else
		printf "%s\n" "${input}"
	fi
}

#######################################
# Success notification
#######################################
send_success_notification() {
	local message_success="Updated shopping list!"

	if [[ -f "${_NOTIFICATION_ICON}" ]]; then
		_ICON_ARG="--icon=${_NOTIFICATION_ICON}"
	fi
	readonly _ICON_ARG

	if [[ -n "${_ICON_ARG}" ]]; then
		notify-send "${_ICON_ARG}" --expire-time="${_NOTIFICATION_EXPIRE_TIME}" "${message_success}"
	else
		notify-send --expire-time="${_NOTIFICATION_EXPIRE_TIME}" "${message_success}"
	fi
}

#######################################
# Add items to shopping list
#
# EXITS:
#   16 - Failed to add item to shopping list
#   17 - Shopping list header not found
#######################################
add_items_to_shopping_list() {
	local shoplist_header="## Shopping List"
	local entry_markdown="- [ ]"

	local insert_line_number
	insert_line_number=$(grep -n "${shoplist_header}" "${_SHOPLIST_FILE}" | cut -d: -f1)
	[[ -n "${insert_line_number}" ]] || exit 17
	insert_line_number=$((insert_line_number + 1))

	local items=()
	readarray -t items < <(process_user_input)

	# Reverse array so items are added in correct order
	readarray -t items < <(reverse_array "${items[@]}")

	for item in "${items[@]}"; do
		if ! sed -i "${insert_line_number}{h;s/.*/${entry_markdown} ${item}/;x;G}" "${_SHOPLIST_FILE}"; then
			err "Failed to add item to shopping list: '${item}'"
			exit 16
		fi
	done

	send_success_notification
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
