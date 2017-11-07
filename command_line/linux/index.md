Linux command line
==================

arpwatch
--------
*arpwatch* looks to be a cool way to partially satisfy [Critical Security Control #1](https://www.cisecurity.org/controls/) (Inventory of Authorized and Unauthorized Devices).  The idea is you use arpwatch to keep an eye on all MAC addresses in the environment, and get alerted when new devices pop up.  

I've not dug too much into it yet, but here's a great [how to guide](https://www.virtualizationhowto.com/2016/02/arpwatch-smtp-configuration/) that I found.

asciinema
--------
Creates ascii "movies" that record keystrokes and output (good for when you're doing a lot of command line work and want to have log of it later).
 
To install:
 
    curl -sL https://asciinema.org/install | sh
 
To begin a recording while eliminating any gaps in time over 1 second and saving the file to FILENAME:
 
    asciinema rec -w 1 -t "My title" NAME-OF-FILE
 
To play the file back:
 
    asciinema  -play FILENAME


bluto
--------
Bluto’s a neat tool that does DNS brute forcing, some Googling and other social-y/recon-y stuff.
 
To install:
 
    sudo pip install git+git://github.com/RandomStorm/Bluto
 
Then type bluto plus the domain name and you’re good to go!

cat
--------
A nice utility for concatenating and printing files.

### Use cases:

#### Get unique words out of a file

*This* command is nice if you've got a large file full of various text, numbers, etc. and you need an output of *just* unique words from it:

    cat comment_file.txt | tr " " "\n" | sort | uniq


#### Clear Linux terminal history

    cat /dev/null /home/brian/.bash_history

### Command line switches

#### -s
According to the man page, this will "squeeze multiple adjacent empty lines, causing the output to be single spaced."

So if you have a file called `spacey.txt` with something like:

    Line 1
    (empty space)
    (empty space)
    Line 2
    
If you run it through `cat -s spacey.txt` the output will be:

    Line 1
    (empty space)
    Line 2
    
curl
--------
A great util to slurp Web stuff off of Web sites

### To check if a site uses HSTS:

     curl -s -D- https://test.com | grep Strict

dirb
--------
Dirb is my favorite tool for brute-crawling Web directories.  Here’s an example of dirb’ing a site and exporting the results to a text file:
 
    dirb https://somesite.com /usr/share/wordlists/dirb/big.txt -o somesite.txt
    
du
--------
Commands to get various disk usage stats.  

One of my favorites is this command, which gives you a list of root folders and their sizes (helps find bloated folders)

    du -h --max-depth=1 / | sort -h

To find top 20 offenders in a directory:

    du -sh /opt | sort -hr | head -n 20
    
    du -sh /var | sort -hr | head -n 20 
    
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
[https://www.digitalocean.com/community/tutorials/how-to-use-gpg-to-encrypt-and-sign-messages-on-an-ubuntu-12-04-vps](https://www.digitalocean.com/community/tutorials/how-to-use-gpg-to-encrypt-and-sign-messages-on-an-ubuntu-12-04-vps)
