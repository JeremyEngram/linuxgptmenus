#!/bin/bash

# Set the path to the scripts folder
SCRIPTS_FOLDER=/usr/local/bin

# Watch for new .sh files in the scripts folder and make them executable
inotifywait -m -e create --format '%f' $SCRIPTS_FOLDER | while read FILENAME
do
    # Check if the new file has a .sh extension
    if [[ "$FILENAME" == *.sh ]]; then
        # Make the file executable
        chmod +x $SCRIPTS_FOLDER/$FILENAME
    fi
done
