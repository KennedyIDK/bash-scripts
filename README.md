
# Bash Scripts

> [!IMPORTANT]
> *Please read the [dependencies](#dependencies) section of this readme before attempting to use any script in this repository.*

A collection of utility scripts for backups, workflow automation, and desktop customization. Scripts were written for personal use on Linux (Fedora, Sway). Portability to other systems may require modifications.

## Contents Overview

```
 bash-scripts/
  ├── .functions/         # functions used by scripts
  ├── backup/             # backup scripts
  ├── obsidian/           # obsidian scripts
  ├── sway/               # window manager scripts
  ├── thunar/             # file manager scripts
  ├── other/              # all other scripts
  └── hello-world.sh      # script template
```


- Obsidian scripts will work with local markdown files, you don't necessarily have to use Obsidian.
- Thunar scripts should work with any graphical file manager that allows custom actions.
- Only one sway script - `swipe-move-workspaces.sh` - relies on `swaymsg`, the other sway scripts should work in any desktop environment that allows you to set custom hotkeys.

### backup/

| Script | Description | Usage |
|--------|-------------|-------|
| [bak](/backup/bak/) | Create timestamped copies of files or directories | Terminal |
| [bakcloud](/backup/bakcloud/) | Backup files to cloud storage using rclone | Terminal |
| [bakhome](/backup/bakhome/) | Backup to an external drive using rsync | Terminal |

### obsidian/

| Script | Description | Usage |
|--------|-------------|-------|
| [copyspace](/obsidian/copyspace/) | Append selected text to a markdown file | Hotkey |
| [shoplist](/obsidian/shoplist/) | Add items to shopping list | Hotkey |
| [todo](/obsidian/todo/) | Add items to todo list | Terminal / Hotkey |

### sway/

| Script | Description | Usage |
|--------|-------------|-------|
| [appmute](/sway/appmute/) | Toggle mute for a specific application | Hotkey |
| [gammatoggle](/sway/gammatoggle/) | Toggle gammastep on and off | Hotkey |
| [swayshot](/sway/swayshot/) | Take region screenshots | Hotkey |
| [swipe-move-workspace](/sway/swipe-move-workspace/) | Move container to adjacent workspace | Gesture |

### thunar/

| Script | Description | Usage |
|--------|-------------|-------|
| [mp3oncat](/thunar/mp3oncat/) | Concatenate audio files | Context menu |
| [swapname](/thunar/swapname/) | Swap two filenames | Context menu |
| [verify256](/thunar/verify256/) | Verify SHA256 checksum | Context menu |

### other/

| Script | Description | Usage |
|--------|-------------|-------|
| [agent](/other/agent/) | Wrapper for age encryption | Terminal |
| [flip](/other/flip/) | Flip a coin one or multiple times | Terminal |
| [geoname](/other/geoname/) | Rename photos/videos by GPS location | Terminal |
| [link-shorten](/other/link-shorten/) | Shorten URLs and copy to clipboard | Terminal / Hotkey |
| [terminal-header](/other/terminal-header/) | Display system info on terminal startup | .bashrc |
| [verify256](/other/verify256/) | Compare SHA256 checksums | Terminal |
| [walsh](/other/walsh/) | Organize wallpapers by aspect ratio | Terminal |

## Dependencies

Dependencies fall into three categories, which correspond to arrays in the `setup_and_dependencies` function:

1. `core_functions` A list of utility functions from `.functions` used by most scripts.
2. `additional_functions` Any additional utility functions from `.functions` required by the script.
3. `external_commands` Any command that is not standard in GNU/Linux environments.

Required functions are listed in the README for each script. You will need to make these functions available to the script in order to run it. See the dedicated functions [README](.functions/README.md) for details.

## Recommended Scripts

https://github.com/trapd00r/LS_COLORS - Collection of extension:color mappings.

https://github.com/nwg-piotr/autotiling - Autotiling script for sway.


## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
