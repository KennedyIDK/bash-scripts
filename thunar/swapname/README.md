# swapname

Swap two filenames via file manager context menu.

## Usage

Add as a Thunar custom action:

- **Name**: Swap Filenames
- **Command**: `$HOME/bin/thunar/thunar-swapname.sh %F`
- **Appearance Conditions**: Other files, multiple selection

Select exactly two files in the same directory, right-click, and select the action.

## Dependencies

- notify-send

## Installation

Install to `$HOME/bin/thunar`:

```bash
mkdir -p ~/bin/thunar && curl -o ~/bin/thunar/thunar-swapname.sh https://raw.githubusercontent.com/KennedyIDK/bash-scripts/main/thunar/swapname/thunar-swapname.sh && chmod u+x ~/bin/thunar/thunar-swapname.sh
```

## Troubleshooting

Run the script from the terminal to check the exit code:

```bash
thunar-swapname.sh file1.txt file2.txt
echo $?
```

| Exit Code | Error                                      |
| :-------: | ------------------------------------------ |
| 11        | Incorrect number of arguments              |
| 12        | Files don't exist, are the same, or in different directories |
| 13        | Failed to swap filenames                   |
