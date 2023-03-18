#!/bin/bash

# Set the path to the scripts folder
SCRIPTS_FOLDER=/usr/local/bin

# Set the path to the backup folder
BACKUP_FOLDER=/usr/local/bin_backup

# Set the path to the Git repository folder
GIT_REPO_FOLDER=~/master_shell

# Set the GitHub username
GITHUB_USERNAME=JeremyEngram

# Set the initial version number
VERSION_NUMBER=1.0

# Create the backup folder if it doesn't exist
if [ ! -d $BACKUP_FOLDER ]; then
  mkdir $BACKUP_FOLDER
fi

# Watch for file creation, modification or deletion events in the scripts folder
inotifywait -m -r -e create,modify,delete --format '%w%f' $SCRIPTS_FOLDER | while read FILENAME
do
  # Copy the entire scripts folder to the backup folder
  cp -r $SCRIPTS_FOLDER $BACKUP_FOLDER/$VERSION_NUMBER

  # Add, commit and push the changes to the Git repository
  cd $GIT_REPO_FOLDER
  git add .
  git commit -m "Backup version $VERSION_NUMBER"
  git push

  # Increment the version number
  VERSION_NUMBER=$(echo "$VERSION_NUMBER + 0.1" | bc)
done
