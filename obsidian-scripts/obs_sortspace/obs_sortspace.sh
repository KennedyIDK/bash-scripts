#!/usr/bin/env bash

# Name        : obsidian_sortspace

# Description : Append selected text to obsidian sortspace file.

# =============================================================================

# CONFIGURATION_VARIABLES
# -----------------------

sortspace_file="$HOME/obsidian/_sortspace.md"

# CHECKS
# ------

# Check for wl-paste or xclip.
if ! command -v wl-paste &>/dev/null && ! command -v xclip &>/dev/null; then
  echo "Error: wl-paste or xclip is required but not installed. Aborting." >&2
  exit 1
fi

# SCRIPT_EXECUTION
# ----------------

# Check if the session is Wayland or X11 and copy the selected text accordingly.

if [ "$XDG_SESSION_TYPE" == "wayland" ]; then
  selected_text=$(wl-paste)
else
  selected_text=$(xclip -o)
fi

# Append the selected text to the markdown file preceded by a blank line.

echo >>"$sortspace_file" &&
  echo "$selected_text" >>"$sortspace_file" &&

  # Display the appended text using zenity.
  zenity --info --title="Obsidian" --text="Added to Sortspace:\n\n$selected_text" --timeout=2

exit 0
