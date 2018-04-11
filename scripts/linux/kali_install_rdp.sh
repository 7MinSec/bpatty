# kali_install_rdp.sh
# Updated November 11, 2017
#
# This is a primer on installing RDP on Kali.
# I don't know why it was so hard for me, but it was.
# I followed this article and snipped out pieces of it below.
# https://msitpros.com/?p=3209

sudo apt-get update -y
sudo apt-get remove gnome-core -y
sudo apt-get install lxde-core lxde kali-defaults kali-root-login desktop-base -y

echo At the next screen choose "/usr/bin/startlxde"
sudo update-alternatives –config x-session-manager

echo Now reboot and you should be good to go.
echo Don't forget to add xrdp and xrdp-sesman to startup if it
echo doesn't happen automagically
