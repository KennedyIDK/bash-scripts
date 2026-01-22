# bakcloud

Backup files to cloud storage using rclone.

## Usage

```bash
bakcloud [OPTIONS]
```

### Options

```
-q       Quiet mode
-d       Dry run mode
-E       Edit backup sources file
-X       Edit exclude file
-h       Show help
```

## Required Functions

- script_setup
- check_required_commands
- print_exit_code
- err
- warn
- deb

To install all required functions to `$HOME/bin/.functions`:

```bash
mkdir -p ~/bin/.functions && cd ~/bin/.functions && for func in script_setup check_required_commands print_exit_code err warn deb ; do curl -sO https://raw.githubusercontent.com/KennedyIDK/bash-scripts/main/.functions/$func; done
```

## Installation

To install the script to `$HOME/bin`:

```bash
curl -o ~/bin/bakcloud https://raw.githubusercontent.com/KennedyIDK/bash-scripts/main/backup/bakcloud/bakcloud && chmod u+x ~/bin/bakcloud
```

## Configuration

### Required Files

- `rclone.conf` - rclone configuration. The script design expects at least two configured remotes - encrypted and unencrypted. You will have to update the script to work with your remotes.
- `rclone_exclude.txt` - Exclude patterns (optional)
- `bakcloud-sources` - Backup sources configuration. The backup sources file should define arrays per backup destination:

```bash
# Files to backup with encryption
_ENCRYPT=(
    "$HOME/documents"
    "$HOME/.ssh"
)

# Files to backup without encryption
_NON_ENCRYPT=(
    "$HOME/photos"
)

# Files to backup to shared storage
_SHARED=(
    "$HOME/family"
)
```

The script expects these files to be in `~/.config/rclone`. To keep them somewhere else update the associated variables when configuring the script to work with your rclone remotes.
