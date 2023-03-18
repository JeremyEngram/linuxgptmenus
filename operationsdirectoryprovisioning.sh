#!/bin/bash

# Define the base directory to search for scripts
BASE_DIR="/opt"

# Find all directories in the base directory
DIRS=($(find "$BASE_DIR" -type d))

# Iterate over each directory and create a menu for scripts in that directory
for dir in "${DIRS[@]}"; do
  # Find all script files in the directory
  SCRIPTS=($(find "$dir" -maxdepth 1 -type f \( -name "*.sh" -o -name "*.py" \)))

  # If there are no script files, skip this directory
  if [ ${#SCRIPTS[@]} -eq 0 ]; then
    continue
  fi

  # Print the directory name as a header
  echo "Scripts in directory: $dir"

  # Define the options for the select menu
  OPTIONS=("${SCRIPTS[@]}" "Quit")

  # Prompt the user to select a script
  select script in "${OPTIONS[@]}"; do
    # If the user selects "Quit", exit the menu
    if [ "$script" == "Quit" ]; then
      break
    fi

    # If the selected script is not executable, make it executable
    if [ ! -x "$script" ]; then
      chmod +x "$script"
    fi

    # Run the selected script
    "$script"

    # Prompt the user to select another script
    break
  done
done
