# Functions

| Function | Purpose |
| - | - |
| `ansify_string` | Wraps a string in ANSI escape codes for easy terminal colorisation. |
| `check_required_commands` | Checks commands in `_REQUIRED_COMMANDS` array are available |
| `create_image_thumbnail_for` | Displays a temporary thumbnail for a given image in kitty |
| `create_video_thumbnail_for` | Displays a series of temporary thumbnail images from a given video in kitty |
| `deb` | Display and log debug messages when `_DEBUG` variable is set to `true` |
| `err` | Display and log error messages, incrementing the `_ERROR_COUNTER` variable to track any non-fatal errors |
| `extract_lines_between_markers` | Extract lines between specified opening and closing markers from a file |
| `print_exit_code` | On nonzero exit code, print description of exit code from script comments to terminal (interactive) or notification (non-interactive), called by `cleanup` |
| `print_separator` | Print a separator line using a specified character and length |
| `remove_duplicates_from_array` | Remove duplicate elements from an array while preserving order |
| `reverse_array` | Reverse the order of elements in an array |
| `script_setup` | Check dependencies and initialise script environment (log file, error tracking, globals) |
| `trim_all_whitespace` | Remove all whitespace from a string |
| `trim_lead_trail_whitespace` | Remove leading and trailing whitespace from a string |
| `warn` | Display and log warning messages for non-error conditions |

# Setup

Required functions are sourced by a loop in the `setup_and_depencencies` function at the top of the script:

```bash
setup_and_dependencies() {
	local core_functions=("script_setup" "check_required_commands"
		"print_exit_code" "err" "warn" "deb")

	local additional_functions=("remove_duplicates_from_array")

	local external_commands=("age")

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
```

To make the required functions available to the script you must either:

1. Put all necessary functions in `~/bin/.functions` as I have.
2. Put all necessary functions somewhere else and update `functions_dir` in the `setup_and_depencencies` to that location.
3. Put all necessary functions within the script and remove the sourcing logic from the `setup_and_dependencies` function.

Each script has its own README listing required functions and a one-liner to install them. If you would rather install all the functions you can do so with:

```bash

```


# Notes

- `err`, `deb`, `warn`, `print_exit_code`, `check_required_commands` and `script_setup` are used in almost every script and therefore considered *core* functions. Other functions are *additional* functions.
- By default `script_setup` will create a log file for the script inside a hidden directory `.logs` within the script's working directory. To use a different location set the `$SCRIPT_LOGS` variable in your environment. 
- If a script is run in a non-interactive environment (i.e. not in a terminal) then `print_exit_code` will rely on `notify-send` (part of the `libnotify` package) to report errors to the user. I am never quite sure whether to consider `notify-send` a required dependency or just let it fail silently, so it may not be included in the `_REQUIRED_COMMANDS` array despite technically being an external command.
- Scripts that don't use any sourced functions check for external commands directly instead of using `check_required_commands`.
- Some of these functions were inspired or taken from [dylanaraps/pure-bash-bible](https://github.com/dylanaraps/pure-bash-bible) - which is a useful resource.
