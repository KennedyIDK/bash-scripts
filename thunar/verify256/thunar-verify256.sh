#!/usr/bin/env bash

# Name        : thunar-verify-sha256
#
# Description : Verify sha256 via thunar context menu.
#
# EXITS:
#   11 - zenity is not installed
#   12 - Incorrect number of arguments
#   13 - No expected SHA256 checksum provided or invalid format
#   14 - sha256sum command failed

set -euo pipefail

if ! command -v zenity &>/dev/null; then
	exit 11
fi

[[ "${#}" -eq 1 ]] || exit 12

# Prompt user for expected SHA256 checksum.
if ! expected_checksum=$(zenity --entry --title="Verify SHA256 Checksum" \
	--text="Enter the expected SHA256 checksum:"); then
	# User cancelled - exit silently
	exit 0
fi
[[ -n "$expected_checksum" ]] || exit 13

# Remove whitespace and convert to lowercase
expected_checksum=$(echo "$expected_checksum" | tr -d '[:space:]' | tr '[:upper:]' '[:lower:]')

# Validate checksum format
if ! [[ "$expected_checksum" =~ ^[a-f0-9]{64}$ ]]; then
	zenity --error --title="Invalid Input" \
		--text="Invalid SHA256 checksum format. Expected 64 hexadecimal characters."
	exit 13
fi

# Calculate the actual SHA256 checksum of the file.
if ! actual_checksum=$(sha256sum "$1" 2>&1 | awk '{print tolower($1)}'); then
	zenity --error --title="Checksum Error" \
		--text="Failed to calculate SHA256 checksum for: $(basename "$1")"
	exit 14
fi

# Additional validation that we got a checksum
if [[ -z "$actual_checksum" ]]; then
	zenity --error --title="Checksum Error" \
		--text="sha256sum produced no output for: $(basename "$1")"
	exit 14
fi

# Compare expected and actual checksums.
if [[ "$expected_checksum" == "$actual_checksum" ]]; then
	zenity --info --title="Checksum Verification" --text="✅ Checksums match!"
else
	zenity --error --title="Checksum Verification" --text="⛔ Checksums do not match!"
fi
