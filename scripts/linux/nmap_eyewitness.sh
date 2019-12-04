#!/bin/bash
# This is a hacky script that I use to do scheduled scans of my client external networks.
# The basic idea is a folder with today's date is created, a scan of the client's IPs happens (IPs go in targets.txt),
# and then that follows up with an Eyewitness scan (https://github.com/FortyNorthSecurity/EyeWitness).
# The whole thing gets zipped up and then an email is sent to me letting me know the scan is done.

# Change to whatever your working directory is
cd /root/Desktop/NAME_OF_CLIENT
# Set variable for today's date
date=$(date +%F)
# Make a directory with today's date
mkdir $date
cd $date
# Do the nmap scan
nmap -Pn -sS -sU -T4 -iL ../targets.txt -v -oA $date > /dev/null
# "Prettify" the scan results using nmap-bootstrap.xsl (https://github.com/honze-net/nmap-bootstrap-xsl)
xsltproc -o $date.html /opt/nmap-bootstrap-xsl/nmap-bootstrap.xsl $date.xml
# Run Eyewitness against the results
/opt/eyewitness/EyeWitness.py -x $date.xml --all-protocols --no-prompt -d eyewitness
cd ..
# Create a zip of all the results
zip -P YOUR-PASSWORD -r $date-NAME_OF_CLIENT.zip $date
# Send an email to yourself to say the scan is done
swaks --to you@you.com --from "alerts@your.domain" --server smtp.gmail.com:587 -tls --auth-user alerts@your.domain --auth-password 'YOUR-PASSWORD' --header "Subject: [SERVER01] $date The NAME_OF_CLIENT scan is ready for pickup!" --body 'The NAME_OF_CLIENT scan is ready for pickup.'
