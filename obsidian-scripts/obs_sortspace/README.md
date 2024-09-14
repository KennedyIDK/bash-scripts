# Obsidian Sortspace

This script is intended to be used with the [Obsidian](https://obsidian.md/) note-taking app, but will work with any directory containing markdown files.

All it does is append text you have selected to the end of a note in Obsdian, preceeded by a blank line. I find it useful for quickly adding to Obsidian without having to switch windows. 

It is intended to be bound to a system hotkey.

## Prerequisites

Before using this script, ensure you have the following installed:

- `wl-paste` (for Wayland)
- `xclip` (for X11)
- `zenity` (for displaying GUI confirmation)

## Notes

On wayland, `wl-paste` is used to get the clipboard contents - you will need to copy the selected contents to the system clipboard yourself. On X11 it's a single hotkey press to copy the selected text to the clipboard and append it to the note.

## Configuration

You will need to input the path to your selected catch-all type note in the variable at the top of the script.

## Installation

Install the script to a directory of your choice. For example, to install to `~/.local/bin`:
```sh
mkdir -p ~/.local/bin
curl https://raw.githubusercontent.com/KennedyIDK/bash-scripts/main/obsidian-scripts/obs_sortspace/obs_sortspace.sh -o ~/.local/bin/obs_sortspace.sh
```

Make the script executable:
```sh
chmod +x ~/.local/bin/obs_sortspace.sh
```

Remove the .sh extension (optional):
```sh
mv ~/.local/bin/obs_sortspace.sh ~/.local/bin/obs_sortspace
```

---

Lastly, bind the script to a hotkey of your choice in your window manager or desktop environment settings.
