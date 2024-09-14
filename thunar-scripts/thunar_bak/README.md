# Thanar Bak

`thunar_bak` is a Bash script designed to create timestamped backups of files or directories directly from the Thunar file manager's context menu.

If you right-click on a file named `example.txt`, the script will create a backup file named `example.txt_2023-10-03_(14:30).bak`.

## Semi-requisites:

**Zenity**: This script uses `zenity` to display error messages.

## Installation

1. Download the script:
```bash
mkdir -p ~/.local/bin
curl https://github.com/KennedyIDK/bash-scripts/blob/main/thunar-scripts/thunar_bak/thunar_bak.sh -o ~/.local/bin/thunar_bak.sh
```
2. Make it executable:
```bash
chmod +x ~/.local/bin/thunar_bak.sh
```
3. Remove the `.sh` extension (optional):
```bash
mv ~/.local/bin/thunar_bak.sh ~/.local/bin/thunar_bak
```
4. To add the script to the Thunar context menu, you can create a custom action:
- Open Thunar and go to `Edit` > `Configure custom actions...`.
- Click on the `+` button to add a new action.
- In the "Basic" tab, set the following:
  - **Name**: Backup
  - **Description**: Create a timestamped backup of the selected file or directory.
  - **Command**: `/path/to/thunar_bak %f` (replace `/path/to/thunar_bak` with the actual path to your script).
- In the "Appearance Conditions" tab, check the boxes to make the action available for both files and directories.
- Click "OK" to save the custom action.

## Configuration

The script does not require any specific configuration, but you can modify the backup filename format if desired.
