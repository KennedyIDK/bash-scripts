# link-shorten

A script to shorten URLs using a URL shortener and copy to clipboard. Can be run from the terminal with a URL argument or non-interactively using a system hotkey (reads from clipboard).

## Usage

### Terminal

```bash
link-shorten <url>
```

### Hotkey

Bind to keymap in window manager config (e.g. Sway):

```
bindsym $mod+Shift+l exec $HOME/bin/link-shorten
```

## External Commands

- [curl](https://curl.se/)
- [notify-send](https://gitlab.gnome.org/GNOME/libnotify)
- [wl-copy](https://github.com/bugaevc/wl-clipboard) (Wayland) or [xclip](https://github.com/astrand/xclip) (X11)

## Required Functions

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
curl -o ~/bin/link-shorten https://raw.githubusercontent.com/KennedyIDK/bash-scripts/main/other/link-shorten/link-shorten && chmod u+x ~/bin/link-shorten
```
