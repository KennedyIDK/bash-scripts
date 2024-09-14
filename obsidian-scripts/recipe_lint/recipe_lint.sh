#!/usr/bin/env bash

# Name        : nyt_recipes

# Description : Edit recipes downloaded from nyt via obsidian.

# ==============================================================================

# CONFIGURATION_VARIABLES
# -----------------------

# Directory containing the recipes.

recipe_dir="$HOME/recipe-vault/nyt-recipes"

# Strings to remove from the recipe filenames.

filename_remove=(
  " Recipe"
  " (With Video)"
  " (with Video)"
  " - NYT Cooking"
)

# Strings to remove from the recipes.

section_remove=(
  "Shop ingredients on Instacart"
  "Note: The information shown is Edamam’s estimate"
  "### Similar Recipes"
  "## Ratings"
  "### Private Notes"
  "## Cooking Notes"
  "### Cooking Guides"
  "### Trending on Cooking"
  "### Hungry for More Recipes?"
)

# FUNCTIONS
# ---------

# Remove strings from recipe filenames.

remove_strings_from_filenames() {

  # Get the base filename without the directory.

  for file in "$recipe_dir"/*.md; do
    base_filename=$(basename "$file")
    new_filename="$base_filename"

    # Remove each string from the filename.

    for string in "${filename_remove[@]}"; do
      new_filename="${new_filename//$string/}"
    done

    # Rename the file if the new filename is different.

    if [[ "$base_filename" != "$new_filename" ]]; then
      mv "$file" "$recipe_dir/$new_filename"
      echo "Added: $new_filename"
    fi
  done
}

# Remove strings from recipes.

remove_sections_from_recipes() {
  for file in "$recipe_dir"/*.md; do
    for string in "${section_remove[@]}"; do
      sed -i "/^$string/,/^#/ { /^#/!d; /^$string/d; }" "$file"
    done
  done
}

# Sync recipes to other locations.

sync_recipes() {
  rsync --archive --info=progress2 --delete "$recipe_dir" "$1"
}

# SCRIPT_EXECUTION
# ----------------

# Reset SECONDS to start timing.

SECONDS=0

echo
echo "--- 🗽 NYT RECIPES 🗽 ---"
echo
echo "Cleaning up recipes..."
echo

# Edit filenames.

if remove_strings_from_filenames; then
  echo
  echo "Filenames cleaned up."
fi

# Edit recipes.

if remove_sections_from_recipes; then
  echo
  echo "Recipes cleaned up."
fi

# Sync recipes to other locations.

echo
echo "Syncing recipes..."

echo
echo "      Syncing to Obsidian..."
sync_recipes "$HOME/obsidian/kitchen"

# SCRIPT_CLOSE
# ------------

echo
echo "Done. Took $SECONDS seconds."
echo
echo "There are $(find "$recipe_dir" -type f | wc -l) recipes in the directory."

exit 0
