#!/usr/bin/env bash
denied=`cat shibuser.denied`

# while denied
# do
#     echo
# done

cat shibuser.txt.pre
cat shibuser.denied | while read line
do
    if [[ $line != \#* ]]
    then
        echo "If auth:urn:oid:1.3.6.1.4.1.5923.1.1.1.6 eq \"$line\";"
        echo "   Deny unaffiliated.html"
    fi
done
cat shibuser.txt.post
