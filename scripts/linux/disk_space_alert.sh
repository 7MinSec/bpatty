#!/bin/bash
#Change the "70" (in "$usep -ge 70") to whatever percentage threshold you want the alert set at.
#
mkdir /scripts
cd /scripts
ifconfig eth0 | grep 'inet' | cut -d: -f2 | awk '{print $2}' > /scripts/ipconfig.txt
df -H | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5 " " $1 }' | while read output;

do

  echo $output

  usep=$(echo $output | awk '{ print $1}' | cut -d'%' -f1  )

  partition=$(echo $output | awk '{ print $2 }' )

  if [ $usep -ge 10 ]; then

    echo "$(hostname) hard disk space breakdown is as follows: \"$partition ($usep%)\" as of $(date)" > check.txt

swaks --to you@you.com --from "me@me.com" --server smtp.gmail.com:587 -tls --auth-user me@me.com --auth-password 'YOURPASSGOESHERE' --header "Subject: [DISK ALERT!] This device is running low on disk space!" --body 'The SUCH_AND_SUCH DEVICE is running low on space.  Attached is disk usage and IP information!' --attach="check.txt" --attach="ipconfig.txt"

fi

done
