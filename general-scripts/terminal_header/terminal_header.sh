#!/usr/bin/env bash

# Name         : terminal_header

# Description  : Header for terminal sessions.

# ==============================================================================

# CONFIGURATION_VARIABLES
# ------------------------

desktop_hotstname="$HOSTNAME"
desktop_message="Welcome back, $USER"

laptop_hostname=""
laptop_message=""

log_dir="/home/iain/backups/logs"
local_warning="6"
cloud_warning="1"
other_warning="119"

# SCRIPT_EXECUTION
# ----------------

# Display system welcome message and uptime.

echo
if [ "$HOSTNAME" = "$laptop_hostname" ]; then
  echo "$laptop_message"
  echo
  echo "💻 The system has been running for $(uptime -p | sed 's/up /for /')."
elif [ "$HOSTNAME" = "$desktop_hotstname" ]; then
  echo "$desktop_message"
  echo
  echo "🖥️ The system has been running for $(uptime -p | sed 's/up /for /')."
fi

# Display VPN status.

if ! command -v nordvpn &>/dev/null; then
  echo
  echo "🌐 VPN is not installed."
else
  echo
  echo "🌐 $(nordvpn status | grep -E 'VPN|Status|Server|City' |
    awk '{gsub("Status:", "VPN"); printf "%s, ", $0}' | sed 's/, $//')"
fi

# Display recent backups.

echo

# 1. Local backups

if [ -n "$(find $log_dir/rsync/local/ -name 'rsync_*' -printf '.' | head -c 1)" ]; then
  latest_local=$(find $log_dir/rsync/local/ -name 'rsync_*' -printf '%T@ %p\n' | sort -n | tail -n 1 | cut -d' ' -f2-)
  echo "🏡 : $(date -d "@$(stat --format='%Y' "$latest_local")" '+%Y-%m-%d (%H:%M)')"
else
  echo -e "🏡 : \033[31mNo backups found.\033[0m"
fi

# 2. Cloud backups

if [ -n "$(find $log_dir/rclone/ -name 'rclone_*' -printf '.' | head -c 1)" ]; then
  latest_cloud=$(find $log_dir/rclone/ -name 'rclone_*' -printf '%T@ %p\n' | sort -n | tail -n 1 | cut -d' ' -f2-)
  echo "☔ : $(date -d "@$(stat --format='%Y' "$latest_cloud")" '+%Y-%m-%d (%H:%M)')"
else
  echo -e "☔ : \033[31mNo backups found.\033[0m"
fi

# 3. Other backups

if [ -n "$(find $log_dir/rsync/other/ -name 'rsync_*' -printf '.' | head -c 1)" ]; then
  latest_other=$(find $log_dir/rsync/other/ -name 'rsync_*' -printf '%T@ %p\n' | sort -n | tail -n 1 | cut -d' ' -f2-)
  echo "🧊 : $(date -d "@$(stat --format='%Y' "$latest_other")" '+%Y-%m-%d (%H:%M)')"
else
  echo -e "🧊 : \033[31mNo backups found.\033[0m"
fi

# Warn if you need to bak up.

echo

# Local
if [ -n "$latest_local" ]; then
  days_old=$((($(date +%s) - $(stat --format='%Y' "$latest_local")) / 86400))
  if [ "$days_old" -gt "$local_warning" ]; then
    echo -e "Warning: Local backup is \033[33m$days_old\033[0m days old."
  fi
fi

# Cloud
if [ -n "$latest_cloud" ]; then
  days_old=$((($(date +%s) - $(stat --format='%Y' "$latest_cloud")) / 86400))
  if [ "$days_old" -gt "$cloud_warning" ]; then
    echo -e "Warning: Cloud backup is \033[33m$days_old\033[0m days old."
  fi
fi

# Other
if [ -n "$latest_other" ]; then
  days_old=$((($(date +%s) - $(stat --format='%Y' "$latest_other")) / 86400))
  if [ "$days_old" -gt "$other_warning" ]; then
    echo -e "Warning: Other backup is \033[33m$days_old\033[0m days old."
  fi
fi

echo
