# appmute

Toggle mute for a given application using pulseaudio.

I watch a lot of sports on my second monitor, and use this script to quickly mute/unmute advertisment breaks.

## Usage

Bind to keymap in window manager config (e.g. Sway):

```
bindsym $mod+m exec $HOME/bin/sway/appmute.sh <application>

```

## Dependencies

- pactl
- notify-send

## Installation

Install to `$HOME/bin`:

```bash
curl -o ~/bin/appmute.sh https://raw.githubusercontent.com/KennedyIDK/bash-scripts/main/sway/appmute/appmute.sh
```

Make it executable:

```bash
chmod u+x ~/bin/appmute.sh
```

## Troubleshooting

If the script does not work, run it in the terminal and check the exit code:

```bash
appmute.sh <application>
echo $?
```

| Exit Code | Error                        |
| :-------: | ---------------------------- |
| 127       | Missing required commands    |
| 11        | No application name provided |
| 12        | Too many arguments           |
| 13        | Failed to get sink index     |
| 14        | Failed to toggle mute        |
| 15        | No mute status found         |
