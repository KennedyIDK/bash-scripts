#!/usr/bin/env bash

# Name        : thunar_mp3oncat

# Description : Concatenate audio files via thunar context menu.

# =============================================================================

# VARIABLES
# ---------

output_dir=$(dirname "$1")
extension="${1##*.}"

# CHECKS
# ------

# Check if ffmpeg is installed.

if ! command -v ffmpeg &>/dev/null; then
  zenity --error --text="ffmpeg is not installed."
  exit 1
fi

# SCRIPT_EXECUTION
# ----------------

# Check if at least two audio files are selected.

if [ "$#" -ge 2 ]; then

  # Prompt for a filename.

  output_file=$(zenity --entry --title="Concatenate Audio Files" \
    --text="Enter the name of the output file -ext:")

  # Append the extension to the output file name.

  output_file="${output_file}.${extension}"

  if [ -z "$output_file" ]; then
    exit 1
  fi

  # Concatenate the audio files.

  if ! ffmpeg -i "concat:$(printf '%s|' "$@" | sed 's/|$//')" -c copy "$output_dir/$output_file"; then
    zenity --error --text="An error occurred while concatenating the audio files."
    exit 1
  fi
else
  exit 1
fi

exit 0
