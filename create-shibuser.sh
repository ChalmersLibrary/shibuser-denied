#!/usr/bin/env bash

# Test if file is a dosformatted file
file shibuser.denied.txt | grep -q CRLF
if [[ $? != 1 ]]
then
    dos2unix -q shibuser.denied.txt
fi

{
cat shibuser.txt.pre
cat shibuser.denied.txt | while read line
do
    if [[ $line != \#* ]]
    then
        echo "If auth:urn:oid:1.3.6.1.4.1.5923.1.1.1.6 eq \"$line\";"
        echo "   Deny unaffiliated.html"
    fi
done
cat shibuser.txt.post
} > shibuser.txt