# /opt/script/delete-old-files.sh

#!/bin/bash
prev_count=0
fpath=/var/log/apache/2daygeek_access.*
find $fpath -type f -mtime +15  -exec ls -ltrd {} \; > /tmp/file.out
find $fpath -type f -mtime +15  -exec rm -rf {} \;
count=$(cat /tmp/file.out | wc -l)
if [ "$prev_count" -lt "$count" ] ; then
MESSAGE="/tmp/file1.out"
TO="wacrochester@gmail.com"
echo "Apache Access log files are deleted older than 20 days"  >> $MESSAGE
echo "+--------------------------------------------- +" >> $MESSAGE
echo "" >> $MESSAGE
cat /tmp/file.out | awk '{print $6,$7,$9}' >> $MESSAGE
echo "" >> $MESSAGE
SUBJECT="WARNING: Apache log folders are deleted older than 15 days $(date)"
mail -s "$SUBJECT" "$TO" < $MESSAGE
rm $MESSAGE /tmp/file.out
fi
