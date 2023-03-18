#!/bin/bash

# Define the log file path and email address
log_file="/var/log/user_actions.log"
email_address="wacrochester@gmail.com"

# Create the log file if it does not exist
touch $log_file

# Set up the log file to be readable only by root
chmod 600 $log_file

# Monitor user actions and log them to the file
inotifywait -m -r -e create,modify,delete /home | while read path action file; do
    echo "$(date): $USER $action $path$file" >> $log_file
done &

# Send an email with the log file every hour
while true; do
    sleep 3600
    cat $log_file | mail -s "User Actions Log" $email_address
done &
