#!/bin/bash

# Set the email address to send alerts to
ALERT_EMAIL="wacrochester@gmail.com"

# Set the minimum log level to monitor (1 = alerts, 2 = critical, 3 = errors, 4 = warnings)
MIN_LOG_LEVEL=3

# Start monitoring syslog for errors, warnings and failures
tail -f /var/log/syslog | while read LINE
do
  # Check if the log line contains an error, warning or failure
  if echo $LINE | grep -qE "(error|warning|failure)"; then
    # Check if the log line has a severity level greater than or equal to the minimum level
    LOG_LEVEL=$(echo $LINE | grep -oE "<[0-9]+>" | sed "s/[<>]//g")
    if [ $LOG_LEVEL -ge $MIN_LOG_LEVEL ]; then
      # Send an alert email to the user
      echo "$LINE" | mail -s "System Alert" $ALERT_EMAIL
    fi
  fi
done
