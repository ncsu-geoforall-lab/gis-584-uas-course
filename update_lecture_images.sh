#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <input_file> <img_source_folder> <img_output_folder>"
    exit 1
fi

input_file="$1"
img_source_folder="$2"
img_output_folder="$3"

# Create the output folder if it doesn't exist
mkdir -p "$img_output_folder"

# Function to find and convert images
convert_images() {
    local img_path="$1"
    local img_name=$(basename "$img_path")
    local img_name_no_ext="${img_name%.*}"
    local webp_path="$img_output_folder/$img_name_no_ext.webp"

    # Find the image in the source folder
    found_img=$(find "$img_source_folder" -type f -name "$img_name" | head -n 1)

    if [ -n "$found_img" ]; then
        echo "Found Image: $img_name"
        # Convert the image to webp format
        mogrify -format webp -quality 80 -path "$img_output_folder" "$found_img"
        # Replace the image path in the input file
        sed -i "s|$img_path|$webp_path|g" "$input_file"
    else
        # Print the missing image to stderr
        echo "Image not found: $img_name" >&2
    fi
}

# Extract image paths from the input file and process them
grep -oP '(?<=src=")[^"]+' "$input_file" | while read -r img_path; do
    convert_images "$img_path"
done