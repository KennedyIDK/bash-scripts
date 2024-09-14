# Recipe Lint

`recipe_lint.sh` is a Bash script designed to clean up recipes downloaded from The New York Times (NYT) Cooking website. 

While I have a subscription to NYT Cooking, I dislike the experience of using the website or app whilst cooking, and tend to print out my favourite recipes to keep in a physical binder in my kitchen. This script allows me to quickly clean up the recipes, removing unnecessary strings and sections, and sync them to a specified location, such as an Obsidian vault, before I print them.

---

## Pre-requisites

rsync - for syncing the cleaned recipes to a specified location. Should already be installed on most systems.

## Configuration

Before using the script, you may want to customize the following configuration variables in the script:

`recipe_dir`: The directory containing the downloaded NYT recipes. Default is set to "$HOME/recipe-vault/nyt-recipes".
`filename_remove`: An array of strings to remove from the recipe filenames. You can modify this list to include any additional unwanted strings.
`section_remove`: An array of strings to remove from the recipe content. You can modify this list to include any additional sections you want to exclude.

## Installation

Install the script to a directory in your PATH. For example, to install to `/usr/local/bin`:
```sh
mkdir -p ~/.local/bin
curl https://raw.githubusercontent.com/KennedyIDK/bash-scripts/main/obsidian-scripts/recipe_lint/recipe_lint.sh -o ~/.local/bin/recipe_lint.sh
```

Make the script executable:
```sh
chmod +x ~/.local/bin/recipe_lint.sh
```

Remove the .sh extension (optional):
```sh
mv ~/.local/bin/recipe_lint.sh ~/.local/bin/recipe_lint
```
