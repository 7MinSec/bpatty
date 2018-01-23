# Mac system commands

createinstallmedia
--------
This command is handy for creating bootable OSX media.  The main help page I found for this tool is on [Apple's site](https://support.apple.com/en-us/HT201372) but the TLDR version is:

1. Download `MacOS Sierra` from the App Store.

2. If the OSX installer launches, quit it.

3. Put in the USB drive you want to load the bootable install on, and issue this in terminal (assuming *MY-USB-DRIVE* is your USB drive):

`sudo /Applications/Install\ macOS\ Sierra.app/Contents/Resources/createinstallmedia --volume /Volumes/MY-USB-DRIVE/ --application /Applications/Install\ macOS\ Sierra.app`

diskutil
--------
### To format a USB drive with an ESXi installer:
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

mkfile
-----
Mkfile is handy in...making files!

A great resource for that is [this site](http://osxdaily.com/2013/05/31/create-large-file-mac-os-x/) and here's an example I recently had to use:

     mkfile -n 20m big20meg.file

The above command made a 20meg file called `big20meg.file`

md5
--------
Good for generating md5 hashes.

    md5 name-of-file.ext

Example:

   BMacBook:Public brian$ openssl sha1 Vulnhub-BillyMadisonBeta01.zip
   SHA1(Vulnhub-BillyMadisonBeta01.zip)=422cd8fe6fe3ce8a69f609bb166a96c0e1caa210

openssl
--------
### To generate hashes:

   openssl sha1 name-of-file.ext

Example:

   BMacBook:Public brian$ openssl sha1 Vulnhub-BillyMadisonBeta01.zip
   SHA1(Vulnhub-BillyMadisonBeta01.zip)= 422cd8fe6fe3ce8a69f609bb166a96c0e1caa210

route
-----

To see your system's routing table:

     netstat -nr

If you need to add a route, you can do it like so:

     sudo route -n add 192.168.200.0/24 192.168.2.1

The example above is one I ran into when I was using OpenVPN and by default it was sending all traffic (even local) to through the VPN.  Basically anytime I tried to get to my 192.168.200.x subnet on my *local* network, it would come back as unavailable.  The command above forces my Mac to use my default gateway of 192.168.2.1 to get to the 192.168.200.x network.
