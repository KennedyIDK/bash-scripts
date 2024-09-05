#!/usr/bin/env bash

# NAME        : backhome

# DESCRIPTION : Backs up home directory to external drive.

# =============================================================================

# -----------------------
# CONFIGURATION_VARIABLES
# -----------------------

backup_source="$HOME/" # Source directory to backup.

backup_drive="/path/to/backup/destination" # External drive destination directory.

exclude_file="/path/to/exclude/file" # Exclude file for rsync. Optional.

log_file_dir="$HOME/backups/logs/rsync/local/"          # Directory to save log files.
log_file_format="rsync_$(date +"%Y-%m-%d_(%H:%M)").log" # Log file format.

# ---------
# FUNCTIONS
# ---------

perform_backup() {
  # Perform the backup using rsync.

  local rsync_flags=(
    --archive
    --human-readable
    --partial
    --info=progress2
    --info=stats1
    --links
    --xattrs
    --delete
    --delete-excluded
    --log-file="$log_file_dir$log_file_format"
  )

  if [ -f "$exclude_file" ]; then
    local rsync_command=("rsync" "$backup_source" "$backup_drive" "${rsync_flags[@]}" --exclude-from="$exclude_file")
    "${rsync_command[@]}"
    return $?
  else
    local rsync_command=("rsync" "$backup_source" "$backup_drive" "${rsync_flags[@]}")
    echo -e "\nExclude file not found. No files will be excluded from the backup.\n" >&2

    # Give option to cancel backup if no exclude file.

    read -r -p "Do you want to proceed with the backup? (y/n): " confirm_exclude
    if [[ "$confirm_exclude" != [yY] ]]; then
      echo -e "\nExiting without any changes." >&2
      exit 0
    else
      "${rsync_command[@]}"
      return $?
    fi
  fi

}

# ------
# CHECKS
# ------

# Check for rsync.

if ! command -v rsync &>/dev/null; then
  echo -e "\nError: rsync is not installed. Please install it." >&2
  exit 1
fi

# Check for external drive.

if [ ! -d "$backup_drive" ]; then
  echo -e "\nError: External drive not found. Please mount the drive." >&2
  exit 1
fi

# Ensure log file directory exists.

mkdir -p "$log_file_dir"

# ----------------
# SCRIPT_EXECUTION
# ----------------

# Reset SECONDS to start timing.

SECONDS=0

echo "--- 🏡 BAKHOME 🏡 ---"

echo -e "\nBacking up to external drive."
echo -e "\nSyncing with rsync..."

# Perform the backup and capture the status.

if perform_backup; then
  echo -e "\nComplete. Backup took $SECONDS seconds."
  echo -e "\nOutput saved to: file://$log_file_dir$log_file_format"
else
  echo -e "\nBackup failed. Check the log file for details." >&2
  exit 1
fi

exit 0
