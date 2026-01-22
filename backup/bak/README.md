# bak

Create timestamped copies of files or directories.

## Usage

```bash
bak [OPTIONS] <files/dirs>
```

### Options

```
-s       Store backups in the current directory
-c       Compress backup using tar/gzip
-h       Show help message
```

### Examples

Create a backup of a single file:
```bash
bak file.txt
```

Create backups of multiple files:
```bash
bak file.txt file2.txt
```

Create a compressed backup in the current directory:
```bash
bak -cs file.txt
```

## Dependencies

### External Commands

- tar
- gzip

### Required Functions

- script_setup
- check_required_commands
- print_exit_code
- err
- warn
- deb
- remove_duplicates_from_array

To install all required functions to `$HOME/bin/.functions`:

```bash
mkdir -p ~/bin/.functions && cd ~/bin/.functions && for func in script_setup check_required_commands print_exit_code err warn deb remove_duplicates_from_array; do curl -sO https://raw.githubusercontent.com/KennedyIDK/bash-scripts/main/.functions/$func; done
```

## Installation

To install the script to `$HOME/bin`:

```bash
curl -o ~/bin/bak https://raw.githubusercontent.com/KennedyIDK/bash-scripts/main/backup/bak/bak && chmod u+x ~/bin/bak
```

## Configuration

- By default all backups will be stored in a hidden directory `.baks` inside the same directory as the input file. You can change this behaviour by setting the `_DEFAULT_OUTPUT_DIR` variable to keep backups in a central location, or by setting the `_STAY_IN_PLACE` variable to `true` to leave backups in place.
- The default timestamp format is `%Y%m%d%H%M%S`. You can change this by editing the `_TIMESTAMP` variable.
