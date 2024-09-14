# Bash Scripts

This is a collection of Bash scripts that I use daily on Linux.

Please note that you may need to tweak certain variables to tailor the scripts to your specific needs. For detailed configuration information and a list of required dependencies, be sure to check the README files associated with each script.

All scripts have a .sh extension for clarity. 

I have not tested them on other systems capable of running Bash, such as Mac OS.

Iain

## Backup Scripts 

### [bak](backup-scripts/bak)
Creates a timestamped copy of a file or directory and gives you the option to move it to a specified directory.

### [backcloud](backup-scripts/backcloud)
Backs up specified directories to cloud storage using rclone.

### [backhome](backup-scripts/backhome)
Backs up home directory to external drive using rsync.

## General Scritps

### [terminal_header](general-scripts/terminal_header)
Displays a header in the terminal with info on uptime, VPN status, and recent backups.

### [verify_sha256](general-scripts/verify_sha256)
Verifies the SHA256 checksum of a file.

### [walsh](general-scripts/walsh)
For wallpaper sh. Resizes images to common wallpaper resolutions based on the aspect ratio. Used in [Kenya Wallpapers](https://github.com/KennedyIDK/kenya-wallpapers).

