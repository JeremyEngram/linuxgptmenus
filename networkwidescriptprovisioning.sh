#!/bin/bash

# Define the source directory and script filename pattern
SRC_DIR="/usr/local/bin"
FILE_PATTERN="*.sh"

# Define the destination directory on the remote system
DEST_DIR="/usr/local/bin"

# Define the list of remote hosts
REMOTE_HOSTS=("hostname1" "hostname2" "hostname3")

# Iterate over each script in the source directory
for file in "$SRC_DIR/$FILE_PATTERN"; do
  # Iterate over each remote host
  for remote_host in "${REMOTE_HOSTS[@]}"; do
    # Copy the file to the remote host using scp
    scp "$file" "$remote_host:$DEST_DIR"
  done
done
