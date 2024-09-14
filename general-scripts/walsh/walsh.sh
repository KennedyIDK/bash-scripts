#!/usr/bin/env bash

# NAME        : WALSH

# DESCRIPTION : A script for resizing images for various wallpaper resolutions.

# =============================================================================

# CONFIGURATION_VARIABLES
# -----------------------

wallpaper_dir="$HOME/custom/wallpapers"

# VARIABLES
# ---------

file="$1"
width=$(identify -format "%w" "$1")
height=$(identify -format "%h" "$1")
resolution=$(identify -format "%wx%h" "$1")
aspect_ratio=$(identify -format "%[fx:w/h]" "$1")
old_file="${width}x${height}_${file##*/}"

# FUNCTIONS
# ---------

# Function to resize the image to the desired resolution.

process_image() {

  local desired_width=$2
  local desired_height=$3
  local desired_ratio="$4"
  local ratio_short_name="$5"
  local new_file="${desired_width}x${desired_height}/${ratio_short_name}_${file##*/}"

  # Check if the image is smaller than the desired resolution.

  if [[ $width -lt $desired_width || $height -lt $desired_height ]]; then

    # If the image is 16x9, move it to the 'Other 16x9' folder.

    if (($(echo "$aspect_ratio > 1.76" | bc -l) && $(echo "$aspect_ratio < 1.78" | bc -l))); then
      mkdir -p "$wallpaper_dir/$desired_ratio/Other $desired_ratio"
      mv "$file" "$wallpaper_dir/$desired_ratio/Other $desired_ratio/$old_file" &&
        echo "${desired_width}x${desired_height}: Image is too small. Moved to /Other $desired_ratio/$old_file"
      echo
      echo "Exiting..."
      exit 0

      # If the image is 16:10, move it to the 'Other 16x10' folder.

    elif (($(echo "$aspect_ratio > 1.59" | bc -l) && $(echo "$aspect_ratio < 1.61" | bc -l))); then
      mkdir -p "$wallpaper_dir/$desired_ratio/Other $desired_ratio"
      mv "$file" "$wallpaper_dir/$desired_ratio/Other $desired_ratio/$old_file" &&
        echo "${desired_width}x${desired_height}: Image is too small. Moved to /Other $desired_ratio/$old_file"
      echo
      echo "Exiting..."
      exit 0

      # If the image is 21:9, move it to the 'Other 21x9' folder.

    elif (($(echo "$aspect_ratio > 2.32" | bc -l) && $(echo "$aspect_ratio < 2.34" | bc -l))); then
      mkdir -p "$wallpaper_dir/$desired_ratio/Other $desired_ratio"
      mv "$file" "$wallpaper_dir/$desired_ratio/Other $desired_ratio/$old_file" &&
        echo "${desired_width}x${desired_height}: Image is too small. Moved to /Other $desired_ratio/$old_file"
      echo
      echo "Exiting..."
      exit 0

      # If the image is 9:16, move it to the 'Other 9x16' folder.

    elif (($(echo "$aspect_ratio > 0.55" | bc -l) && $(echo "$aspect_ratio < 0.57" | bc -l))); then
      mkdir -p "$wallpaper_dir/$desired_ratio/Other $desired_ratio"
      mv "$file" "$wallpaper_dir/$desired_ratio/Other $desired_ratio/$old_file" &&
        echo "${desired_width}x${desired_height}: Image is too small. Moved to /Other $desired_ratio/$old_file"
      echo
      echo "Exiting..."
      exit 0
    fi

  else

    # Check if the image is already the desired resolution.
    # If it is, move it to the appropriate folder.

    if [[ $width -eq $desired_width && $height -eq $desired_height ]]; then

      mkdir -p "$wallpaper_dir/$desired_ratio/${desired_width}x${desired_height}"

      # If the image is 16x9, move it to the '16x9' folder.

      if (($(echo "$aspect_ratio > 1.76" | bc -l) && $(echo "$aspect_ratio < 1.78" | bc -l))); then
        mv "$file" "$wallpaper_dir/$desired_ratio/$new_file" &&
          echo "${desired_width}x${desired_height}: Image is already the desired resolution. Saved as '$new_file'"
        echo
        echo "Exiting..."
        exit 0

        # If the image is 16x10, move it to the '16x10' folder.

      elif (($(echo "$aspect_ratio > 1.59" | bc -l) && $(echo "$aspect_ratio < 1.61" | bc -l))); then
        mv "$file" "$wallpaper_dir/$desired_ratio/$new_file" &&
          echo "${desired_width}x${desired_height}: Image is already the desired resolution. Saved as '$new_file'"
        echo
        echo "Exiting..."
        exit 0

        # If the image is 21x9, move it to the '21x9' folder.

      elif (($(echo "$aspect_ratio > 2.32" | bc -l) && $(echo "$aspect_ratio < 2.34" | bc -l))); then
        mv "$file" "$wallpaper_dir/$desired_ratio/$new_file" &&
          echo "${desired_width}x${desired_height}: Image is already the desired resolution. Saved as '$new_file'"
        echo
        echo "Exiting..."
        exit 0

        # If image is 9x16, move it to the '9x16' folder.

      elif (($(echo "$aspect_ratio > 0.55" | bc -l) && $(echo "$aspect_ratio < 0.57" | bc -l))); then
        mv "$file" "$wallpaper_dir/$desired_ratio/$new_file" &&
          echo "${desired_width}x${desired_height}: Image is already the desired resolution. Saved as '$new_file'"
        echo
        echo "Exiting..."
        exit 0
      fi
    else

      # If the image is larger than the desired resolution, resize it.

      mkdir -p "$wallpaper_dir/$desired_ratio/${desired_width}x${desired_height}"

      # If the image is 16x9, resize it and save it to the '16x9' folder.

      if (($(echo "$aspect_ratio > 1.76" | bc -l) && $(echo "$aspect_ratio < 1.78" | bc -l))); then
        magick "$file" -resize "${desired_width}x${desired_height}" "$wallpaper_dir/$desired_ratio/$new_file" &&
          echo "${desired_width}x${desired_height}: Image resized successfully. Saved as /$desired_ratio/$new_file"

        # If the image is 16x10, resize it and save it to the '16x10' folder.

      elif (($(echo "$aspect_ratio > 1.59" | bc -l) && $(echo "$aspect_ratio < 1.61" | bc -l))); then
        magick "$file" -resize "${desired_width}x${desired_height}" "$wallpaper_dir/$desired_ratio/$new_file" &&
          echo "${desired_width}x${desired_height}: Image resized successfully. Saved as /$desired_ratio/$new_file"

        # If the image is 21x9, resize it and save it to the '21x9' folder.

      elif (($(echo "$aspect_ratio > 2.32" | bc -l) && $(echo "$aspect_ratio < 2.34" | bc -l))); then
        magick "$file" -resize "${desired_width}x${desired_height}" "$wallpaper_dir/$desired_ratio/$new_file" &&
          echo "${desired_width}x${desired_height}: Image resized successfully. Saved as /$desired_ratio/$new_file"

        # If the image is 9x16, resize it and save it to the '9x16' folder.

      elif (($(echo "$aspect_ratio > 0.55" | bc -l) && $(echo "$aspect_ratio < 0.57" | bc -l))); then
        magick "$file" -resize "${desired_width}x${desired_height}" "$wallpaper_dir/$desired_ratio/$new_file" &&
          echo "${desired_width}x${desired_height}: Image resized successfully. Saved as /$desired_ratio/$new_file"
      fi
    fi
  fi
}

# CHECKS
# ------

# Check filepath exists.

if [[ ! -f "$1" ]]; then
  echo
  echo "File not found."
  exit 1
fi

# Check if the user has ImageMagick installed.

if ! command -v magick &>/dev/null; then
  echo
  echo "ImageMagick is not installed. Please install it before running this script."
  exit 1
fi

# Check if the user has provided a JPEG image and prompt to convert it if not.

if [[ ${1: -4} != ".jpg" ]]; then
  echo
  echo "Please provide a JPEG image."
  echo
  read -r -p "Would you like to convert the image to JPEG? [y/n]: " convert_image
  echo
  if [[ $convert_image == "y" ]]; then
    # Convert the image to JPEG.
    magick "$1" "${1%.*}.jpg"
    echo "Image converted to JPEG. Please run the script again with the new image."
  else
    echo
    echo "Exiting..."
    exit 1
  fi
  exit 1
fi

# Check if the wallpaper directory exists.

mkdir -p "$wallpaper_dir"

# SCRIPT_EXECUTION
# ----------------

echo
echo "--- 🏞️ WALSH 🏞️ ---"
echo
echo "Filename: $1"
echo
echo "Resolution: $resolution"
echo "Aspect Ratio: $aspect_ratio"
echo

# Process the image for various resolutions.

# If image is 16x9:

if (($(echo "$aspect_ratio > 1.76" | bc -l) && $(echo "$aspect_ratio < 1.78" | bc -l))); then
  echo "Processing 16x9 image..."
  process_image "$1" 1920 1080 '16x9' 'FHD'
  process_image "$1" 2560 1440 '16x9' 'QHD'
  process_image "$1" 3840 2160 '16x9' '4K'
  process_image "$1" 5120 2880 '16x9' '5K'
  process_image "$1" 7680 4320 '16x9' '8K'

# If image is 16x10:

elif (($(echo "$aspect_ratio > 1.59" | bc -l) && $(echo "$aspect_ratio < 1.61" | bc -l))); then
  echo "Processing 16x10 image..."
  process_image "$1" 1920 1200 '16x10' 'WUXGA'
  process_image "$1" 2560 1600 '16x10' 'WQXGA'
  process_image "$1" 3840 2400 '16x10' 'WQUXGA'
  process_image "$1" 5120 3200 '16x10' 't5K'
  process_image "$1" 7680 4800 '16x10' 't8K'

# If image is 21x9:

elif (($(echo "$aspect_ratio > 2.32" | bc -l) && $(echo "$aspect_ratio < 2.34" | bc -l))); then
  echo "Processing 21x9 image..."
  process_image "$1" 2560 1080 '21x9' 'UWFHD'
  process_image "$1" 3440 1440 '21x9' 'UWQHD'
  process_image "$1" 5120 2160 '21x9' 'UW5K'
  process_image "$1" 6880 2880 '21x9' 'UW6K'
  process_image "$1" 7680 3200 '21x9' 'UW8K'

# If image is 9x16:

elif (($(echo "$aspect_ratio > 0.55" | bc -l) && $(echo "$aspect_ratio < 0.57" | bc -l))); then
  echo "Processing 9x16 image..."
  process_image "$1" 1080 1920 '9x16' 'vFHD'
  process_image "$1" 1440 2560 '9x16' 'vQHD'
  process_image "$1" 2160 3840 '9x16' 'v4K'
  process_image "$1" 2880 5120 '9x16' 'v5K'
  process_image "$1" 4320 7680 '9x16' 'v8K'

# If image is 4x3:

elif (($(echo "$aspect_ratio > 1.32" | bc -l) && $(echo "$aspect_ratio < 1.34" | bc -l))); then
  echo "Processing 4x3 image..."
  # Move the image to the 'Tablets' folder.
  mkdir -p "$wallpaper_dir/Tablets"
  mv "$1" "$wallpaper_dir/Tablets/$old_file" &&
    echo "Image is 4x3. Moved to 'Tablets' folder. Saved as $old_file"

# If image is 9x19.5:

elif (($(echo "$aspect_ratio > 0.46" | bc -l) && $(echo "$aspect_ratio < 0.48" | bc -l))); then
  echo "Processing 9x19.5 image..."
  # Move the image to the 'Smartphones' folder.
  mkdir -p "$wallpaper_dir/Smartphones"
  mv "$1" "$wallpaper_dir/Smartphones/$old_file" &&
    echo "Image is 9x19.5. Moved to 'Smartphones' folder. Saved as $old_file"

# If image is not a standard resolution:

else
  # Move the image to the 'Other' folder.
  echo "Image is not a an expected resolution. Check the image and try again."
  exit 1
fi

exit 0
