#!/bin/bash

# Define the path to the directory to monitor
dir_to_monitor="/usr/local/bin"

# Define the file extension to look for
file_extension=".sh"

# Create an array of existing files in the directory
existing_files=($(ls "${dir_to_monitor}"/*"${file_extension}" 2>/dev/null))

# Define the function to display the menu
display_menu() {
  PS3="Please select a script to execute: "
  select file in "${existing_files[@]}" "Quit"; do
    if [[ "$REPLY" -eq $((${#existing_files[@]}+1)) ]]; then
      echo "Exiting menu..."
      exit 0
    elif [[ "$REPLY" -ge 1 ]] && [[ "$REPLY" -le ${#existing_files[@]} ]]; then
      echo "Executing ${file}..."
      . "${file}"
    else
      echo "Invalid selection. Please try again."
    fi
  done
}

# Monitor the directory for changes
while true; do
  # Wait for a new file to be added to the directory
  inotifywait -q -e create "${dir_to_monitor}" > /dev/null 2>&1

  # Update the array of existing files
  existing_files=($(ls "${dir_to_monitor}"/*"${file_extension}" 2>/dev/null))

  # Display the menu
  display_menu
done
