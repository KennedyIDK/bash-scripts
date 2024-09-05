#!/usr/bin/env bash

# NAME        : bak
#
# DESCRIPTION : Creates a timestamped copy of a file or directory and gives you
#               the option to move it to a location directory. The default location
#               directory is $HOME/backups. Location directory will be created if
#               it doesn't exist.
#
# ==============================================================================

# -----------------------
# CONFIGURATION_VARIABLES
# -----------------------

location_dir="$HOME/backups/"                  # Location directory for backups.
timestamp="$(date +'%Y-%m-%d_(%H:%M)')"        # Timestamp format.
timestampsecs="$(date +'%Y-%m-%d_(%H:%M:%S)')" # Avoid overwriting backups.

# ---------
# VARIABLES
# ---------

backup_file="$(basename "$1")_$timestamp.bak"         # Backup name for files.
backup_filesecs="$(basename "$1")_$timestampsecs.bak" # Avoid overwriting backups.
backup_dir="$(basename "$1")_$timestamp.bak"          # Backup name for directories.
backup_dirsecs="$(basename "$1")_$timestampsecs.bak"  # Avoid overwriting backups.

# ---------
# FUNCTIONS
# ---------

create_backup() {
  # Create a time-stamped backup of the original file or directory.

  if [ -f "$1" ]; then # If the provided path is a file.
    if [ -e "$backup_file" ]; then
      if cp "$1" "$backup_filesecs"; then
        echo "Backup of '$1' created as '$backup_filesecs'"
      else
        echo "Failed to create backup." >&2
        exit 1
      fi
    else
      if cp "$1" "$backup_file"; then
        echo "Backup of '$1' created as '$backup_file'"
      else
        echo "Failed to create backup." >&2
        exit 1
      fi
    fi
  elif [ -d "$1" ]; then # If the provided path is a directory.
    if [ -e "$backup_dir" ]; then
      if cp -r "$1" "$backup_dirsecs"; then
        echo "Backup of directory '$1' created as '$backup_dirsecs'"
      else
        echo "Failed to create backup." >&2
        exit 1
      fi
    else
      if cp -r "$1" "$backup_dir"; then
        echo "Backup of directory '$1' created as '$backup_dir'"
      else
        echo "Failed to create backup." >&2
        exit 1
      fi
    fi
  else
    echo "Unsupported type for '$1'. Please provide a valid file or directory." >&2
    exit 1
  fi
}

move_backup() {
  # Move the time-stamped backup to the specified location directory.

  # Create location directory if it doesn't exist.

  mkdir -p "$location_dir"

  # Move the time-stamped backup to the specified location directory.

  if [ -f "$backup_file" ]; then
    mv "$backup_file" "$location_dir" && echo "Backup moved to '$location_dir'" ||
      echo "Failed to move backup." >&2
  elif [ -d "$backup_dir" ]; then
    mv "$backup_dir" "$location_dir" && echo "Backup moved to '$location_dir'" ||
      echo "Failed to move backup." >&2
  fi
}

# ------
# CHECKS
# ------

# Check if a filename or directory was provided as an argument.

if [ $# -eq 0 ]; then
  echo "Usage: bak <file or dir>" >&2
  exit 1
fi

# Check if the provided path exists.

if [ ! -e "$1" ]; then
  echo "Path '$1' not found." >&2
  exit 1
fi

# ----------------
# SCRIPT_EXECUTION
# ----------------

echo -e "--- 🐘 BAK 🐘 ---\n"

# Create a time-stamped backup of the original file or directory.

create_backup "$1"
echo

# Prompt to move the backup to the specified location.

read -r -p "Do you want to move the backup to '$location_dir'? (y/*): " move_backup_choice
echo

if [ "$move_backup_choice" == "y" ]; then
  move_backup
else
  echo "Backup will remain in the current directory."
fi

exit 0
