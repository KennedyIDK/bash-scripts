# Walsh

`walsh.sh` (wallpaper .sh) is a script for quickly resizing images to common wallpaper resolutions based on the aspect ratio. I used this script to automate the resizing of images for [Kenya Wallpapers](https://github.com/KennedyIDK/kenya-wallpapers).

---

### Usage

```bash
walsh <image>
```

The script will check the image aspect ratio and resize it to the following resolutions automatically:

| Aspect Ratio | Resolutions                                   |
|--------------|-----------------------------------------------|
| 16:9         | `1920x1080 (FHD)` , `2560x1440 (QHD)` , `3840x2160 (4K)` |
| 21:9         | `2520x1080 (UWFHD)` , `3360x1440 (UWQHD)`        |
| 16:10        | `1920x1200 (WUXGA)` , `2560x1600 (WQXGA)` , `3840x2400 (WQUXGA)` |
| 9:16         | `1080x1920 (FHD)` , `1440x2560 (QHD)` , `2160x3840 (4K)` |

### How It Works

1. Input Validation: The script checks if the provided file exists and if it is a JPEG image. If not, it prompts the user to convert it.
2. Aspect Ratio Detection: The script calculates the aspect ratio of the image and determines the appropriate folder for the image based on its aspect ratio.
3. Image Processing: Depending on the aspect ratio, the script resizes the image to various standard resolutions and saves them in the corresponding directories.
4. File Organization: Images that do not meet the desired resolution are moved to specific folders (e.g., "Other 16x9", "Tablets", "Smartphones").


### Directory Structure

The script organizes images into the following directory structure under ~/custom/wallpapers (default location):

~/custom/wallpapers/
├── 16x9/
│   ├── 1920x1080/
│   ├── 2560x1440/
│   ├── ...
├── 16x10/
│   ├── 1920x1200/
│   ├── ...
├── 21x9/
│   ├── 2560x1080/
│   ├── ...
├── 9x16/
│   ├── 1080x1920/
│   ├── ...
├── Tablets/
├── Smartphones/
└── Other/

### Installation

Install the script to a directory in your PATH. For example, to install to `/usr/local/bin`:
```sh
mkdir -p ~/.local/bin
curl https://raw.githubusercontent.com/KennedyIDK/bash-scripts/main/general-scripts/walsh/walsh.sh -o ~/.local/bin/walsh.sh
```

Make the script executable:
```sh
chmod +x ~/.local/bin/walsh.sh
```

Remove the .sh extension (optional):
```sh
mv ~/.local/bin/walsh.sh ~/.local/bin/walsh
```
