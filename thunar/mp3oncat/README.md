# mp3oncat

Concatenate audio files via file manager context menu. Prompts for output filename using rofi.

## Usage

Add as a Thunar custom action:

- **Name**: Concatenate Audio
- **Command**: `$HOME/bin/thunar/thunar-mp3oncat.sh %F`
- **Appearance Conditions**: Audio files, multiple selection

Select two or more audio files of the same type, right-click, and select the action.

## Dependencies

- ffmpeg
- rofi

## Installation

Install to `$HOME/bin/thunar`:

```bash
mkdir -p ~/bin/thunar && curl -o ~/bin/thunar/thunar-mp3oncat.sh https://raw.githubusercontent.com/KennedyIDK/bash-scripts/main/thunar/mp3oncat/thunar-mp3oncat.sh && chmod u+x ~/bin/thunar/thunar-mp3oncat.sh
```

## Troubleshooting

Run the script from the terminal to check the exit code:

```bash
thunar-mp3oncat.sh file1.mp3 file2.mp3
echo $?
```

| Exit Code | Error                            |
| :-------: | -------------------------------- |
| 127       | Missing required dependencies    |
| 11        | Less than two audio files selected |
| 12        | Mixed file extensions detected   |
| 13        | No output file name provided     |
| 14        | Output file already exists       |
| 15        | Failed to concatenate audio files |
