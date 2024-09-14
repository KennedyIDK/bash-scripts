#!/usr/bin/env bash

# Name        : thunar-verify-sha256

# Description : Verify sha256 via thunar context menu.

# =============================================================================

# Prompt user for expected SHA256 checksum.

expected_checksum=$(zenity --entry --title="Verify SHA256 Checksum" \
  --text="Enter the expected SHA256 checksum:")

# If user cancels or no input, exit.

if [ -z "$expected_checksum" ]; then
  exit 1
fi

# Calculate the actual SHA256 checksum of the file.

actual_checksum=$(sha256sum "$1" | awk '{print $1}')

# Compare expected and actual checksums.

if [ "$expected_checksum" == "$actual_checksum" ]; then
  zenity --info --title="Checksum Verification" --text="✅ Checksums match!"
else
  zenity --error --title="Checksum Verification" --text="⛔ Checksums do not match!"
fi

exit 0
