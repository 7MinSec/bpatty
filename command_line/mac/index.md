Mac command line
==================
# This is header 1
## This is header 2
### This is header 3
#### This is header 4

createinstallmedia.md
--------
This command is handy for creating bootable OSX media.  The main help page I found for this tool is on [Apple's site](https://support.apple.com/en-us/HT201372) but the TLDR version is:

1. Download `MacOS Sierra` from the App Store.

2. If the OSX installer launches, quit it.

3. Put in the USB drive you want to load the bootable install on, and issue this in terminal (assuming *MY-USB-DRIVE* is your USB drive):

`sudo /Applications/Install\ macOS\ Sierra.app/Contents/Resources/createinstallmedia --volume /Volumes/MY-USB-DRIVE/ --application /Applications/Install\ macOS\ Sierra.app`

md5
--------
Good for generating md5 hashes.

`md5 name-of-file.ext`

Example:

````
BMacBook:Public brian$ openssl sha1 Vulnhub-BillyMadisonBeta01.zip 
SHA1(Vulnhub-BillyMadisonBeta01.zip)=422cd8fe6fe3ce8a69f609bb166a96c0e1caa210
````
