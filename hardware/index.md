# Hardware

Fing Box
------
I covered this on the [podcast](https://7ms.us/7ms-285-the-quest-for-critical-security-controls-part-2/) and *really* like it.  It's a neat, cheap ($120) device that helps satisfy some of the CISecurity Critical Security Controls.

One thing it *doesn't* do that I wish it did was support multiple VLANs.  As of 11/21/17 here's Fing's response to that question:

>At the moment we aren't considering adding multi-VLAN support directly into the Fingbox, but if you are interested in something for small business clients we are planning to integrate the possibility to add Domotz Pro to your Fingbox so you can turn it into a full monitoring system including multi-vlan support as well as remote access to devices etc. If you want more information on Domotz, check out www.domotz.com which can give you an idea if this will be something that could be helpful for your clients.

Pineapple
-------
Some stuff I tinker with on my old school Pineapple MK5

### Reset back to factory settings
* Set dipswitches to:
  * Up
  * Down
  * Down
  * Up
  * Up

Pwn Pulse
--------
I really, really like the [Pwn Pulse](https://www.pwnieexpress.com/products/pulse-device-detection) and have talked about it several podcast episodes, like [this one](https://7ms.us/7ms-255-pwnpro-101/) and [this one](https://7ms.us/7ms-260-pwnpro-101-part-2/).  This page is a dumping ground for all the tips/tricks and command line shortcuts that I use.

### Deploying Pulse into customer network
If the Pulse will just pull DHCP, plug it into their network and then do this type of nmap scan to find the device:

`nmap -Pn -p22, 443`

#### Egress filtering requirements
If the customer uses egress filtering, ensure they have the following ports/sites open:

* your-unique-FDQN.pwnieexpress.net – TCP/443
* sensors.pp-en.pwnieexpress.net – TCP/443
* updates.pwnieexpress.com – TCP/443
* kalirepo.pxinfra.net – TCP/443
* www.openvas.org – TCP/80
* feed.openvas.org – TCP/873

### Using reverse shell feature

#### Setting up accepted/denied hosts
First thing I like to do on my target for the reverse shell is allow *only* the customer's public IP(s) to connect to me.  So in Kali I edit `/etc/hosts.deny` and have the last line be:

`ALL: ALL`

Then, in `/etc/hosts.allow` I put in just the networks that are allowed to SSH into my Kali box.  Make sure to put your local subnet in there too if you're doing remote management!

````
ALL: 192.168.1.0/24
ALL: 12.34.56.78
````

#### Utilizing the reverse shell connection
Once you've run the revshell script (which you pull off the Pulse portal), you can open up a new window and directly SSH into the box by doing:

`ssh pwnie@localhost -p 3333`

#### Connecting to Nessus via reverse shell connection
On my Pulse I have Nessus installed.  To be able to hit this Web interface via reverse shell, do this:

`ssh pwnie@localhost -p 3333 -ND 8080`

Then type in your creds and the SSH window will appear to "hang" but this means the connection is up and listening.  

Now open up Firefox, install FoxyProxy and create a new proxy to 127.0.0.1 to port 8080 (make sure it's a SOCKS5 proxy!), then start funneling traffic through it.

You should now be able to hit your Nessus interface on https://x.x.x.x:8834.

#### Leveraging protocol forwarding
If you want to take advantage of something like RDP forwarding, open a new Terminal window and do:

`ssh pwnie@localhost -p 3333 -NL 3389:x.x.x.x:3389 `

Then you can `apt-get install remmina` on your Kali box, then open Remmina and RDP into localhost in order to get forwarded to the IP address specified in the command above!

Raspberry Pi
--------

### Imaging instructions for Mac

    sudo diskutil list
    sudo diskutil umount /dev/disk2
    (if this doesn't work, I issue this:) sudo diskutil unmountDisk /dev/disk2
    sudo dd if=kali-2.1.2-rpi.img of=/dev/disk2 bs=1m


### Reset root password
Once the RPi boots, I SSH in and reset the root password and generate new keys:

    rm /etc/ssh/ssh_host_*
    dpkg-reconfigure openssh-server
    service ssh restart

### Resize file system

Finally, I resize the file system with the built-in `rpi-wiggle` script:

    /scripts/rpi-wiggle.sh





Ubiquiti network gear
--------

### EdgeRouterX
A collection of tidbits for managing EdgeRouterX.  I did a full write-up on some of these things [here](https://7ms.us/7ms-217-installing-ubiquiti-edgerouter-x-and-ap-part-2/).

#### Xbox NAT setup
First setup a static IP for your Xbox, then use the commands below (thank you [this post](https://community.ubnt.com/t5/EdgeMAX/Xbox-1-Strict-NAT-problem/td-p/1371769/page/2) for the solution!!!) The one important prerequisite is to set your Xbox up with a static IP address - in the example below I used 192.168.7.77.

    configure
    set service upnp2 listen-on switch0.7
    set service upnp2 nat-pmp enable
    set service upnp2 secure-mode enable
    set service upnp2 wan eth1
    set service upnp2 acl rule 10 action deny
    set service upnp2 acl rule 10 description "Block default Xbox Live port 3074"
    set service upnp2 acl rule 10 external-port 3074
    set service upnp2 acl rule 10 local-port 0-65535
    set service upnp2 acl rule 10 subnet 192.168.7.0/24
    set service upnp2 acl rule 20 action allow
    set service upnp2 acl rule 20 description "Allow XBOX-1"
    set service upnp2 acl rule 20 external-port 1024-65535
    set service upnp2 acl rule 20 local-port 0-65535
    set service upnp2 acl rule 20 subnet 192.168.7.77/32

#### Creating isolated guest networks
Follow [this KB article](https://help.ubnt.com/hc/en-us/articles/218889067-EdgeMAX-How-to-Protect-a-Guest-Network-on-EdgeRouter) to setup segmented VLANs.

### Unifi Access Points

#### Install a hosted UniFi controller
I created an audio/video walkthrough [here](https://7ms.us/7ms-220-installing-ubiquiti-edgerouter-x-and-ap-part-3/) on this topic, but one of the most important things (to me) is to lock down your cloud access controller once it's setup.  For that I use the following iptables rules:

    sudo apt-get install iptables-persistent
    sudo service iptables-persistent start
    sudo iptables -F
    sudo iptables -A INPUT -i lo -j ACCEPT
    sudo iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
    sudo iptables -A INPUT -s my.public.ip.address -p tcp -m tcp --dport 22 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
    sudo iptables -A INPUT -s my.public.ip.address -p tcp -m tcp --dport 8081 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
    sudo iptables -A INPUT -s my.public.ip.address -p tcp -m tcp --dport 8080 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
    sudo iptables -A INPUT -s my.public.ip.address -p tcp -m tcp --dport 8443 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
    sudo iptables -A INPUT -s my.public.ip.address -p tcp -m tcp --dport 8880 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
    sudo iptables -A INPUT -s my.public.ip.address -p tcp -m tcp --dport 8843 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
    sudo iptables -A INPUT -s my.public.ip.address -p tcp -m tcp --dport 27117 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
    sudo iptables -A INPUT -s my.public.ip.address -p tcp -m tcp --dport 80 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
    sudo iptables -P INPUT DROP
    sudo iptables-save > /etc/iptables/rules.v4

Then, let your AP get "adopted" by the cloud access controller following [this article](https://community.ubnt.com/t5/UniFi-Routing-Switching/USG-cloud-controller/td-p/1156708).  The key command to issue is:

    set-inform http://ip.address-of.my-cloud.controller:8080/inform
