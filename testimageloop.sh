#!/bin/bash

# Check if the image list file is provided as an argument
if [ -z "$1" ]; then
  echo "Usage: $0 <image_list_file>"
  exit 1
fi

# Image list file
image_list="$1"

# Check if the file exists
if [ ! -f "$image_list" ]; then
  echo "Error: Image list file '$image_list' not found."
  exit 1
fi

while true; do
  # Loop through each line in the file
  while IFS= read -r image_name; do
    # Check if the image name is valid
    if [[ "$image_name" =~ ^[a-zA-Z0-9/:._-]+$ ]]; then
      echo "Pulling image: $image_name"
      docker pull "$image_name"
      if [ $? -ne 0 ]; then
        echo "Error: Failed to pull image '$image_name'."
      fi
    else
      echo "Error: Invalid image name '$image_name'."
    fi
  done < "$image_list"

  echo "Sleeping for 5 minutes..."
  sleep 300 # Sleep for 5 minutes (300 seconds)
done
