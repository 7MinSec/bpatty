## asciinema
Creates ascii "movies" that record keystrokes and output (good for when you're doing a lot of command line work and want to have log of it later).
 
To install:
 
    curl -sL https://asciinema.org/install | sh
 
To begin a recording while eliminating any gaps in time over 1 second and saving the file to FILENAME:
 
    asciinema rec -w 1 -t "My title" NAME-OF-FILE
 
To play the file back:
 
    asciinema  -play FILENAME
 
 
## bluto
Bluto’s a neat tool that does DNS brute forcing, some Googling and other social-y/recon-y stuff.
 
To install:
 
    sudo pip install git+git://github.com/RandomStorm/Bluto
 
Then type bluto plus the domain name and you’re good to go!


##cat
A nice utility for concatenating and printing files.

*This* command is nice if you've got a large file full of various text, numbers, etc. and you need an output of *just* unique words from it:

    cat comment_file.txt | tr " " "\n" | sort | uniq

##curl
A great util to slurp Web stuff off of Web sites

###To check if a site uses HSTS:

     curl -s -D- https://uhc-support-stg.uhg.com | grep Strict

 
##dirb
Dirb is my favorite tool for brute-crawling Web directories.  Here’s an example of dirb’ing a site and exporting the results to a text file:
 
    dirb https://somesite.com /usr/share/wordlists/dirb/big.txt -o somesite.txt
     

##du
Commands to get various disk usage stats.  

One of my favorites is this command, which gives you a list of root folders and their sizes (helps find bloated folders)

    du -h --max-depth=1 / | sort -h

##egresscheck-framework
This is a nice tool for checking what ports are open between two network segments.  So lets say you have PC1 on 192.168.0.10 and PC2 on a different subnet at 192.168.1.222..0

* First [get the framework](https://github.com/stufus/egresscheck-framework).
* On PC1, run `python ecf.py`
* Set your source IP by typing `set SOURCEIP 192.168.0.10`
* Then set your target IP by typing `set TARGETIP 192.168.1.222`
* Set your port range (I like testing everything) by typing `set ports 1-65535`
* Test both TCP and UDP by typing `set PROTOCOL all`
* Type `get` and hit Enter to confirm your selections on PC1.
* Now type `generate tcpdump` - you will be given a command to run on the target machine starting with `tcpdump -n -U -w /tmp/egress...` - run that command on the target machine now.
* Back at the source machine, type `generate python-cmd` to generate a Python one-liner to run on the source machine to pass traffic to the target.  
* Type `exit` to leave the tool, then run the Python one-liner.
* When the Python one-liner completes, go to your target machine and *Ctrl+C* the tcpdump job.
* Then, run the two *tshark* commands (generated when you ran *generate tcpdump* in order to parse the TCP/UDP ports open between the two hosts.  For example, my commands were:


    tshark -r 03-18-16.pcap -Tfields -eip.proto -eip.src -etcp.dstport tcp | sort -u #For received TCP

    tshark -r 03-18-16.pcap -Tfields -eip.proto -eip.src -eudp.dstport udp | sort -u #For received UDP

##grep
A tool for finding words/lines matching a pattern. Some handy examples below:

Searching a file for an *exact* match:

    grep -w "some exact string you want to find" name-of-file-you-are-searching

Searching the current dir and all sub-dirs for something, like 

    grep word-you-are-searching-for -r *
 
##gpg

Generates PGP keypairs.
 
Check out this guide: http://linux.koolsolutions.com/2009/03/17/gpgpgp-keys-part-1-generating-gpgpgp-keys-on-debian-linux/
 
Follow the steps to create the key.  Then list the keys using:
 
    gpg --list-keys
     
In the output you'll see a line like this:
 
**pub 2048R/1234569 2015-12-29**
 
The 1234569 identifies your unique key.  Keep this in mind.
 
To backup your keys, reference http://linux.koolsolutions.com/2009/04/01/gpgpgp-part-5-backing-up-restoring-revoking-and-deleting-your-gpgpgp-keys-in-debian/
 
This command will backup your public key:

    gpg -ao mypub.key --export 1234569
 
This will backup your private key:
 
    gpg -ao myprivate.key --export-secret-keys 1234569
 
Another great resource for creating keys, signing messages, etc. is:
https://www.digitalocean.com/community/tutorials/how-to-use-gpg-to-encrypt-and-sign-messages-on-an-ubuntu-12-04-vps
 
##hashcat
An awesome pw-cracking utility.  I like that you can run it against a whole folder full of .rule files, so if I just want to throw a basic "kitchen sink" of wordlists against a .txt doc, I'd do:

    hashcat -m 5500 -a 1 NTLM-hashes-2-be-cracked.txt /usr/share/hashcat/rules/*.rule

This is a great rule set to get as well: [https://github.com/praetorian-inc/Hob0Rules](https://github.com/praetorian-inc/Hob0Rules).  
 
## hydra
Another great app for brute-forcing services.  Here's an example for brute'in RDP:

    hydra -t 4 -V -l administrator -P 500-worst-passwords.txt rdp://f.q.d.n

Here's another example for SSH:

    hydra -l root -P /your/password/list.txt 1.2.3.4 ssh


##iptables
Here are some commands I find useful when working with my Digital ocean droplets:

List all rules

    sudo iptables -L

List rules by number

    sudo iptables -L --line-numbers

To then delete a rule by number:

    sudo iptables -D INPUT 3 (for rule 3)

Flush existing rules
    sudo iptables -F

Allow all concurrent connections
    
    sudo iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

Allow ANY host to access a port, such as SSH:
    
    sudo iptables -A INPUT -p tcp --dport 22 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT

Allow specific IPs/hosts to access port 80

    sudo iptables -A INPUT -p tcp -s F.Q.D.N --dport 80 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT

Allow specific IPs/hosts to access port 22

    sudo iptables -A INPUT -p tcp -s F.Q.D.N --dport 22 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT

Block all other traffic:

    sudo iptables -P INPUT DROP

Provide the VPS loopback access:

    sudo iptables -I INPUT 1 -i lo -j ACCEPT

Install iptables-persistent to ensure rules survive a reboot:

    sudo apt-get install iptables-persistent

Start iptables-persistent service

    sudo service iptables-persistent start

If you make iptables changes after this and they don't seem to stick, do this:

    sudo iptables-save > /etc/iptables/rules.v4

Save a copy of iptables rules for later

sudo iptables-save > name-of-file.txt

See [this Digital Ocean article](https://www.digitalocean.com/community/tutorials/how-to-set-up-a-firewall-using-iptables-on-ubuntu-12-04) for more information.

## john (a.k.a. john the ripper)
A fantastic tool for cracking passwords.  A fantastic reference for hashes and cracking is the [Pentest Monkey cheat sheet](http://pentestmonkey.net/cheat-sheet/john-the-ripper-hash-formats) but here's a few specific commands I've run to crack hashes:

    john --format=netntlm hashes-i-collected.txt --wordlist=/usr/share/seclists/Passwords/rockyou.txt

Check this great presentation on password cracking from [Derby Con 2015](http://www.irongeek.com/i.php?page=videos/derbycon5/fix-me18-my-password-cracking-brings-all-the-hashes-to-the-yard-larry-pesce)
 
## mimikatz
A great tool for gathering credential data from Windows systems.
 
A fantastic "unofficial" guide is here: http://adsecurity.org/?page_id=1821
 
Here's a mimikatz cheat sheet maintained on Github:
https://github.com/mdsecresearch/Publications/blob/master/cheatsheets/RedRelease.pdf
 
## ncrack
An app for brute-forcing credentials in RDP, SSH, etc.  An example of brute-forcing RDP:

    ncrack -v -u administrator -P /opt/SecLists/Passwords/rockyou.txt -p 3389 f.q.d.n

## netcat
Here's a great [cheat sheet](https://www.sans.org/security-resources/sec560/netcat_cheat_sheet_v1.pdf) from SANS.
 
## nmap
Port scanner + a zillion other things. Here's a great [cheat sheet](https://pentestlab.wordpress.com/2012/08/17/nmap-cheat-sheet/) to help you setup the most common kinds of scans.
 
To scan multiple targets from a text file called targets.txt:

    nmap -p 80,443 -iL targets.txt
     
 Here's one of my fav scanning configs for a thorough scan:
 
    -PE -PM -PS 21,22,23,25,26,53,80,81,110,111,113,135,139,143,179,199,443,445,465,514,548,554,587,993,995
 
`--script`

Calls the scripting engine to do one of katrillions of things.
 
`http-methods`
will show what http methods are available on a site such as track and trace.  Example:

    nmap -p 80,443 --script http-methods 1.2.3.4
 
This checks cert information, weak ciphers and SSLv2.

    nmap -p80,443 --script ssl-cert,ssl-enum-ciphers 1.2.3.4
 
## openssl

Command line utility to test for various SSL configs and vulns.  A great resource I've found for this is [Explore Security's SSL manual cheatsheet](http://www.exploresecurity.com/wp-content/uploads/custom/SSL_manual_cheatsheet.html).

To test for RC4 ciphers (yep, I still have to do that quite a bit!):

    openssl s_client -cipher RC4 -connect site:port

##Responder

A network poisoner and fantastic for grabbing hashes for further cracking.  [Grab the tool](https://github.com/SpiderLabs/Responder) and then take careful look at the help (`responder.py -h`) to ensure you're launching with the right flags, as stuff can break.  I usually use:

    python /opt/Responder/Responder.py -I eth0 -Ffr

Then, once things are getting poisoned, it's easy to "watch" the logs directory for .txt files of hashes by doing:

    watch -n5 cat /opt/Responder/logs/*.txt

Now, I'm not interested in system accounts with a dollar sign in them, so to see accounts *without* that character, you can do:

    grep -v '\$' /opt/Responder/logs/*.txt

##scapy
Here's a slick [cheat sheet](http://pen-testing.sans.org/blog/2016/04/05/scapy-cheat-sheet-from-sans-sec560) for using scapy.

##testssl
This is a great tool for conducting a series of TLS/SSL ciphers.

Go to [testssl.sh](https://testssl.sh) to grab the tool.  While you're there, grab [Aha](https://github.com/theZiz/aha) as that lets you pipe the output to an HTML file so you can preserve the output's colors - which is nice!  Here's an example for doing that:

First, make sure your "aha" gets compiled by doing this in the *aha* dir:

    make

Then, run your SSL test and pipe through *aha*:

    /opt/testssl/testssl.sh F.Q.D.N | /opt/aha/aha >OUTPUT.html

## tcpdump
Here's one of my favorite resources for command line fun w/this tool: [http://www.rationallyparanoid.com/articles/tcpdump.html](http://www.rationallyparanoid.com/articles/tcpdump.html).

To capture traffic where a certain destination IP is communicated with:
 
    tcpdump -n dst your.target.ip.address

To capture just certain traffic, such as all NTP related traffic, the format is like this:

    sudo tcpdump -i eth0 'port 123' -vv

To capture traffic between one host, such as the localhost, and an entire network (helpful during an nmap scan):

    sudo tcpdump src host 192.168.0.5 and dst net 192.168.0.0/24
 
## recon-ng
Open source reconnaissance framework.
 
Here's a good primer video about it: [https://www.youtube.com/watch?v=CyKkun8dZjE](https://www.youtube.com/watch?v=CyKkun8dZjE)

##scanpbnj
Scanpbnj is a great way to leverage nmap to make a scanning point in time snapshot.  Then you can run the same scanpbnj scan again and see the diffs that come out of the scan.  Get the tool info [here](https://www.aldeid.com/wiki/ScanPBNJ).  There's also a great help reference I use [here](http://spl0it.org/files/PBNJ-sysadmin-article-feb07.html).  

To install:

    sudo apt-get install pbnj

If you have problems running the tool after installing it, you might have to also install libperl shell with:

    apt-get install libshell-perl

Here's kind of my go-to command for using scanpbnj:

    scanpbnj -i targets.txt -a '-PE -PM -PS -sTU --top-ports 1000'

You could certainly add the `V` to `sTUV` to get versioning information but I'm not as concerned about that when I'm just trying to spot what ports/services change between scans.

## SimpleHTTPServer
Starts up a HTTP server on port 8000 in whatever directory you run the command from:
 
    python -m SimpleHTTPServer

If the server you've got a shell on won't allow outbound connections to ports like *8000* you can specify a different outbound port with:

    python -m SimpleHTTPServer 80
 
## ssh-keygen
Generates RSA/DSA keys:
 
    ssh-keygen -t rsa -b 2048
 
Then, to copy it to your target's authorized_keys list:
 
    cat id_rsa.pub | ssh username@f.q.d.n 'cat >> ~/.ssh/authorized_keys'
 
##SSL checks - general

[http://www.exploresecurity.com/wp-content/uploads/custom/SSL_manual_cheatsheet.html](http://www.exploresecurity.com/wp-content/uploads/custom/SSL_manual_cheatsheet.html)

###sslscan
Typical use:

    sslscan --no-failed FULLY.QUALIFIED.DOMAIN.TLD

###sslyze
https://code.google.com/p/sslyze/wiki/QuickStart

    sslyze --sslv2 --slv3 --tlsv1 --tlsv1_2 --tlsv1_1 --hide_rejected_ciphers f.q.d.n
 
From the manual:

    python sslyze.py --regular www.target1.com

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
 
##swaks
Is an awesome cmd-line email client.

    swaks --to you@yourdomain.com --from "someemail@someplace.com" --server smtp.gmail.com:587 -tls --auth-user someemail@someplace.com --auth-password 'YOURPASSWORDGOESHERE' --header "Subject: Some subject" --body 'This is the body of the message dude!'

##wget
A non-interactive file-getter from the Interwebs.  Example:

    wget http://1.2.3.4/file.name

Helpful flags:

`--no-check-certificate` - ignores SSL certificates

##zip
I always forget how to zip up a whole folder while password-protecting it, but this'll do it!

    zip -er name-of-your.zip name-of-dir-to-be-zipped
     
To break it down, this zips and encrypts a .zip file of folder named **name-of-dir-to-be-zipped**

* `-e` enables encryption for your zip file. This is what makes it ask for the password.

* `-r` makes the command recursive, meaning that all the files inside the folder will be added to the zip file.

* `name-of-your.zip` is the name of the output file.

* `name-of-dir-to-be-zipped` is the folder you want to zip.