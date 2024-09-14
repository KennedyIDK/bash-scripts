#!/usr/bin/env bash

# Name        : thunar_rename_lowercase

# Description : Rename selected files and directories to lowercase and replace space with underscore
#               via Thunar context menu.

# =============================================================================

# VARIABLES
# ---------

error_log="$HOME/appdata/thunar/rename_lowercase_$(date +'%Y-%m-%d_(%H:%M)').log"

# CHECKS
# ---------

# Check if at least one filename or directory was provided as an argument.

if [ $# -eq 0 ]; then
  zenity --error --text="No file or directory selected."
  exit 1
fi

# SCRIPT_EXECUTION
# ----------------

# Loop through each argument and rename it.

for file in "$@"; do

  # Generate new name for the file

  new_name="$(echo "$file" | tr ' ' '_' | tr '[:upper:]' '[:lower:]')"

  # Check if the file exists

  if [ ! -e "$file" ]; then
    touch "$error_log"
    echo "$file does not exist." >>"$error_log"
    continue
  elif [ -e "$new_name" ]; then
    touch "$error_log"
    echo "$new_name already exists." >>"$error_log"
    continue
  else
    mv "$file" "$new_name"
  fi
done

# Display errors, if any.

if [ -s "$error_log" ]; then
  zenity --error --text="Some files could not be renamed:\n\n$(cat "$error_log")"
fi

exit 0
