# gammatoggle

Toggle gammastep (colour temperature adjustment) on and off.

## Usage

Apply to hotkey in window manager configuration (e.g. Sway):

```
bindsym $mod+g exec $HOME/bin/sway/gammatoggle.sh
```

Apply to status bar module (e.g. Waybar backlight module):

```
"backlight": {
  "on-click-middle": "$HOME/bin/sway/gammatoggle.sh"
},
```

## Dependencies

- gammastep

## Installation

Install to `$HOME/bin`:

```bash
curl -o ~/bin/gammatoggle.sh https://raw.githubusercontent.com/KennedyIDK/bash-scripts/main/sway/gammatoggle/gammatoggle.sh
```

Make it executable:

```bash
chmod u+x ~/bin/gammatoggle.sh
```

## Configuration

Set the gammastep temperature by editing the `gammastep_temp` variable (default 4500).

## Troubleshooting

If the script does not work, run it in the terminal and check the exit code:

```bash
gammatoggle.sh
echo $?
```

| Exit Code | Error                        |
| :-------: | ---------------------------- |
| 127       | Missing required commands    |
| 11        | Failed to start Gammastep |
