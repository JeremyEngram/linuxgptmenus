#!/bin/bash

# Get the path to the Alacarte menu file
ALACARTE_FILE=~/.local/share/applications/alacarte-made.desktop

# Get the path to the folder containing the scripts
SCRIPTS_FOLDER=/usr/local/bin

# Loop through each script in the folder
for SCRIPT_PATH in $SCRIPTS_FOLDER/*.sh; do
    # Get the script's name without the extension
    SCRIPT_NAME=$(basename $SCRIPT_PATH .sh)

    # Create a new desktop entry for the script
    echo "[Desktop Entry]
Name=$SCRIPT_NAME
Exec=$SCRIPT_PATH
Terminal=true
Type=Application
Categories=System;Utility;" >> $ALACARTE_FILE
done
