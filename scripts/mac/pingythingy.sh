# pingythingy v0.1
# Brian Johnson, 7 Minute Security (7MinSec.com)
# Basically this script pings an Internet resource of your choice (in this case, 8.8.8.8)
# and logs the results to the text file of your choice (in this case, ./pinglog.txt)
ping -i 2 8.8.8.8 | while read pong; do echo "$(date -j '+%Y-%m-%d %H:%M:%S') $pong" 1>>./pinglog.txt;done
