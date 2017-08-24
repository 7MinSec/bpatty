# You can stick this script in /etc/rc.local and it will email you with the IP of the system
#
mkdir /scripts
ifconfig eth0 | grep 'inet' | cut -d: -f2 | awk '{print $2}' > /scripts/ipconfig.txt
swaks --to you@you.com --from "me@me.com" --server smtp.gmail.com:587 -tls --auth-user me@me.com --auth-password 'yourpassgoeshere' --header "Subject: IT'S ALIIIIIVE!!!" --body 'This device has booted and attached is its IP information!' --attach /scripts/ipconfig.txt