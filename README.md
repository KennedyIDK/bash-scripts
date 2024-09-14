# Bash Scripts

This is a collection of Bash scripts that I use daily on Linux.

Please note that you may need to tweak certain variables to tailor the scripts to your specific needs. For detailed configuration information and a list of required dependencies, be sure to check the README files associated with each script.

Scripts have a .sh extension for clarity. 

I have not tested them on other systems capable of running Bash, such as Mac OS.

Iain

## Backup Scripts 

#### [bak](backup-scripts/bak)
Creates a timestamped copy of a file or directory and gives you the option to move it to a specified directory.

#### [backcloud](backup-scripts/backcloud)
Backs up specified directories to cloud storage using rclone.

#### [backhome](backup-scripts/backhome)
Backs up home directory to external drive using rsync.

## General Scritps

#### [terminal_header](general-scripts/terminal_header)
Displays a header in the terminal with info on uptime, VPN status, and recent backups.

#### [verify_sha256](general-scripts/verify_sha256)
Verifies the SHA256 checksum of a file.

#### [walsh](general-scripts/walsh)
Resizes images to common wallpaper resolutions based on the aspect ratio. Used in [Kenya Wallpapers](https://github.com/KennedyIDK/kenya-wallpapers).

## Obsidian Scripts

#### [obs_sortspace](obsidian-scripts/obs_sortspace)
Appends text you have selected to the end of a note in Obsdian, preceeded by a blank line. Hotkey.

#### [obs_todo](obsidian-scripts/obs_todo)
Appends a to-do item to a specified location within a note in Obsidian. Hotkey.

#### [recipe_lint](obsidian-scripts/recipe_lint)
Clean up recipes downloaded from The New York Times (NYT) Cooking website for printing/use in Obsidian.

## Thunar Custom Actions

#### [thunar_bak](thunar-scripts/thunar_bak)
Creates a timestamped copy of a file or directory.

#### [thunar_lowercase](thunar-scripts/thunar_lowercase)
Converts selected files to lowercase and replaces spaces with underscores.

#### [thunar_swapname](thunar-scripts/thunar_swapname)
Swaps the names of two selected files.

#### [thunar_verify256](thunar-scripts/thunar_verify256)
Verifies the SHA256 checksum of a file.
