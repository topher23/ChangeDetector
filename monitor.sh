#!/bin/bash

# monitor.sh - Monitors a web page for changes
# sends an email notification if the file change

USERNAME=$1
PASSWORD=$2
URL=$3
TO=$4

for (( ; ; )); do
    mv new.html old.html 2> /dev/null
    curl $URL -L --compressed -s > original.html
    
    python trim.py > new.html
    
    DIFF_OUTPUT="$(diff new.html old.html)"
    if [ "0" != "${#DIFF_OUTPUT}" ]; then
        sendEmail -f $USERNAME -s smtp.gmail.com:587 \
            -xu $USERNAME -xp $PASSWORD -t $TO \
            -o tls=yes -u "SITE HAS CHANGED" \
            -m "Your site has changed! Visit it at $URL"
        echo "THERE HAS BEEN A CHANGE"
    exit 1
    fi

    echo "no change. Another Run"
    sleep $(shuf -i 3-6 -n 1)
done
