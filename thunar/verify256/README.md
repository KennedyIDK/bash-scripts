# verify256

Verify SHA256 checksum via file manager context menu. Prompts for the expected checksum using zenity.

## Usage

Add as a Thunar custom action:

- **Name**: Verify SHA256
- **Command**: `$HOME/bin/thunar/thunar-verify256.sh %f`
- **Appearance Conditions**: Other files

Select a file, right-click, and select the action. Enter the expected SHA256 checksum when prompted.

## Dependencies

- zenity

## Installation

Install to `$HOME/bin/thunar`:

```bash
mkdir -p ~/bin/thunar && curl -o ~/bin/thunar/thunar-verify256.sh https://raw.githubusercontent.com/KennedyIDK/bash-scripts/main/thunar/verify256/thunar-verify256.sh && chmod u+x ~/bin/thunar/thunar-verify256.sh
```

## Troubleshooting

Run the script from the terminal to check the exit code:

```bash
thunar-verify256.sh file.iso
echo $?
```

| Exit Code | Error                                      |
| :-------: | ------------------------------------------ |
| 11        | zenity is not installed                    |
| 12        | Incorrect number of arguments              |
| 13        | No checksum provided or invalid format     |
| 14        | sha256sum command failed                   |
