# copyspace

Quickly append selected text to an Obsidian copyspace file using a system-wide hotkey. 

Add `-t` flag for optional timestamp.

## Usage

Bind to keymap in window manager config (e.g. Sway):

```
bindsym $mod+Shift+p exec $HOME/bin/copyspace.sh
bindsym $mod+Shift+Alt+p exec $HOME/bin/copyspace.sh -t
```

## Dependencies

### External Commands

- `wl-copy` (Wayland) or `xclip` (X11)
- `notify-send`

### Required Functions

- script_setup
- check_required_commands
- print_exit_code
- err
- warn
- deb

To install all required functions to `$HOME/bin/.functions`:

```bash
mkdir -p ~/bin/.functions && cd ~/bin/.functions && for func in script_setup check_required_commands print_exit_code err warn deb; do curl -sO https://raw.githubusercontent.com/KennedyIDK/bash-scripts/main/.functions/$func; done
```

## Installation

To install the script to `$HOME/bin`:

```bash
curl -o ~/bin/copyspace.sh https://raw.githubusercontent.com/KennedyIDK/bash-scripts/main/obsidian/copyspace/copyspace.sh && chmod u+x ~/bin/copyspace
```

## Configuration

### Variables

Edit the script to configure the following variables:

- `_COPYSPACE_FILE` - Path to the copyspace file
- `_NOTIFICATION_ICON` - Path to the notification icon (optional)
- `_NOTIFICATION_EXPIRE_TIME` - Notification duration in milliseconds (defaults to 2000)
