#Table of Contents

---

#Certifications
Some information about my experience with the following certs:

* [CEH (Certified Ethical Hacker)](certifications/ceh.md)
* [OSCP (Offensive Security Certified Professional)](certifications/oscp.md)
* [OSWP (Offensive Security Wireless Professional)](certifications/oswp.md)

#Command Line Tools
* Go to the [index](cmdline/index.md) as it's now too big of a list to fit on this page!

#Hardware

##Pineapple
* [Initial setup (Mark V)](hardware/pineapple/pineapple.md) - essentially this is about the first few things to do to set DIP switches, get the thing on the network, etc.

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


#Pentesting
##Pentesting - administrative/procedural stuff
Some [administrative information](pentesting/admin/admin.md) to consider, like what to do on a pentest when you have no Internet access :-)

##Pentesting - defense/hardening
Just getting this page started, but starting to cobble together some good [defensive measures](pentesting/netpen/defense-hardening.md) to recommend to customers after a pentest.

##Pentesting - honeypots
An essential part of active defense *against* hackers/pentesters is setting up honeypots such as [OpenCanary](pentesting/honeypots/opencanary.md) to alert you when services are connected to.

##Pentesting - network-based ("netpen")
###Bloodhound
[Bloodhound](pentesting/netpen/bloodhound.md) is a great way to visually map out an AD environment - even if you've just got a limited shell.

###Break out
Learn how to [break out](pentesting/netpen/breakout.md) of restricted environments, such as Citrix portals and kiosks.

###Defense
I started a page about pentesting [defense](pentesting/netpen/defense.md) focusing on mitigating common vulnerabilities/exploits we see on pentests.

###Empire
[Empire](pentesting/netpen/empire.md), a post-exploitation PowerShell agent, is absolutely awesome.

###Privilege Escalation
A collection of cheatsheets and how-tos for [privesc](pentesting/netpen/privesc.md).

###Virtual machine setup
Information on getting a [Kali pentesting box setup](pentesting/vm-setup/vm-setup.md) with Burp and other tools.

###Vulnerability scanners
* [Nessus](vulnerability-scanners/nessus.md) - basic install on getting Lets Encrypt cert installed
* [OpenVAS](vulnerability-scanners/openvas.md) - basic install on Kali
* [Vulnerability databases](pentesting/vulnerability-scanners/vulnerability-databases.md) are a good place to check for vulnerabilities that Nessus/OpenVAS and others might not have built in.

##Pentesting - webapp
* [Burp configuration](pentesting/webapp/burp.md) - a quick "getting started" guide
* [Clickjacking](pentesting/webapp/clickjacking.md) - an easy POC you can use if you need to whip up a screenshot of what a clickjacking vuln looks like on a site that doesn't properly use the `X-FRAME-OPTIONS: SAMEORIGIN` header

##Pentesting - wireless
* [How to capture a WPA handshake](pentesting/wireless/wpa.md)

##Resources
###Best Practices (in my opinion ;-)
* [Internet safety](resources/best-practices/internetsafety.md) - general tips to stay safe(er) online
* [Setting up a secure PC/Mac](resources/best-practices/1sttimesetup.md) - a.k.a. "the first things I do after powering up a fresh machine"

###[Blogs](resources/blogs.md)
It would be impossible to list all the great security blogs out there, but these are some of my favs.

###[Books](resources/books.md)
I barely read anything that's not displayed on a screen, but when I *do*...

###[Health and Wellness](resources/health-and-wellness.md)
Lets face it, as IT/security people, sometimes our health is well-being is secondary to popping that box or getting that network gear installed.  

###[Podcasts](resources/podcasts.md)
Podcasts seem to be like opinions (everybody's got one!) but there are some great ones out there.

###[Twitter peeps I follow](resources/twitter.md)
Here are some folks/bots I follow on Twitter to try to stay on top of important infosec news and happenings.


##Scripts
Lil' scripts to do this, that and the other thing.

###Linux

* [backup-stuff.sh](scripts/linux/backup-stuff.sh) is a quick and easy script to make a .tgz file out of a folder full o' stuff
* [changemac](scripts/mac/changemac.md) will change the MAC on your, um....Mac!
* [disk-space-alert.sh](scripts/linux/disk-space-alert.sh) - uses [swaks](cmdline/linux/swaks.md) to send out an email alert when disk utilization reaches a certain threshold.
* [kali-essentials.sh](scripts/linux/kali-essentials.sh) - a big "git clone a bunch of stuff" script that I run right after installing a fresh Kali box.
* [kali-gitupdate.sh](scripts/linux/kali-gitupdate.sh) - will go through your Kali box and update any git repositories.


##Training
* [Programming and scripting](training/programming-and-scripting.md) has some good online sources for learning Python, PowerShell and the like
* [Vulnerable machine resources](training/vulnerable-machines.md) will help you practice and sharpen your pentest skills in a safe (and legal!) environment

#Web tech (blogs, bots and whatnots)
Like LAMP stuff, Ghost, Hugo and other thingies that get served up on Web technology.

* [Hugo](web/hugo.md) - how to setup this popular blogging platform
* [Limnoria](web/limnoria.md) - how to install and maintain this popular IRC bot
* [Minecraft](gaming/minecraft.md) - how to setup an MC server