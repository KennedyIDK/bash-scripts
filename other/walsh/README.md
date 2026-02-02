# walsh

A script for organizing desktop wallpaper images by aspect ratio and resolution.

Images are moved to `~/.backgrounds/` and renamed to the format: `{aspect_ratio}-{width}x{height}-{filename}` (e.g., `1.78-1920x1080-mountain.jpg`).

## Usage

```bash
walsh <images/dirs>
```

## External Commands

- [exiftool](https://exiftool.org/)
- [detox](https://github.com/dharple/detox)
- [bc](https://www.gnu.org/software/bc/)

## Required Functions

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
curl -o ~/bin/walsh https://raw.githubusercontent.com/KennedyIDK/bash-scripts/main/other/walsh/walsh && chmod u+x ~/bin/walsh
```
