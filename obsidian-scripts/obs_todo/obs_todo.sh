#!/usr/bin/env bash

# Name        : obsidian_todo

# Description : Opens a text box to quickly append text to Obsidian todo list.

# =============================================================================

# CONFIGURATION_VARIABLES
# -----------------------

destination_file="$HOME/obsidian/_to do list.md"
preceding_line_number=9
message_prompt="Add To Do:"
prepend_text="- [ ] "
message_success="Updated to do list!"

# SCRIPT_EXECUTION
# ----------------

text=$(zenity --entry --title="Obsidian" --text="$message_prompt") &&
  sed -i "${preceding_line_number}{h;s/.*/${prepend_text}${text}/;x;G}" "$destination_file" &&
  zenity --notification --text="$message_success"

exit 0
