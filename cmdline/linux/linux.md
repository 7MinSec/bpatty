#Linux command line tools

* [asciinema](asciinema.md)
* [bluto](bluto.md)
* [cat](cat.md)
* [curl](curl.md)
* [dirb](dirb.md)
* [du](du.md)
* [egress-check](egress-check.md)
* [grep](grep.md)
* [gpg](gpg.md)
* [hashcat](hashcat.md)
* [hydra](hydra.md) 
* [iptables](iptables.md)
* [john (the ripper)](johntheripper.md)

##Still organizing everything below into its own pages...pardon the dust
 
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