# ☔ Backloud

### Description

> "Be careful of the storm; it can wash away the things you thought were permanent." — Unknown quote from the internet.

[`backloud`](backloud.sh) is a Bash script designed to automate the backup of files to cloud storage using [rclone](https://rclone.org/). 

It provides a simple way to sync important files and directories to a cloud storage remote, including encrypted backups for sensitive data.

### Usage
```sh
backloud.sh
```

### Requirements

- **rclone**: Ensure that [rclone](https://rclone.org/downloads/) is installed on your system.
- **rclone Configuration**: You must have a valid rclone configuration located at `~/.config/rclone/rclone.conf`. 

If you have never used rclone before, follow the [rclone configuration guide](https://rclone.org/docs/#configuration) to set it up. 

I like to have two remotes, one encrypted and one unencrypted. The encrypted remote is used to store sensitive data, while the unencrypted remote is used to store everything else. This way, I can easily share or restore non-sensitive data without needing to decrypt it first.

If you would rather encrypt all of your data, or if you don't have any sensitive data, you can use a single remote for both encrypted and unencrypted data, and edit the script to remove the redundant section.

### Installation

Install the script to a directory in your PATH. For example, to install to `/usr/local/bin`:
```sh
mkdir -p ~/.local/bin
curl https://github.com/KennedyIDK/bash-scripts/backup-scripts/backloud/backloud.sh -o ~/.local/bin/backloud.sh
```

Make the script executable:
```sh
chmod +x ~/.local/bin/backloud.sh
```

Remove the .sh extension (optional):
```sh
mv ~/.local/bin/backloud.sh ~/.local/bin/backloud
```

### Configuration

You will need to configure the script for your specific use case.

#### Remotes 
Edit the variables at the top of the script to specify the remotes you want to use. Locations should be defined in the format `remote:path`. For example, if you have a remote named `gdrive` and you want to backup to the `backup` directory, you would set `remotes="gdrive:backup"`. 

It should look something like this:*
```sh
ghome="gdrive:backups"          # Google Drive home directory.
gshare="gdrive:sharing"         # Google Drive shared directory.
gcrypt="encrypted_gdrive:"      # Google Drive encrypted directory.
```
\* Variables (and functions) were named for personal use with Google Drive. Be sure to change all the the variables if you edit them to match your cloud storage provider.

#### Log file
The script creates a log file. By default the log file is located at `$HOME/backups/logs/rclone`. You can change the location and format of the log file by editing the `log_file` variables.

#### Rclone flags
Edit the `rclone_flags` variable at the top of the script to specify any additional flags you want to use with the rclone sync command. Default flags are `--links --verbose`. 

The `--dry-run` flag is also enabled by default. This is so you can ensure the script functions as expected before making any changes to your cloud storage. 

Once you are satisfied with the output of the log file, you can remove the `--dry-run` flag from the `rclone_flags` variable to perform the actual sync.

#### Files & Directories
You will need to specify the files and directories you want to backup under `# SCRIPT_EXECUTION`. The usage of the sync command is as follows:
```sh
syncgd <source> <destination>
```

Some files and directories are included by default to give you an idea of how to use the script:*
```sh
# SYNC ENCRYPTED FILES

echo -e "\n🔒 Encrypting files...\n"

syncgd ~/.config "$gcrypt/$HOSTNAME/config"
syncgd ~/.bashrc "$gcrypt/$HOSTNAME/bashrc"
syncgd ~/.bash_history "$gcrypt/$HOSTNAME/bash_history"

# SYNC OTHER FILES

echo -e "\n📁 Syncing other files...\n"

syncgd ~/Music "$ghome/Music"
syncgd ~/Pictures "$ghome/Pictures"
```
\* I use `$HOSTNAME` to separate backups by machine in the same rclone remote.

You can add as many files and directories as you like. Be sure to test the script with the `--dry-run` flag enabled to ensure it functions as expected.

There is a commented out section with examples especially for shared directories. You can uncomment and edit this section to backup directories for sharing via cloud storage, or remove it if you don't need it.
```sh
# SYNC SHARED FILES

# Commented out as not default directories, add your own or remove this section of the script.

# echo -e "\n👥 Syncing shared folders...\n"

# syncgd ~/Sharing/Family "$gshare/Family"
# syncgd ~/Sharing/Friends "$gshare/Friends"
```
