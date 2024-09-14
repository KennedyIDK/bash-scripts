#!/usr/bin/env bash

# Name        : thunar_swapname

# Description : Swap two file or folder names via thunar context menu

# =============================================================================

# VARIABLES
# ---------

# Get the names of the two files or folders
file1="$1"
file2="$2"

# CHECKS
# ------

# Check if two files or folders were provided as arguments.

if [ $# -ne 2 ]; then
  zenity --error --text="Two files or folders must be selected."
  exit 1
fi

# Check if the provided paths exist.

if [ ! -e "$file1" ] || [ ! -e "$file2" ]; then
  zenity --error --text="One or both of the selected files or folders do not exist."
  exit 1
fi

# SCRIPT_EXECUTION
# ----------------

# Swap the names of the two files or folders.

mv "$file1" "$file1.tmp" &&
  mv "$file2" "$file1" &&
  mv "$file1.tmp" "$file2"

exit 0
