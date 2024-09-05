#!/usr/bin/env bash

# NAME        : backcloud

# DESCRIPTION : Backup files to cloud storage using rclone.

# =============================================================================

# -----------------------
# CONFIGURATION_VARIABLES
# -----------------------

ghome= # Root for backup files in rclone remote.
# gshare= # Uncomment if using  a specific path for shared folders.
gcrypt= # Encrypted rclone remote.

rclone_flags="--verbose --links --dry-run" # rclone flags. Remove --dry-run to sync files.

log_file_dir="$HOME/backups/logs/rclone/"                # Directory for log files.
log_file_format="rclone_$(date +"%Y-%m-%d_(%H:%M)").log" # Log filename format.

# ---------
# FUNCTIONS
# ---------

syncgd() {
  # Sync files to Google Drive.

  local source="$1"
  local destination="$2"
  local log_file="$log_file_dir$log_file_format"
  local rclone_sync="rclone sync $rclone_flags --log-file $log_file $source $destination"
  local source_name
  source_name="$(basename "$source")"

  if $rclone_sync; then
    if [ -f "$source" ]; then
      echo "$source_name"
    elif [ -d "$source" ]; then
      echo "/$source_name"
    fi
  else
    echo "Error syncing $source. Check the log file for details." >>"$log_file"
  fi

}

# ------
# CHECKS
# ------

# Check for rclone.

if ! command -v rclone &>/dev/null; then
  echo "Error: rclone is not installed. Please install it." >&2
  exit 1
fi

# Check for rclone config.

if [ ! -f "$HOME/.config/rclone/rclone.conf" ]; then
  echo "Error: rclone config not found. Please configure rclone." >&2
  exit 1
fi

# Ensure log file directory exists.

mkdir -p "$log_file_dir"

# ----------------
# SCRIPT_EXECUTION
# ----------------

# Reset SECONDS to start timing.

SECONDS=0

echo "--- ☔ BAKCLOUD ☔ ---"

# SYNC ENCRYPTED FILES

echo -e "\n🔒 Encrypting files...\n"

# I use $HOSTNAME to separate backups by machine in the same rclone remote.

syncgd ~/.config "$gcrypt/$HOSTNAME/config"
syncgd ~/.bashrc "$gcrypt/$HOSTNAME/bashrc"
syncgd ~/.bash_history "$gcrypt/$HOSTNAME/bash_history"

# SYNC OTHER FILES

echo -e "\n📁 Syncing other files...\n"

syncgd ~/Music "$ghome/Music"
syncgd ~/Pictures "$ghome/Pictures"

# SYNC SHARED FILES

# Commented out as not default directories, add your own or remove this section of the script.

# echo -e "\n👥 Syncing shared folders...\n"

# syncgd ~/Sharing/Family "$gshare/Family"
# syncgd ~/Sharing/Friends "$gshare/Friends"

echo -e "\nComplete. Backup took $SECONDS seconds.\n"

echo "Output saved to: file://$log_file_dir$log_file_format"

exit 0
