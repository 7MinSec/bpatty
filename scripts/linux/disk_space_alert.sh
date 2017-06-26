#!/bin/sh
#Change the "70" (in "$usep -ge 70") to whatever percentage threshold you want the alert set at.
#
df -H | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5 " " $1 }' | while read output;

do

  echo $output

  usep=$(echo $output | awk '{ print $1}' | cut -d'%' -f1  )

  partition=$(echo $output | awk '{ print $2 }' )

  if [ $usep -ge 70 ]; then

    echo "$(hostname) hard disk space breakdown is as follows: \"$partition ($usep%)\" as of $(date)" > check.txt |swaks --to me@me.com --from "me@me.com" --server your.email.server.address --header "Subject: [ALERT] This server is running low on disk space!" --attach="check.txt"

fi

done