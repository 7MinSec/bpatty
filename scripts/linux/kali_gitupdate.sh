#!/bin/bash
# This script is to update all git repositories on your Kali box
# Author unknown - if you know whose it is let me know and I'll gladly give credit! -braimee
 
# Get current directory
CUR_DIR=$(pwd)
 
echo -e "\n\033[1mDownload updates for all git repositories...\033[0m\n"
 
# Find all git repositories and update
for i in $(find . -name ".git" | cut -c 3-); do
        echo "";
        echo -e "\033[33m"+$i+"\033[0m";
             
        # Go to .git parent directory and use pull command
        cd "$i";
        cd ..;
                         
        # Do the pull
        git pull origin master;
                                 
        # Go back to current dir
        cd $CUR_DIR
done
                                     
echo -e "\n\033[32mDone!\033[0m\n"
