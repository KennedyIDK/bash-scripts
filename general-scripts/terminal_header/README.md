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
- rsync/local/: local backup logs
- rclone/: cloud backup logs
- rsync/other/: other backup logs

### Installation

