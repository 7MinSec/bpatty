Table of contents:
---

# Command Line Tools
* Go to the [index](cmdline/index.md) as it's now too big of a list to fit on this page!

# Hardware

## Pineapple
* [Initial setup (Mark V)](hardware/pineapple/pineapple.md) - essentially this is about the first few things to do to set DIP switches, get the thing on the network, etc.

## Raspberry Pi
Stuff I know about RPis, including:

* [Installing Kali](hardware/raspberrypi/install-kali.md) - how to install distributions such as Kali Linux.

## Ubiquiti 
Their network gear is some of my fav'! Here's some tips/tricks on setting up and configuring...

### Edge Router X
* [Basic install](hardware/ubiquiti/edgerouterx/erx.md) of the switch, configuration of XBox UPNP, and setting up isolated guest networks.

### UniFi controller
* [Setup a cloud-hosted UniFi controller](hardware/ubiquiti/unifi/install-hosted-unifi-controller)
* [Install a LetsEncrypt certificate](hardware/ubiquiti/unifi/install-lets-encrypt-cert.md)


# Pentesting
## Pentesting - administrative/procedural stuff
Some [administrative information](pentesting/admin/admin.md) to consider, like what to do on a pentest when you have no Internet access :-)

## Pentesting - exploit info
A [page](pentesting/exploit-info/exploit-info.md) dedicated to pentesting specific exploits (right now just focusing on MS10-070)

## Pentesting - honeypots
An essential part of active defense *against* hackers/pentesters is setting up honeypots such as [OpenCanary](pentesting/honeypots/opencanary.md) to alert you when services are connected to.

## Pentesting - network-based ("netpen")
### Bloodhound
[Bloodhound](pentesting/netpen/bloodhound.md) is a great way to visually map out an AD environment - even if you've just got a limited shell.

### Break out
Learn how to [break out](pentesting/netpen/breakout.md) of restricted environments, such as Citrix portals and kiosks.

### Defense
I started a page about pentesting [defense](pentesting/netpen/defense-hardening.md) focusing on mitigating common vulnerabilities/exploits we see on pentests.

### Empire
[Empire](pentesting/netpen/empire.md), a post-exploitation PowerShell agent, is absolutely awesome.

### Forensics
This page is dedicated to performing various types of [forensics](pentesting/netpen/forensics.md) as part of incident response or system analysis.

### Privilege Escalation
A collection of cheatsheets and how-tos for [privesc](pentesting/netpen/privesc.md).

## Pentesting - Payloads and Passwords
Started a [payloads and passwords](pentesting/payloads/payloads-and-passwords.md) page

## Pentesting - Virtual machine setup
Information on getting a [Kali pentesting box setup](pentesting/vm-setup/vm-setup.md) with Burp and other tools.

## Pentesting - Vulnerability scanners
* [Nessus](vulnerability-scanners/nessus.md) - basic install on getting Lets Encrypt cert installed
* [OpenVAS](vulnerability-scanners/openvas.md) - basic install on Kali
* [Vulnerability databases](pentesting/vulnerability-scanners/vulnerability-databases.md) are a good place to check for vulnerabilities that Nessus/OpenVAS and others might not have built in.

## Pentesting - Webapp
* [Burp configuration](pentesting/webapp/burp.md) - a quick "getting started" guide
* [Clickjacking](pentesting/webapp/clickjacking.md) - an easy POC you can use if you need to whip up a screenshot of what a clickjacking vuln looks like on a site that doesn't properly use the `X-FRAME-OPTIONS: SAMEORIGIN` header
* [Webshells](pentesting/webapp/shells.md) - talks about some of my fav' Webshells to tinker with

## Pentesting - wireless
* [How to capture a WPA handshake](pentesting/wireless/wpa.md)

## Resources
### Best Practices (in my opinion ;-)
* [Internet safety](resources/best-practices/internetsafety.md) - general tips to stay safe(er) online
* [Setting up a secure PC/Mac](resources/best-practices/1sttimesetup.md) - a.k.a. "the first things I do after powering up a fresh machine"

### [Blogs](resources/blogs.md)
It would be impossible to list all the great security blogs out there, but these are some of my favs.

### [Books](resources/books.md)
I barely read anything that's not displayed on a screen, but when I *do*...

### Certifications
Some information about my experience with the following certs:

* [CEH (Certified Ethical Hacker)](resources/certifications/ceh.md)
* [OSCP (Offensive Security Certified Professional)](resources/certifications/oscp.md)
* [OSWP (Offensive Security Wireless Professional)](resources/certifications/oswp.md)

### [Health and Wellness](resources/health-and-wellness.md)
Lets face it, as IT/security people, sometimes our health is well-being is secondary to popping that box or getting that network gear installed.  

### [Podcasts](resources/podcasts.md)
Podcasts seem to be like opinions (everybody's got one!) but there are some great ones out there.

### Training
* [Programming and scripting](resources/training/programming-and-scripting.md) has some good online sources for learning Python, PowerShell and the like

* [Vulnerable machine resources](resources/training/vulnerable-machines.md) will help you practice and sharpen your pentest skills in a safe (and legal!) environment


### [Twitter](resources/twitter.md)
These are some folks/bots I follow on Twitter to try to stay on top of important infosec news and happenings.


## Scripts
Lil' scripts to do this, that and the other thing.

### Linux

* [backup-stuff.sh](scripts/linux/backup-stuff.sh) is a quick and easy script to make a .tgz file out of a folder full o' stuff
* [changemac](scripts/mac/changemac.md) will change the MAC on your, um....Mac!
* [disk-space-alert.sh](scripts/linux/disk-space-alert.sh) - uses [swaks](cmdline/linux/swaks.md) to send out an email alert when disk utilization reaches a certain threshold.
* [kali-essentials.sh](scripts/linux/kali-essentials.sh) - a big "git clone a bunch of stuff" script that I run right after installing a fresh Kali box.
* [kali-gitupdate.sh](scripts/linux/kali-gitupdate.sh) - will go through your Kali box and update any git repositories.

## Web tech (blogs, bots and whatnots)
Like LAMP stuff, Ghost, Hugo and other thingies that get served up on Web technology.

* [Hugo](web/hugo.md) - how to setup this popular blogging platform
* [Limnoria](web/limnoria.md) - how to install and maintain this popular IRC bot
* [Minecraft](gaming/minecraft.md) - how to setup an MC server
