#!/bin/bash



FILESYSTEM=/dev/sda1 # or whatever filesystem to monitor
CAPACITY=95 # delete if FS is over 95% of usage 
CACHEDIR=/home/user/lotsa_cache_files/

# Proceed if filesystem capacity is over than the value of CAPACITY (using df POSIX syntax)
# using [ instead of [[ for better error handling.
if [ $(df -P $FILESYSTEM | awk '{ gsub("%",""); capacity = $5 }; END { print capacity }') -gt $CAPACITY ]
then
    # lets do some secure removal (if $CACHEDIR is empty or is not a directory find will exit
    # with error which is quite safe for missruns.):
    find "$CACHEDIR" --maxdepth 1 --type f -exec rm -f {} \;
    # remove "maxdepth and type" if you want to do a recursive removal of files and dirs
    find "$CACHEDIR" -exec rm -f {} \;
fi 



#
#  prune_dir - prune directory by deleting files if we are low on space
#
DIR=$1
CAPACITY_LIMIT=$2

if [ "$DIR" == "" ]
then
    echo "ERROR: directory not specified"
    exit 1
fi

if ! cd $DIR
then
    echo "ERROR: unable to chdir to directory '$DIR'"
    exit 2
fi

if [ "$CAPACITY_LIMIT" == "" ]
then
    CAPACITY_LIMIT=95   # default limit
fi

CAPACITY=$(df -k . | awk '{gsub("%",""); capacity=$5}; END {print capacity}')

if [ $CAPACITY -gt $CAPACITY_LIMIT ]
then
    #
    # Get list of files, oldest first.
    # Delete the oldest files until
    # we are below the limit. Just
    # delete regular files, ignore directories.
    #
    ls -rt | while read FILE
    do
        if [ -f $FILE ]
        then
            if rm -f $FILE
            then
                echo "Deleted $FILE"

                CAPACITY=$(df -k . | awk '{gsub("%",""); capacity=$5}; END {print capacity}')

                if [ $CAPACITY -le $CAPACITY_LIMIT ]
                then
                    # we're below the limit, so stop deleting
                    exit
                fi
            fi
        fi
    done
fi
