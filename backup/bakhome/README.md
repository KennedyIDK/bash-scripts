# bakhome

Backup home directory to an external drive using rsync.

## Usage

```bash
bakhome [OPTIONS]
```

### Options

```
-d       Run in dry run mode
-h       Show help message
```

## Dependencies

### External Commands

- rsync

### Required Functions

- script_setup
- ansify_string
- check_required_commands
- print_exit_code
- err
- warn
- deb

To install all required functions to `$HOME/bin/.functions`:

```bash
mkdir -p ~/bin/.functions && cd ~/bin/.functions && for func in script_setup ansify_string check_required_commands print_exit_code err warn deb; do curl -sO https://raw.githubusercontent.com/KennedyIDK/bash-scripts/main/.functions/$func; done
```

## Installation

To install the script to `$HOME/bin`:

```bash
curl -o ~/bin/bakhome https://raw.githubusercontent.com/KennedyIDK/bash-scripts/main/backup/bakhome/bakhome && chmod u+x ~/bin/bakhome
```

## Configuration

### Variables

Edit the script to configure the following variables:

- `_MULTIPLE_SYSTEMS` - Set to `true` to use hostname-based subdirectories on the backup drive (useful when backing up multiple machines to the same drive)
- `_BACKUP_SOURCE` - Source directory to backup (defaults to `$HOME/`)
- `_BACKUP_LOCATION` - Backup destination
- `_VERSIONED` - Set to `true` to enable versioned backups
- `_VERSIONED_BACKUPS` - Array of directories to create timestamped versioned backups for

### Exclude File

Create an rsync exclude file at `$HOME/.config/rsync/${HOSTNAME}_rsync_exclude.txt` to specify files and directories to exclude from the backup. Example:

```
.cache/
.local/share/Trash/
*.tmp
```

If the exclude file doesn't exist, the script will warn the user and prompt to continue without it.
