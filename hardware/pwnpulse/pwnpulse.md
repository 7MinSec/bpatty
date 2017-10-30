# Pwn Pulse
I really, really like the [Pwn Pulse](https://www.pwnieexpress.com/products/pulse-device-detection) and have talked about it several podcast episodes, like [this one](https://7ms.us/7ms-255-pwnpro-101/) and [this one](https://7ms.us/7ms-260-pwnpro-101-part-2/).  This page is a dumping ground for all the tips/tricks and command line shortcuts that I use.

## Deploying Pulse into customer network
If the Pulse will just pull DHCP, plug it into their network and then do this type of nmap scan to find the device:

`nmap -Pn -p22, 443`

### Egress filtering requirements
If the customer uses egress filtering, ensure they have the following ports/sites open:

* your-unique-FDQN.pwnieexpress.net – TCP/443
* sensors.pp-en.pwnieexpress.net – TCP/443
* updates.pwnieexpress.com – TCP/443
* kalirepo.pxinfra.net – TCP/443
* www.openvas.org – TCP/80
* feed.openvas.org – TCP/873

## Using reverse shell feature

### Setting up accepted/denied hosts
First thing I like to do on my target for the reverse shell is allow *only* the customer's public IP(s) to connect to me.  So in Kali I edit `/etc/hosts.deny` and have the last line be:

`ALL: ALL`

Then, in `/etc/hosts.allow` I put in just the networks that are allowed to SSH into my Kali box.  Make sure to put your local subnet in there too if you're doing remote management!

````
ALL: 192.168.1.0/24
ALL: 12.34.56.78
````

### Utilizing the reverse shell connection
Once you've run the revshell script (which you pull off the Pulse portal), you can open up a new window and directly SSH into the box by doing:

`ssh pwnie@localhost -p 3333`

#### Connecting to Nessus via reverse shell connection
On my Pulse I have Nessus installed.  To be able to hit this Web interface via reverse shell, do this:

`ssh pwnie@localhost -p 3333 -ND 8080`

Then type in your creds and the SSH window will appear to "hang" but this means the connection is up and listening.  

Now open up Firefox, install FoxyProxy and create a new proxy to 127.0.0.1 to port 8080 (make sure it's a SOCKS5 proxy!), then start funneling traffic through it.

You should now be able to hit your Nessus interface on https://x.x.x.x:8834.

#### Leveraging protocol fowarding
If you want to take advantage of something like RDP forwarding, open a new Terminal window and do:

`ssh pwnie@localhost -p 3333 -NL 3389:x.x.x.x:3389 `

Then you can `apt-get install remmina` on your Kali box, then open Remmina and RDP into localhost in order to get forwarded to the IP address specified in the command above!
