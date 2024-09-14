# Terminal Header

This is a simple terminal header that I have set to run in my .bashrc file.

---

It displays the following information:

- Welcome message based on hostname
- System uptime
- VPN connection status
- Recent backups
- Warning if backups are out of date

![](header-screenshot.png)

This script assumes that the backup logs are stored in the log_dir directory, with the following structure:
local backup logs: rsync/local/
cloud backup logs: rclone/
other backup logs: rsync/other/

With the following naming convention: `rclone/rsync_YYYY-MM-DD_(HH:MM).log`

The [backup scripts](https://github.com/KennedyIDK/bash-scripts/tree/main/backup-scripts) in this repository generate logs that follow this naming convention.

### Installation

Install the script to a directory. For example, to install to `/usr/local/bin`:
```sh
mkdir -p ~/.local/bin
curl https://raw.githubusercontent.com/KennedyIDK/bash-scripts/main/general-scripts/terminal_header/terminal_header.sh -o ~/.local/bin/terminal_header.sh
```

Make the script executable:
```sh
chmod +x ~/.local/bin/terminal_header.sh
```

Add the following line to your .bashrc file:
```sh
~/.local/bin/terminal_header.sh
```

You can omit the full path to the script if it is in your PATH.
