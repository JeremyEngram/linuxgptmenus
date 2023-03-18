#!/bin/bash

# Define the base directory to search for scripts
BASE_DIR="/usr/local/bin"

# Define the archive directory
ARCHIVE_DIR="/usr/local/bin/archive"

# Define the age threshold in days (30 days = 2592000 seconds)
AGE_THRESHOLD=2592000

# Find all script files in the base directory that have not been accessed in over a month
SCRIPTS=($(find "$BASE_DIR" -type f \( -name "*.sh" -o -name "*.py" \) -not -exec test -e "$ARCHIVE_DIR/{}" \; -a -atime +$AGE_THRESHOLD))

# If there are no script files to archive, exit the script
if [ ${#SCRIPTS[@]} -eq 0 ]; then
  exit 0
fi

# Create the archive directory if it does not already exist
if [ ! -d "$ARCHIVE_DIR" ]; then
  mkdir "$ARCHIVE_DIR"
fi

# Archive each script file by moving it to the archive directory
for script in "${SCRIPTS[@]}"; do
  mv "$script" "$ARCHIVE_DIR/$(basename "$script")"
done

# Print a message indicating how many scripts were archived
echo "${#SCRIPTS[@]} scripts were archived."