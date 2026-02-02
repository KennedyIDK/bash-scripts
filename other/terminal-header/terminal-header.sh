#!/usr/bin/env bash
#
# Terminal header script for bash sessions.
# Displays system information and warns if backups are too old.

# TODO:
# - Account for dry runs when checking backups.

# SETTINGS
# =============================================================================

readonly _DEBUG=false

set -o errexit
set -o nounset
set -o pipefail

# VARIABLES
# =============================================================================

declare -A _BACKUP_DIRS # directories containing backup logs
_BACKUP_DIRS["Local"]="${HOME}/bin/.logs/bakhome/"
_BACKUP_DIRS["Cloud"]="${HOME}/bin/.logs/bakcloud/"
readonly _BACKUP_DIRS

declare -A _BACKUP_THRESHOLDS # age thresholds for backup warnings (days)
_BACKUP_THRESHOLDS["Local"]=6
_BACKUP_THRESHOLDS["Cloud"]=1
readonly _BACKUP_THRESHOLDS

# FUNCTIONS
# ==============================================================================

main() {
	setup_and_dependencies
	display_system_info
	check_backups "Local"
	check_backups "Cloud"
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
		"ansify_string"
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
# Display system information (load average, process count, VPN server)
#
# EXITS:
#   11 - Failed to get VPN server from ${_VPN_SERVER_FILE}
#   12 - Failed to get VPN connection status
#   13 - Failed to get load average
#   14 - Failed to get process count
#######################################
display_system_info() {
	local load_avg
	load_avg=$(uptime | awk -F'load average: ' '{print $2}' | cut -d, -f1-3)
	[[ -n "${load_avg}" ]] || exit 13
	echo "Load Avgs: ${load_avg}"

	local process_count
	process_count=$(ps -e | wc -l)
	[[ -n "${process_count}" ]] || exit 14
	echo "Processes: ${process_count}"
}

#######################################
# Check age of backups and display warnings if too old
#
# EXITS:
#   15 - Failed to calculate days old
#######################################
check_backups() {
	local backup_type="$1"

	local -A backup_prefixes
	backup_prefixes["Local"]="rsync."
	backup_prefixes["Cloud"]="rclone."

	local backup_dir="${_BACKUP_DIRS[${backup_type}]}"
	local backup_prefix="${backup_prefixes[${backup_type}]}"
	local age_threshold="${_BACKUP_THRESHOLDS[${backup_type}]}"

	if [[ ! -d "${backup_dir}" ]]; then
		echo
		warn "Backup directory does not exist: ${backup_dir}"
		return 0
	fi

	local latest_backup
	latest_backup=$(find "${backup_dir}" -name "${backup_prefix}*.log" -printf '%T@ %p\n' 2>/dev/null |
		sort -n | tail -n 1 | cut -d' ' -f2-)

	if [[ -z "${latest_backup}" ]]; then
		echo
		warn "No latest ${backup_type} backup found"
		return 0
	fi

	local backup_mtime
	backup_mtime=$(stat --format='%Y' "${latest_backup}" 2>&1) || exit 19

	local days_old
	days_old=$((($(date +%s) - backup_mtime) / 86400))
	[[ -n "${days_old}" ]] || exit 15

	local days_old_formatted="${days_old}"
	if ((days_old > age_threshold * 2)); then
		days_old_formatted=$(ansify_string "${days_old}" "red")
	elif ((days_old > age_threshold)); then
		days_old_formatted=$(ansify_string "${days_old}" "yellow")
	fi

	if ((days_old > age_threshold)); then
		echo -e "\n${backup_type} backup is ${days_old_formatted} days old."
	fi
}

#######################################
# Perform cleanup when script terminates
#######################################
cleanup() {
	local exit_code=$?
	print_exit_code "${exit_code}"
	exit "${exit_code}"
}

trap 'cleanup' EXIT ERR INT TERM

# =============================================================================

main "$@"
