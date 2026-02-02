# swipe-move-workspace

Move the focused container to the previous or next workspace using three-finger touchpad swipes.

Workspaces wrap around (1 to 10, 10 to 1).

## Usage

Apply to touchpad gestures in Sway configuration:

```
bindgesture swipe:3:left exec $HOME/bin/sway/swipe-move-workspace.sh next
bindgesture swipe:3:right exec $HOME/bin/sway/swipe-move-workspace.sh prev
```

### Arguments

```
prev    Move to previous workspace
next    Move to next workspace
```

## Dependencies

- swaymsg
- jq

## Installation

Install to `$HOME/bin`:

```bash
curl -o ~/bin/swipe-move-workspace.sh https://raw.githubusercontent.com/KennedyIDK/bash-scripts/main/sway/swipe-move-workspace/swipe-move-workspace.sh
```

Make it executable:

```bash
chmod u+x ~/bin/swipe-move-workspace.sh
```

## Troubleshooting

If the script does not work, run it in the terminal and check the exit code:

```bash
swipe-move-workspace.sh next
echo $?
```

| Exit Code | Error                              |
| :-------: | ---------------------------------- |
| 127       | Missing required commands          |
| 11        | No direction specified             |
| 12        | No focused workspace found         |
| 13        | Invalid direction                  |
| 14        | Invalid workspace - must be a number |
| 15        | Failed to move workspace           |
