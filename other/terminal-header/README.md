# terminal-header.sh

Display system information and backup status warnings on terminal startup. Shows load averages, process count, and alerts when backups are overdue.

## Usage

Add the following line to your `.bashrc`:

```bash
# Display terminal header
terminal-header.sh
```

## Configuration

The script monitors two backup types with different age thresholds:

- **Local backups**: Warns if older than 6 days
- **Cloud backups**: Warns if older than 1 day

These correspond to the `bakhome` and `bakcloud` scripts, and use their log files to determine when to warn about overdue backups. You can modify the log files the script looks for and the warning thresholds by editing variables in the script.

## Required Functions

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
curl -o ~/bin/terminal-header.sh https://raw.githubusercontent.com/KennedyIDK/bash-scripts/main/other/terminal-header/terminal-header.sh && chmod u+x ~/bin/terminal-header.sh
```

Then add the line to your `.bashrc` as shown in the Usage section above.
