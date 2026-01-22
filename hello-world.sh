#!/usr/bin/env bash

# SETTINGS
# =============================================================================

readonly _DEBUG=true

set -o errexit
set -o nounset
set -o pipefail

# VARIABLES
# =============================================================================

# FUNCTIONS
# =============================================================================

main() {
	setup_and_dependencies
	parse_arguments "${@}"

	echo "Hello, world!"
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
	)

	local external_commands=(
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
# Parse command line arguments
#
# EXITS:
#   0 - Help requested
#   0 - Script opened in editor
#   4 - Unknown option provided
#######################################
parse_arguments() {
	while getopts "hE" opt; do
		case "${opt}" in
		h)
			usage
			exit 0
			;;
		E)
			${EDITOR:-${VISUAL:-vi}} "${0}"
			exit 0
			;;
		*)
			err "Unknown option: ${opt}"
			usage
			exit 4
			;;
		esac
	done
}

#######################################
# Display usage information
#######################################
usage() {
	cat <<USAGE
Usage: ${_SCRIPT_NAME} [OPTIONS]

Options:
    -h     Show this help message
    -E     Open script in editor

Examples:
    ${_SCRIPT_NAME}
USAGE
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
