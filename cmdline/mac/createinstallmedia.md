# createinstallmedia.md

This command is handy for creating bootable OSX media.  The main help page I found for this tool is on [Apple's site](https://support.apple.com/en-us/HT201372) but the TLDR version is:

1. Download `MacOS Sierra` from the App Store.

2. If the OSX installer launches, quit it.

3. Put in the USB drive you want to load the bootable install on, and issue this in terminal (assuming *MY-USB-DRIVE* is your USB drive):

`sudo /Applications/Install\ macOS\ Sierra.app/Contents/Resources/createinstallmedia --volume /Volumes/MY-USB-DRIVE/ --application /Applications/Install\ macOS\ Sierra.app`
