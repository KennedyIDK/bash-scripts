# Obsidian Todo

This script is intended to be used with the [Obsidian](https://obsidian.md/) note-taking app, but will work with any directory containing markdown files.

It uses zenity to open a text input dialog, allowing you to quickly add a todo item to a note in Obsidian at a specific location (the top of your todo list, for example).

It is intended to bound to a hotkey.

## Prerequisites

Before using this script, ensure you have zenity installed.

## Notes

On wayland, `wl-paste` is used to get the clipboard contents - you will need to copy the selected contents to the system clipboard yourself. On X11 it's a single hotkey press to copy the selected text to the clipboard and append it to the note.

## Configuration

You will need to input the path to your selected todo type note in the variable at the top of the script, as well as the location in the note where you want the todo to be added. Note that the variable `preceding_line_number` expects the line **before** the target line.

By default, the script will add the todo item as a checkbox. If you want to alter the markdown syntax, you can change the `prepend_text` variable.

## Installation

Install the script to a directory of your choice. For example, to install to `~/.local/bin`:
```sh
mkdir -p ~/.local/bin
curl https://raw.githubusercontent.com/KennedyIDK/bash-scripts/main/obsidian-scripts/obs_todo/obs_todo.sh -o ~/.local/bin/obs_todo.sh
```

Make the script executable:
```sh
chmod +x ~/.local/bin/obs_todo.sh
```

Remove the .sh extension (optional):
```sh
mv ~/.local/bin/obs_todo.sh ~/.local/bin/obs_todo
```

Lastly, bind the script to a hotkey of your choice in your window manager or desktop environment settings.
