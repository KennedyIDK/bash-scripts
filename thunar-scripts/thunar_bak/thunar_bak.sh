#!/usr/bin/env bash

# Name        : thunar_bak

# Description : Creates a timestamped copy of a file or directory
#               via thunar context menu.

# =============================================================================

# CONFIGURATION_VARIABLES
# -----------------------

backup_dir="$(basename "$1")_$(date +'%Y-%m-%d_(%H:%M)').bak"
backup_file="$(basename "$1")_$(date +'%Y-%m-%d_(%H:%M)').bak"
backup_dirsecs="$(basename "$1")_$(date +'%Y-%m-%d_(%H:%M:%S)').bak"
backup_filesecs="$(basename "$1")_$(date +'%Y-%m-%d_(%H:%M:%S)').bak"

# SCRIPT_EXECUTION
# ----------------

# Create a time-stamped backup of the original file or directory.

if [ -f "$1" ]; then
  if [ -e "$backup_file" ]; then
    cp "$1" "$backup_filesecs"
  else
    cp "$1" "$backup_file"
  fi
elif [ -d "$1" ]; then
  if [ -e "$backup_dir" ]; then
    cp -r "$1" "$backup_dirsecs"
  else
    cp -r "$1" "$backup_dir"
  fi
else
  zenity --error --text="Error creating backup."
  exit 1
fi

exit 0
