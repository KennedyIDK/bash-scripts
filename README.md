
# Bash Scripts

> ⚠️ *Please read the [dependencies](#dependencies) section of this readme before attempting to use any script in this repository.*

A collection of utility scripts for backups, workflow automation, and desktop customization. Scripts were written for personal use on Linux (Fedora, Sway). Portability to other systems may require modifications.

## Contents Overview

```
 bash-scripts/
  ├── .functions/         # functions used by scripts
  ├── backup/             # backup scripts
  ├── obsidian/           # obsidian scripts
  ├── sway/               # window manager scripts
  ├── thunar/             # file manager scripts
  └── other/              # all other scripts
```


- Obsidian scripts will work with local markdown files, you don't necessarily have to use Obsidian.
- Thunar scripts should work with any graphical file manager that allows custom actions.
- Only one sway script - `swipe-move-workspaces.sh` - relies on `swaymsg`, the other sway scripts should work in any desktop environment that allows you to set custom hotkeys.

### [backup/](/backup/)

| Script | Description | Usage |
|--------|-------------|-------|

## Dependencies

Dependencies fall into three categories, which correspond to arrays in the `setup_and_dependencies` function:

1. `core_functions` A list of utility functions from `.functions` used by most scripts.
2. `additional_functions` Any additional utility functions from `.functions` required by the script.
3. `external_commands` Any command that is not standard in GNU/Linux environments.

Required functions are listed in the README for each script. You will need to make these functions available to the script, either by putting them in `$HOME/bin/.functions` as I have, by sourcing them from somewhere else, or by including them in the script. The latter options will obviously require you to rework or remove the sourcing logic.

The `check_required_commands` function will check all dependencies at runtime. Some lighter scripts don't require additional functions and check for external commands directly.

### Core functions:

- By default `script_setup` will create a log file for the script inside a hidden directory `.logs` within the script's working directory. To use a different location set the `$SCRIPT_LOGS` variable in your environment. 
- If a script is run in a non-interactive environment (i.e. not in a terminal) then `print_exit_code` will rely on `notify-send` from `libnotify` to report errors to the user.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
