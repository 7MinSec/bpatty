#Table of Contents

---
#Best Practices (in my opinion ;-)
* [Internet safety](best-practices/internetsafety.md) - general tips to stay safe(er) online
* [1st time setup for a PC/Mac](best-practices/1sttimesetup.md) - a.k.a. "the first things I do after powering up a fresh machine"

#Command-line tools
##Linux

* [asciinema](cmdline/linux/asciinema.md)
* [bluto](cmdline/linux/bluto.md)
* [cat](cmdline/linux/cat.md)
* [curl](cmdline/linux/curl.md)
* [dirb](cmdline/linux/dirb.md)
* [du](cmdline/linux/du.md)
* [egress-check](cmdline/linux/egress-check.md)
* [git](cmdline/linux/git.md)
* [gpg](cmdline/linux/gpg.md)
* [grep](cmdline/linux/grep.md)
* [hashcat](cmdline/linux/hashcat.md)
* [hydra](cmdline/linux/hydra.md) 
* [iptables](cmdline/linux/iptables.md)
* [john (the ripper)](cmdline/linux/johntheripper.md)
* [mimikatz](cmdline/linux/mimikatz.md)
* [mysqldump](cmdline/linux/mysqldump.md)
* [ncrack](cmdline/linux/ncrack.md)
* [netcat](cmdline/linux/netcat.md)
* [nmap](cmdline/linux/nmap.md)
* [openssl](cmdline/linux/openssl.md)
* [proxychains](cmdline/linux/proxychains.md)
* [recon-ng](cmdline/linux/recon-ng.md)
* [responder](cmdline/linux/responder.md)
* [scanpbnj](cmdline/linux/scanpbnj.md)
* [scapy](cmdline/linux/scapy.md)
* [screen](cmdline/linux/screen.md)
* [sed](cmdline/linux/sed.md)
* [simplehttpserver](cmdline/linux/simplehttpserver.md)
* [ssh-keygen](cmdline/linux/ssh-keygen.md)
* [sslscan](cmdline/linux/sslscan.md)
* [sslyze](cmdline/linux/sslyze.md)
* [swaks](cmdline/linux/swaks.md)
* [tcpdump](cmdline/linux/tcpdump.md)
* [testssl](cmdline/linux/testssl.md)
* [wget](cmdline/linux/wget.md)
* [zip](cmdline/linux/zip.md)
 
##Mac
* [diskutil](cmdline/mac/diskutil.md)
* [md5](cmdline/mac/md5.md)
* [openssl](cmdline/mac/openssl.md)


##Windows
* [PowerShell](cmdline/windows/powershell.md)
* [robocopy](cmdline/windows/robocopy.md)

#Gaming
##Minecraft
How to setup a [Minecraft server](gaming/minecraft.md).

#Hardware

##Pineapple
* [Initial setup (Mark V)](hardware/pineapple/pineapple.md)

##Raspberry Pi
Stuff I know about RPis, including:

* [Installing Kali](hardware/raspberrypi/install-kali.md) - how to install distributions such as Kali Linux.

##Ubiquiti 
Their network gear is some of my fav'! Here's some tips/tricks on setting up and configuring...

###Edge Router X
* [Basic install](hardware/ubiquiti/edgerouterx/erx.md) of the switch, configuration of XBox UPNP, and setting up isolated guest networks.

###UniFi controller
* [Setup a cloud-hosted UniFi controller](hardware/ubiquiti/unifi/install-hosted-unifi-controller)
* [Install a LetsEncrypt certificate](hardware/ubiquiti/unifi/install-lets-encrypt-cert.md)


##Pentesting
###[Procedural/administrative stuff](pentesting/admin/admin.md)
Like what to do on a pentest when you have no Internet access :-)

###Network Pentesting
####Break out
Learn how to [break out](pentesting/netpen/breakout.md) of restricted environments, such as Citrix portals and kiosks.

###Bloodhound
Bloodhound is a great way to visually map out an AD environment - even if you've just got a limited shell.  Check out my [page](pentesting/netpen/bloodhound.md) on it.

###Empire
This post-exploitation PowerShell agent is absolutely awesome.  Check out my page on it [here](pentesting/netpen/empire.md)

####Privilege Escalation
A collection of cheatsheets and how-tos for [privesc](pentesting/netpen/privesc.md)

###[Virtual machine setup](pentesting/vm-setup/vm-setup.md)
Information on getting a Kali pentesting box setup with Burp and other tools.

###Vulnerability scanners
* [Nessus](vulnerability-scanners/nessus.md) - basic install on getting Lets Encrypt cert installed
* [OpenVAS](vulnerability-scanners/openvas.md) - basic install on Kali

###Webapp pentesting
* [Burp configuration (basic)](pentesting/webapp/burp.md)
* [Clickjacking](pentesting/webapp/clickjacking.md)

###Wireless pentesting
* [How to capture a WPA handshake](pentesting/wireless/wpa.md)

##Scripts
Lil' scripts to do this, that and the other thing

###Linux

* [backup-stuff.sh](scripts/linux/backup-stuff.sh) is a quick and easy script to make a .tgz file out of a folder full o' stuff
* [changemac](scripts/mac/changemac.md) will change the MAC on your, um....Mac!
* [disk-space-alert.sh](scripts/linux/disk-space-alert.sh) - uses [swaks](cmdline/linux/swaks.md) to send out an email alert when disk utilization reaches a certain threshold.
* [kali-essentials.sh](scripts/linux/kali-essentials.sh) - a big "git clone a bunch of stuff" script that I run right after installing a fresh Kali box.
* [kali-gitupdate.sh](scripts/linux/kali-gitupdate.sh) - will go through your Kali box and update any git repositories.


##Training
Check out these [vulnerable machine resources](pentesting/training/vulnerablemachines.md) which will help you practice and sharpen your pentest skills in a safe environment.

#Web tech (blogs, bots and whatnots)
Like LAMP stuff, Ghost, Hugo and other thingies that get served up on Web technology.

* [Hugo](web/hugo.md) - how to setup this popular blogging platform
* [Limnoria](web/limnoria.md) - how to install and maintain this popular IRC bot