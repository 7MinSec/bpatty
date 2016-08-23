# Kali install on RPi

First image an SD with a Kali image - here's instructions for a Mac:

    sudo diskutil list
    sudo diskutil umount /dev/disk2
    (if this doesn't work, I issue this:) sudo diskutil unmountDisk /dev/disk2
    sudo dd if=kali-2.1.2-rpi.img of=/dev/disk2 bs=1m
 
Once the RPi boots, I SSH in and reset the root password and generate new keys:

    rm /etc/ssh/ssh_host_*
    dpkg-reconfigure openssh-server
    service ssh restart

Finally, I resize the file system with the built-in `rpi-wiggle` script:

    /scripts/rpi-wiggle.sh
