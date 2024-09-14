# Thunar Rename Lowercase

`thunar_lowercase.sh` is a Bash script designed to rename selected files and directories to lowercase and replace spaces with underscores directly from the Thunar file manager's context menu.

## Semi-requisites:

Zenity: This script uses zenity to display error messages.

## Installation:

1. Download the script:

```bash
mkdir -p ~/.local/bin
curl https://github.com/KennedyIDK/bash-scripts/blob/main/thunar-scripts/thunar_lowercase/thunar_lowercase.sh -o ~/.local/bin/thunar_lowercase.sh
```
2. Make it executable:
```bash
chmod +x ~/.local/bin/thunar_lowercase.sh
```

3. Remove the .sh extension (optional):
``` bash
mv ~/.local/bin/thunar_lowercase.sh ~/.local/bin/thunar_lowercase
```
4. To add the script to the Thunar context menu, you can create a custom action:
- Open Thunar and go to Edit > Configure custom actions....
- Click on the + button to add a new action.
- In the "Basic" tab, set the following:
    - **Name**: Rename to Lowercase
    - **Description**: Rename selected files and directories to lowercase and replace spaces with underscores.
    - **Command**: /path/to/thunar_rename_lowercase %F (replace /path/to/thunar_rename_lowercase with the actual path to your script).
- In the "Appearance Conditions" tab, check the boxes to make the action available for files and directories.
- Click "OK" to save the custom action.

## Configuration

The script does not require any specific configuration, but it will log any errors encountered during the renaming process to a log file located at ~/appdata/thunar/rename_lowercase_<timestamp>.log.
