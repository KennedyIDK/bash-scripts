# geoname

A script to rename photos and videos based on their location metadata. Uses exiftool to extract GPS coordinates and queries OpenStreetMap's Nominatim API for location data. Offers multiple filename options based on location.

## Usage

```bash
geoname <directory>/<files>
```

## External Commands

- [curl](https://curl.se/)
- [jq](https://jqlang.github.io/jq/)
- [magick](https://imagemagick.org/) (ImageMagick)
- [ffmpeg](https://ffmpeg.org/)
- [kitty](https://sw.kovidgoyal.net/kitty/) *
- [exiftool](https://exiftool.org/)

\* I know other terminals also use [Kitty's graphics protocol](https://sw.kovidgoyal.net/kitty/graphics-protocol/) to display images, but I am not familiar with them or how it's implemented.

## Required Functions

- script_setup
- check_required_commands
- print_exit_code
- err
- warn
- deb
- remove_duplicates_from_array
- print_separator
- create_video_thumbnail_for
- create_image_thumbnail_for

To install all required functions to `$HOME/bin/.functions`:

```bash
mkdir -p ~/bin/.functions && cd ~/bin/.functions && for func in script_setup check_required_commands print_exit_code err warn deb remove_duplicates_from_array print_separator create_video_thumbnail_for create_image_thumbnail_for; do curl -sO https://raw.githubusercontent.com/KennedyIDK/bash-scripts/main/.functions/$func; done
```

## Installation

To install the script to `$HOME/bin`:

```bash
curl -o ~/bin/geoname https://raw.githubusercontent.com/KennedyIDK/bash-scripts/main/other/geoname/geoname && chmod u+x ~/bin/geoname
```
