#!/bin/bash

# Filename to watch and where to output
file="shibuser.denied"
output="shibuser.txt"

case $(uname) in
    Linux)  STAT_CMD="stat -c %Z" ;;
    Darwin) STAT_CMD="stat -f %m" ;;
esac

### Set inital time of file
LTIME=`$STAT_CMD $file`

while true
do
    ATIME=`$STAT_CMD $file`

    if [[ "$ATIME" -ne "$LTIME" ]]
    then
        echo "shibuser.txt modified"
        ./create-shibuser.sh > $output
        LTIME=$ATIME
    fi
    sleep 5
done

