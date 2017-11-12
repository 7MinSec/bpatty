Linux command line
==================
# This is header 1
## This is header 2
### This is header 3
#### This is header 4

arpwatch
--------
*arpwatch* looks to be a cool way to partially satisfy [Critical Security Control #1](https://www.cisecurity.org/controls/) (Inventory of Authorized and Unauthorized Devices).  The idea is you use arpwatch to keep an eye on all MAC addresses in the environment, and get alerted when new devices pop up.  

I've not dug too much into it yet, but here's a great [how to guide](https://www.virtualizationhowto.com/2016/02/arpwatch-smtp-configuration/) that I found.

asciinema
--------
Creates ascii "movies" that record keystrokes and output (good for when you're doing a lot of command line work and want to have log of it later).

To install:

`curl -sL https://asciinema.org/install | sh`

To begin a recording while eliminating any gaps in time over 1 second and saving the file to FILENAME:

`asciinema rec -w 1 -t "My title" NAME-OF-FILE`

To play the file back:

`asciinema  -play FILENAME`

bluto
--------
Bluto’s a neat tool that does DNS brute forcing, some Googling and other social-y/recon-y stuff.

To install:

`sudo pip install git+git://github.com/RandomStorm/Bluto`

Then type bluto plus the domain name and you’re good to go!

cat
--------
A nice utility for concatenating and printing files.

### Use cases:

#### Get unique words out of a file

*This* command is nice if you've got a large file full of various text, numbers, etc. and you need an output of *just* unique words from it:

`cat comment_file.txt | tr " " "\n" | sort | uniq`

#### Clear Linux terminal history

`cat /dev/null /home/brian/.bash_history`

### Command line switches

#### -s
According to the man page, this will "squeeze multiple adjacent empty lines, causing the output to be single spaced."

So if you have a file called `spacey.txt` with something like:

````
    Line 1
    (empty space)
    (empty space)
    Line 2
````

If you run it through `cat -s spacey.txt` the output will be:

````
    Line 1
    (empty space)
    Line 2
````

curl
--------
A great util to slurp Web stuff off of Web sites

### To check if a site uses HSTS:

`curl -s -D- https://test.com | grep Strict`

dirb
--------
Dirb is my favorite tool for brute-crawling Web directories.  Here’s an example of dirb’ing a site and exporting the results to a text file:

`dirb https://somesite.com /usr/share/wordlists/dirb/big.txt -o somesite.txt`

du
--------
Commands to get various disk usage stats.  

One of my favorites is this command, which gives you a list of root folders and their sizes (helps find bloated folders)

`du -h --max-depth=1 / | sort -h`

To find top 20 offenders in a directory:

`du -sh /opt | sort -hr | head -n 20`

`du -sh /var | sort -hr | head -n 20`

egresscheck-framework
--------
This is a nice tool for checking what ports are open between two network segments.  So lets say you have PC1 on 192.168.0.10 and PC2 on a different subnet at 192.168.1.222..0

* First [get the framework](https://github.com/stufus/egresscheck-framework).
* On PC1, run `python ecf.py`
* Set your source IP by typing `set SOURCEIP 192.168.0.10`
* Then set your target IP by typing `set TARGETIP 192.168.1.222`
* Set your port range (I like testing everything) by typing `set ports 1-65535`
* Test both TCP and UDP by typing `set PROTOCOL all`
* Type `get` and hit Enter to confirm your selections on PC1.
* Now type `generate tcpdump` - you will be given a command to run on PC2 starting with `tcpdump -n -U -w /tmp/egress...` - run that command on PC2 now.
* Back at PC1, type `generate python-cmd` (or `generate powershell-cmd` for a PS one-liner) to generate a Python one-liner to run on PC1 to pass traffic to PC2.  
* Type `exit` to leave the tool, then run the Python one-liner on PC1.
* When the Python one-liner completes, go to PC2 and *Ctrl+C* the tcpdump job.
* Then, run the two *tshark* commands (generated when you ran *generate tcpdump*) on PC2 in order to parse the TCP/UDP ports open between the two hosts.  For example, my commands were:

---

`tshark -r 03-18-16.pcap -Tfields -eip.proto -eip.src -etcp.dstport tcp | sort -u #For received TCP`


`tshark -r 03-18-16.pcap -Tfields -eip.proto -eip.src -eudp.dstport udp | sort -u #For received UDP`

git
--------
A way to, um, git stuff.

### Git - the simple guide
This is "just a [simple guide](http://rogerdudler.github.io/git-guide/) for getting started with git. no deep s*** ;)"

*To add: the way to specify a branch to "git"*

gpg
--------

This tool generates PGP keypairs.

Check out [this guide](http://linux.koolsolutions.com/2009/03/17/gpgpgp-keys-part-1-generating-gpgpgp-keys-on-debian-linux/) for more info.

Follow the steps to create the key.  Then list the keys using:

`gpg --list-keys`

In the output you'll see a line like this:

**pub 2048R/1234569 2015-12-29**

The 1234569 identifies your unique key.  Keep this in mind.

To backup your keys, reference http://linux.koolsolutions.com/2009/04/01/gpgpgp-part-5-backing-up-restoring-revoking-and-deleting-your-gpgpgp-keys-in-debian/

This command will backup your public key:

`gpg -ao mypub.key --export 1234569`

This will backup your private key:

`gpg -ao myprivate.key --export-secret-keys 1234569`

Another great resource for creating keys, signing messages, etc. is:
[https://www.digitalocean.com/community/tutorials/how-to-use-gpg-to-encrypt-and-sign-messages-on-an-ubuntu-12-04-vps](https://www.digitalocean.com/community/tutorials/how-to-use-gpg-to-encrypt-and-sign-messages-on-an-ubuntu-12-04-vps)

grep
--------
A tool for finding words/lines matching a pattern. Some handy examples below:

Searching a file for an *exact* match:

`grep -w "some exact string you want to find" name-of-file-you-are-searching`

Searching the current dir and all sub-dirs for something, like

`grep word-you-are-searching-for -r *`

If you want to see what line a given string appears on in a file, do something like:

`grep -n brianjohnson /usr/share/wordlists/rockyou.txt`

hashcat
--------
An awesome pw-cracking utility.  I like that you can run it against a whole folder full of .rule files, so if I just want to throw a basic "kitchen sink" of wordlists against a .txt doc, I'd do:

`hashcat -m 5500 -a 1 NTLM-hashes-2-be-cracked.txt /usr/share/hashcat/rules/*.rule`

This is a great rule set to get as well: [https://github.com/praetorian-inc/Hob0Rules](https://github.com/praetorian-inc/Hob0Rules).  

hydra
--------
Another great app for brute-forcing services.  Here's an example for brute'in RDP:

`hydra -t 4 -V -l administrator -P 500-worst-passwords.txt rdp://f.q.d.n`

Here's another example for SSH:

`hydra -l root -P /your/password/list.txt 1.2.3.4 ssh`

iptables
--------
Here are some commands I find useful when working with my Digital ocean droplets:

List all rules

`sudo iptables -L`

List rules by number

`sudo iptables -L --line-numbers`

To then delete a rule by number:

`sudo iptables -D INPUT 3 (for rule 3)``

Flush existing rules:

`sudo iptables -F`

Allow all concurrent connections:

`sudo iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT`

Allow ANY host to access a port, such as SSH:

`sudo iptables -A INPUT -p tcp --dport 22 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT`

Allow specific IPs/hosts to access port 80

`sudo iptables -A INPUT -p tcp -s F.Q.D.N --dport 80 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT`

Allow specific IPs/hosts to access port 22

`sudo iptables -A INPUT -p tcp -s F.Q.D.N --dport 22 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT`

Block all other traffic:

`sudo iptables -P INPUT DROP`

Provide the VPS loopback access:

`sudo iptables -I INPUT 1 -i lo -j ACCEPT`

Install iptables-persistent to ensure rules survive a reboot:

`sudo apt-get install iptables-persistent`

Start iptables-persistent service:

`sudo service iptables-persistent start`

If you make iptables changes after this and they don't seem to stick, do this:

`sudo iptables-save > /etc/iptables/rules.v4`

Save a copy of iptables rules for later:

`sudo iptables-save > name-of-file.txt`

See [this Digital Ocean article](https://www.digitalocean.com/community/tutorials/how-to-set-up-a-firewall-using-iptables-on-ubuntu-12-04) for more information.

## Sample basic configuration
If I spin up a new Digital Ocean droplet, my starter config might be like the following, which locks down http/ssh access to only me while I test stuff out:

```
sudo apt-get install iptables-persistent
sudo service iptables-persistent start
sudo iptables -F
sudo iptables -A INPUT -i lo -j ACCEPT
sudo iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A INPUT -s my.public.ip.address -p tcp -m tcp --dport 22 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
sudo iptables -A INPUT -s my.public.ip.address -p tcp -m tcp --dport 80 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
sudo iptables -P INPUT DROP
sudo iptables-save > /etc/iptables/rules.v4
```
Then when I want to give "everybody" access to the Web site, I'll do this:

`sudo iptables -L --line-numbers`

Then for the HTTP rule, I yank it out with:

`sudo iptables -D INPUT 3 (for rule 3)``

Then I let "anybody" access HTTP with:

`sudo iptables -A INPUT -p tcp --dport 80 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT`

##Configuration for a Unifi hosted controller:
This config opens the necessary ports so that *just* your IP address (identified by *my.public.ip.address*), as well as the servers for the Uptime Robot service, has access to the necessary ports:

```
  sudo iptables -F
  sudo iptables -A INPUT -i lo -j ACCEPT
  sudo iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
  sudo iptables -A INPUT -s MY.PUBLIC.IP.ADDRESS -p tcp -m tcp --dport 22 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
  sudo iptables -A INPUT -s MY.PUBLIC.IP.ADDRESS -p tcp -m tcp --dport 8081 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
  sudo iptables -A INPUT -s MY.PUBLIC.IP.ADDRESS -p tcp -m tcp --dport 8080 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
  sudo iptables -A INPUT -s MY.PUBLIC.IP.ADDRESS -p tcp -m tcp --dport 8443 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
  sudo iptables -A INPUT -s MY.PUBLIC.IP.ADDRESS -p tcp -m tcp --dport 8880 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
  sudo iptables -A INPUT -s MY.PUBLIC.IP.ADDRESS -p tcp -m tcp --dport 8843 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
  sudo iptables -A INPUT -s MY.PUBLIC.IP.ADDRESS -p tcp -m tcp --dport 27117 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
  sudo iptables -A INPUT -s MY.PUBLIC.IP.ADDRESS -p tcp -m tcp --dport 80 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
  sudo iptables -A INPUT -s MY.PUBLIC.IP.ADDRESS -p tcp -m tcp --dport 8834 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
  sudo iptables -A INPUT -s engine5.uptimerobot.com -p tcp -m tcp --dport 8834 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
  sudo iptables -A INPUT -s engine6.uptimerobot.com -p tcp -m tcp --dport 8834 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
  sudo iptables -A INPUT -s engine7.uptimerobot.com -p tcp -m tcp --dport 8834 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
  sudo iptables -A INPUT -s engine8.uptimerobot.com -p tcp -m tcp --dport 8834 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
  sudo iptables -A INPUT -s engine9.uptimerobot.com -p tcp -m tcp --dport 8834 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
  sudo iptables -A INPUT -s engine10.uptimerobot.com -p tcp -m tcp --dport 8834 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
  sudo iptables -A INPUT -s engine11.uptimerobot.com -p tcp -m tcp --dport 8834 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
  sudo iptables -A INPUT -s engine12.uptimerobot.com -p tcp -m tcp --dport 8834 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
  sudo iptables -A INPUT -s engine13.uptimerobot.com -p tcp -m tcp --dport 8834 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
  sudo iptables -A INPUT -s engine14.uptimerobot.com -p tcp -m tcp --dport 8834 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
  sudo iptables -A INPUT -s engine15.uptimerobot.com -p tcp -m tcp --dport 8834 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
  sudo iptables -A INPUT -s engine16.uptimerobot.com -p tcp -m tcp --dport 8834 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
  sudo iptables -A INPUT -s engine17.uptimerobot.com -p tcp -m tcp --dport 8834 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
  sudo iptables -A INPUT -s remote1.uptimerobot.com -p tcp -m tcp --dport 8834 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
  sudo iptables -A INPUT -s engine2.uptimerobot.com -p tcp -m tcp --dport 8834 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
  sudo iptables -A INPUT -s engine3.uptimerobot.com -p tcp -m tcp --dport 8834 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
  sudo iptables -A INPUT -s engine4.uptimerobot.com -p tcp -m tcp --dport 8834 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
  sudo iptables -A INPUT -s engine5.uptimerobot.com -p tcp -m tcp --dport 8834 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
  sudo iptables -A INPUT -s engine6.uptimerobot.com -p tcp -m tcp --dport 8834 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
  sudo iptables -A INPUT -s engine7.uptimerobot.com -p tcp -m tcp --dport 8834 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
  sudo iptables -A INPUT -s engine8.uptimerobot.com -p tcp -m tcp --dport 8834 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
  sudo iptables -A INPUT -s engine9.uptimerobot.com -p tcp -m tcp --dport 8834 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
  sudo iptables -A INPUT -s engine10.uptimerobot.com -p tcp -m tcp --dport 8834 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
  sudo iptables -A INPUT -s engine11.uptimerobot.com -p tcp -m tcp --dport 8834 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
  sudo iptables -P INPUT DROP
  sudo iptables-save > /etc/iptables/rules.v4
```

john (a.k.a. john the ripper)
--------
A fantastic tool for cracking passwords.  A fantastic reference for hashes and cracking is the [Pentest Monkey cheat sheet](http://pentestmonkey.net/cheat-sheet/john-the-ripper-hash-formats) but here's a few specific commands I've run to crack hashes:

`john --format=netntlm hashes-i-collected.txt --wordlist=/usr/share/seclists/Passwords/rockyou.txt`

Check this great presentation on password cracking from [Derby Con 2015](http://www.irongeek.com/i.php?page=videos/derbycon5/fix-me18-my-password-cracking-brings-all-the-hashes-to-the-yard-larry-pesce)

mimikatz
--------
A great tool for gathering credential data from Windows systems.

A fantastic "unofficial" guide is here: http://adsecurity.org/?page_id=1821

Here's a mimikatz cheat sheet maintained on Github:
[https://github.com/mdsecresearch/Publications/blob/master/cheatsheets/RedRelease.pdf](https://github.com/mdsecresearch/Publications/blob/master/cheatsheets/RedRelease.pdf)

mysqldump
--------
Handy for dumping out backups of mysql dbs

## To dump a backup
`mysqldump -u name-of-admin-user -p password > outputfile.sql`

ncrack
--------
An app for brute-forcing credentials in RDP, SSH, etc.  An example of brute-forcing RDP:

`ncrack -v -u administrator -P /opt/SecLists/Passwords/rockyou.txt -p 3389 f.q.d.n`

netcat
--------
Here's a great [cheat sheet](https://www.sans.org/security-resources/sec560/netcat_cheat_sheet_v1.pdf) from SANS.

nmap
------
Port scanner + a zillion other things. Here's a great [cheat sheet](https://pentestlab.wordpress.com/2012/08/17/nmap-cheat-sheet/) to help you setup the most common kinds of scans.

## A few great quick references:
* [HighOnCoffee nmap cheat sheet (Highoncoffee)](https://highon.coffee/blog/nmap-cheat-sheet/)
* [NixCraft's Top 30 Nmap Command Examples For Sys/Network Admins (Cyberciti.biz)](https://www.cyberciti.biz/networking/nmap-command-examples-tutorials/)
* [Top 10 nmap Commands Every Sysadmin Should Know (Bencane.com)](http://bencane.com/2013/02/25/10-nmap-commands-every-sysadmin-should-know/)
* [NMAP cheat sheet (Hackertarget.com)](https://hackertarget.com/nmap-cheatsheet-a-quick-reference-guide/)
* [Information on timing and performance (nmap.org)](https://nmap.org/book/man-performance.html)
* [Using timing templates in nmap (cyberpedia.in)](http://cyberpedia.in/using-timing-templates-in-nmap/)

## Basic scans

### Ping sweep

`nmap -sn 192.168.1.0/24`

### Find all active IPs in a network:

`nmap -sP 192.168.1.0/24; arp-scan --localnet  | grep "192.168.1.[0-9]* *ether"``

*Source: [CommandLineKungFu](http://www.commandlinefu.com/commands/view/18230/find-all-active-ip-addresses-in-a-network)*

### Find active IPs in a network AND export to a nice clean text file:

`nmap -n -sn -v 192.0.2.0/24 -oG - | awk '/Up$/{print $2}' > ips.txt`

### Thorough and quick TCP scan:

`nmap -p 1-65535 -sV -sS -T4 the.target.ip.address`

### Scan of all ports while ignoring ping, using a target list of *targets.txt* and exporting output to all 3 formats (called OUTPUT) and also using very verbose output

`nmap -p 1-65535 -sV -sS -T4 -Pn -iL targets.txt -oA OUTPUT -vv`

### Scanning some popular/common open ports
`nmap -PE -PM -PS 21,22,23,25,26,53,80,81,110,111,113,135,139,143,179,199,443,445,465,514,548,554,587,993,995`

### Scan the top 1000 ports - both TCP/UDP - and export to all 3 formats (called OUTPUT)

`nmap -vv -O -Pn -sTUV –top-ports 1000 -oA output the.target.ip.address`

*Thanks [Daniel Miessler](https://danielmiessler.com/blog/nmap-use-the-top-ports-option-for-both-tcp-and-udp-simultaneously/#gs.kgigV7M)*

### UDP scan

`nmap -p 1-65535 -sU the.target.ip.address`

### Scan through a proxy

`nmap 1.2.3.4 --proxy PROXYHOST:PORT`

## Advanced scans

### Find low hanging fruit w/nmap + searchsploit

`nmap -p- -sV -oX a.xml **ip**; searchsploit --nmap a.xml`

*Source: [g0tmi1k](https://twitter.com/g0tmi1k/status/793844870481846272)*

## Scripting engine

`--script`

Calls the scripting engine to do one of katrillions of things.

### http-method

`http-methods`
will show what http methods are available on a site such as track and trace.  Example:

`nmap -p 80,443 --script http-methods 1.2.3.4`

### ms-sql-info

This will poll the host for basic sql information:

`nmap f.q.d.n --script=ms-sql-info.nse`

### ssl-cert / ssl-enum-ciphers    

This checks cert information, weak ciphers and SSLv2.

`nmap -p80,443 --script ssl-cert,ssl-enum-ciphers 1.2.3.4`

## Other helpful nmap tools

* [Ndiff](https://nmap.org/ndiff/) "is a tool to aid in the comparison of Nmap scans."
* [Seccubus](https://www.seccubus.com/) "automates vulnerability scanning with: Nessus, OpenVAS, NMap, SSLyze, Medusa, SkipFish, OWASP ZAP and SSLlabs."

openssl
-------

Command line utility to test for various SSL configs and vulns.  A great resource I've found for this is [Explore Security's SSL manual cheatsheet](http://www.exploresecurity.com/wp-content/uploads/custom/SSL_manual_cheatsheet.html).

To test for RC4 ciphers (yep, I still have to do that quite a bit!):

`openssl s_client -cipher RC4 -connect site:port`

proxychains
-------
Proxychains is a handy way to leverage shells (such as via Meterpreter) to do other attacks/scans with tools that reside on the same box the shell lives on.

Here's pretty much the go-to article for configuration [https://www.offensive-security.com/metasploit-unleashed/proxytunnels/](https://www.offensive-security.com/metasploit-unleashed/proxytunnels/)

recon-ng
--------
Open source reconnaissance framework.

* Here's a nice tutorial + video on it: [https://strikersecurity.com/blog/getting-started-recon-ng-tutorial/](https://strikersecurity.com/blog/getting-started-recon-ng-tutorial/)

* And another: [https://www.youtube.com/watch?v=CyKkun8dZjE](https://www.youtube.com/watch?v=CyKkun8dZjE)

Responder
--------
A network poisoner and fantastic for grabbing hashes for further cracking.  [Grab the tool](https://github.com/SpiderLabs/Responder) and then take careful look at the help (`responder.py -h`) to ensure you're launching with the right flags, as stuff can break.  I usually use:

`python /opt/Responder/Responder.py -I eth0 -Ffr`

Then, once things are getting poisoned, it's easy to "watch" the logs directory for .txt files of hashes by doing:

`watch -n5 cat /opt/Responder/logs/*.txt`

Now, I'm not interested in system accounts with a dollar sign in them, so to see accounts *without* that character, you can do:

`grep -v '\$' /opt/Responder/logs/*.txt`

scanpbnj
--------
Scanpbnj is a great way to leverage nmap to make a scanning point in time snapshot.  Then you can run the same scanpbnj scan again and see the diffs that come out of the scan.  Get the tool info [here](https://www.aldeid.com/wiki/ScanPBNJ).  There's also a great help reference I use [here](http://spl0it.org/files/PBNJ-sysadmin-article-feb07.html).  

To install:

`sudo apt-get install pbnj`

If you have problems running the tool after installing it, you might have to also install libperl shell with:

`apt-get install libshell-perl`

Here's kind of my go-to command for using scanpbnj:

`scanpbnj -i targets.txt -a '-PE -PM -PS -sTU --top-ports 1000'`

You could certainly add the `V` to `sTUV` to get versioning information but I'm not as concerned about that when I'm just trying to spot what ports/services change between scans.

scapy
--------
Here's a slick [cheat sheet](http://pen-testing.sans.org/blog/2016/04/05/scapy-cheat-sheet-from-sans-sec560) for using scapy.

scp
--------
A few handy *scp* commands:

## Download folder full of files from a remote host to your local machine

Connect to a host over SCP, then download a root folder (and everything in it) called `/cap`:

`scp -r root@192.168.3.101:/path/to/folder-you/want-to/download .`

## Download a folder full of files over reverse ssh connection

For example, if you're using a PwnPulse and have a reverse shell bound to port 3333, you can SCP directly to the Pulse with:

`scp -r -P 3333 root@192.168.3.101:/folder-you-want-to-download .`

## Upload a file to a remote host

`scp /my/local/file.txt root@destination:/the/folder/to/upload/to`

screen
--------
"Screen is a console application that allows you to use multiple terminal sessions within one window. The program operates within a shell session and acts as a container and manager for other terminal sessions, similar to how a window manager manages windows."

Info here is heavily referenced from [this Digital Ocean support article](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-screen-on-an-ubuntu-cloud-server).  
## Start a new screen session

`screen -R name-of-session`

Once you're running ssh or whatever you wanna leave running, hit `Ctrl+a d` to escape out of the screen session and leave it running.

To see all open *screen* sessions:

`screen -ls`

If you had one called *bot* for example, you could reattach to it with:

`screen -R bot`

## Kill a screen session
I usually just have one session going so I like to *kill 'em all!!!* ;-)

`killall screen`

sed
--------
A stream editor.

I don't use `sed` a whole lot, but here are some examples where it really saved my butt.

## Delete sentences starting with "this" and ending with "that"

*Aaaaanyway* I wanted a way to quickly go through my episode guide Markdown document and strip out all sentences starting with `<iframe>` and ending with `</iframe>`.  Here was the `sed` command to do just that:

`sed -e 's/\<iframe.*\>//' episodes.md > episodes2.md`

## Doing a "rip and replace" of IPs in a file
For the [Tommy Boy](https://7ms.us/tommyboy/) VM, I needed a Wordpress database to be updated with whatever IP the VM booted with.  To do that, I (ab)used the gracious help of one of [g0tmi1k](https://blog.g0tmi1k.com)'s scripts which queried the VM's lan IP with:

`lanip=$(ip addr | grep inet | grep -v '127.0.0.1' | cut -d"/" -f1 | awk '{print $2}' | head -n 1)``

And then replaced it in a file by doing:

`sed "s/x\.x\.x\.x/${lanip}/g" input-file output-file`

SimpleHTTPServer
--------
Starts up a HTTP server on port 8000 in whatever directory you run the command from:

`python -m SimpleHTTPServer`

If the server you've got a shell on won't allow outbound connections to ports like *8000* you can specify a different outbound port with:

`python -m SimpleHTTPServer 80`

sqlmap
--------
The sqlmap [project](https://github.com/sqlmapproject/sqlmap) is an "automatic SQL injection and database takeover tool."

## Usage
* Check out the [wiki](https://github.com/sqlmapproject/sqlmap/wiki/Usage) for the down n' dirty command line Kung Fu
* OWASP has a nice [automated audit using SQLmap](https://www.owasp.org/index.php/Automated_Audit_using_SQLMap) page with this handy general syntax:

````
python sqlmap.py -v 2 --url=http://mysite.com/index --user-agent=SQLMAP --delay=1 --timeout=15 --retries=2
--keep-alive --threads=5 --eta --batch --dbms=MySQL --os=Linux --level=5 --risk=4 --banner --is-dba --dbs --tables --technique=BEUST
-s /tmp/scan_report.txt --flush-session -t /tmp/scan_trace.txt --fresh-queries > /tmp/scan_out.txt
````

*Note: double-check syntax before running as I had a conflict with some of these flags.  I believe the tool told me I couldn't use `-v 2` and `--eta` in the same command.*

ssh-keygen
------
Generates RSA/DSA keys:

`ssh-keygen -t rsa -b 2048`

Then, to copy it to your target's authorized_keys list:

`cat id_rsa.pub | ssh username@f.q.d.n 'cat >> ~/.ssh/authorized_keys'`

sslscan
--------
Typical use:

`sslscan --no-failed FULLY.QUALIFIED.DOMAIN.TLD`

sslyze
--------
Most of this is referenced from the [Quickstart](https://code.google.com/p/sslyze/wiki/QuickStart) hosted by Google.

`sslyze --sslv2 --sslv3 --tlsv1 --tlsv1_2 --tlsv1_1 --hide_rejected_ciphers f.q.d.n`

From the manual:

`python sslyze.py --regular www.target1.com`

This is what you'll want to use most of the time. It performs a regular HTTP scan. It's a shortcut for `--sslv2` `--sslv3` `--tlsv1` `--reneg` `--resum` `--certinfo=basic` `--hide_rejected_ciphers` `--http_get`.

Options:

*OpenSSL Cipher Suites*

`--sslv2 --sslv3 --tlsv1` : Lists the SSL 2.0, 3.0 and TLS 1.0 OpenSSL cipher suites supported by the server.

`--tlsv1_1 --tlsv1_2` : Lists the TLS 1.1 and 1.2 OpenSSL cipher suites supported by the server. Requires OpenSSL 1.0.1 or later.

`--http_get` : Option - For each cipher suite, sends an HTTP GET request after completing the SSL handshake and returns the HTTP status code.

`--hide_rejected_ciphers` : Option - Hides the (usually long) list of cipher suites that were rejected by the server.

*Session Renegotiation*

`--reneg` : Checks whether the server is vulnerable to insecure renegotiation. Requires OpenSSL 0.9.8m or later.

Session Resumption
`--resum` : Tests the server for session resumption support, using both session IDs and TLS session tickets (RFC 5077).

`--resum_rate` : Estimates the average rate of successful session resumptions by performing 100 session resumptions.

*Server Certificate*

`--certinfo=basic` : Verifies the server's certificate validity against Mozilla's trusted root store, and prints relevant fields of the certificate.

swaks
--------
Is an awesome cmd-line email client.  Install with `apt-get install swaks` and then you could use something like the command below to alert you any time a server boots:

```
swaks --to you@yourdomain.com --from "someemail@someplace.com" --server smtp.gmail.com:587 -tls --auth-user someemail@someplace.com --auth-password 'YOURPASSWORDGOESHERE' --header "Subject: SERVER X JUST BOOTED!" --body 'This is the body of the message dude!' --attach /tmp/somefile.txt
```
