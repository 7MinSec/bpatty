# diskutil 

## To format a USB drive with an ESXi installer:
I *heavily* borrowed this approach and associated commands [from this Github project](https://github.com/cbednarski/vmware-usb-osx/).  To prep:

* Download the ESXi ISO file to a folder on your machine and name it *esxi.iso*
* Download the syslinux.cfg file from the Github project link into the same folder
* In Terminal, `cd` to the destination directory where these two files live and do this: 

Terminal commands:

     diskutil list 
     
(*This command is to identify your USB drive...in most cases it's /dev/disk2 but be careful!!!  My commands below assume /dev/disk2!!11!111!!!!*)

     sudo diskutil eraseDisk MS-DOS ESXI MBR /dev/disk2
     mkdir -p source
     mkdir -p target
     hdiutil mount esxi.iso -mountpoint ./source
     cp -r source/ /Volumes/ESXI/
     cp syslinux.cfg /Volumes/ESXI/
     hdiutil eject ./source
     diskutil unmountDisk /dev/disk2
     diskutil eject /dev/disk2