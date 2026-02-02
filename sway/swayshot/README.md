# swayshot

Take region screenshots using grim and slurp. Copies to clipboard and saves to file.

Adding `named` as an argument will prompt for a custom filename using rofi.

## Usage

Apply to hotkey in window manager configuration (e.g. Sway):

```
bindsym Print exec $HOME/bin/sway/swayshot.sh
bindsym Shift+Print exec $HOME/bin/sway/swayshot.sh named
```

## Dependencies

- grim
- slurp
- rofi
- wl-copy (optional, for clipboard)
- notify-send (optional, for notifications)

## Installation

Install to `$HOME/bin`:

```bash
curl -o ~/bin/swayshot.sh https://raw.githubusercontent.com/KennedyIDK/bash-scripts/main/sway/swayshot/swayshot.sh
```

Make it executable:

```bash
chmod u+x ~/bin/swayshot.sh
```

## Configuration

Set the output directory by editing the `output_dir` variable (default `$HOME/screenshots`).

## Troubleshooting

If the script does not work, run it in the terminal and check the exit code:

```bash
swayshot.sh
echo $?
```

| Exit Code | Error                           |
| :-------: | ------------------------------- |
| 127       | Missing required commands       |
| 11        | Failed to create output directory |
| 12        | Failed to take screenshot       |
