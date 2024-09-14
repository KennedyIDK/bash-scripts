# 🏡 Backhome

[`backhome`](backhome.sh) is a simple script that backs up files and directories to a specified location on an external drive using rsync.

It is intended to be run manually, but can be automated using a cron job or other automation tool.

### Usage
```sh
backhome.sh
```

### Requirements

The script uses `rsync` to copy files and directories to the backup location. rsync is pre-installed on many sytems, but can be installed if necessary.

To verify if you have rsync installed, run:
```sh
rsync --version
```

### Installation

Install the script to a directory in your PATH. For example, to install to `/usr/local/bin`:
```sh
mkdir -p ~/.local/bin
curl https://raw.githubusercontent.com/KennedyIDK/bash-scripts/main/backup-scripts/backhome/backhome.sh -o ~/.local/bin/backhome.sh
```

Make the script executable:
```sh
chmod +x ~/.local/bin/backhome.sh
```

Remove the .sh extension (optional):
```sh
mv ~/.local/bin/backhome.sh ~/.local/bin/backhome
```

### Configuration

You will need to configure the destination directory by modifying the `backup_drive` variable. This should be the path to the directory where you want to store the backups.

By default the script will backup the contents of the user's home directory. You can change this by modifying the `backup_source` variable.

It should look something like this:
```sh
backup_source="$HOME/"                      # Source directory to backup.

backup_drive="/run/media/iain/backup_drive" # External drive destination directory.
```

The script is intended to be run with an exclude file that contains a list of files and directories to omit from the backup. You can edit the `exclude_file` variable to specify the path to an exclude file.

If you run the script without an exclude file, it will prompt you to confirm that you want to run the backup without excluding any files.

To create a basic exclude file that omits `.cache` from the backup, run:
```sh
mkdir -p ~/.config/rsync
touch ~/.config/rsync/backhome-exclude.txt
echo ".cache/" >> ~/.config/rsync/backhome-exclude.txt
```

Then set the `exclude_file` variable in the script to point to the exclude file:
```sh
exclude_file="$HOME/.config/rsync/backhome-exclude.txt" # Exclude file path.
```

To add more files and directories to the exclude file, add the path to the file on a separate line. You might want to exclude directories that contain large amounts of easily replaceable data, like game libraries.
