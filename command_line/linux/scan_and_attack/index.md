# Scan and attack

bluto
--------
Bluto’s a neat tool that does DNS brute forcing, some Googling and other social-y/recon-y stuff.

To install:

    sudo pip install git+git://github.com/RandomStorm/Bluto

Then type bluto plus the domain name and you’re good to go!

dirb
--------
Dirb is my favorite tool for brute-crawling Web directories.  Here’s an example of dirb’ing a site and exporting the results to a text file:

    dirb https://somesite.com /usr/share/wordlists/dirb/big.txt -o somesite.txt


hashcat
--------
An awesome pw-cracking utility.  I like that you can run it against a whole folder full of .rule files, so if I just want to throw a basic "kitchen sink" of wordlists against a .txt doc, I'd do:

`hashcat -m 5500 -a 1 NTLM-hashes-2-be-cracked.txt /usr/share/hashcat/rules/*.rule`

This is a great rule set to get as well: [https://github.com/praetorian-inc/Hob0Rules](https://github.com/praetorian-inc/Hob0Rules).  

hydra
--------
Another great app for brute-forcing services.  Here's an example for brute'in RDP:

    hydra -t 4 -V -l administrator -P 500-worst-passwords.txt rdp://f.q.d.n

Here's another example for SSH:

    hydra -l root -P /your/password/list.txt 1.2.3.4 ssh

john (a.k.a. john the ripper)
--------
A fantastic tool for cracking passwords.  A fantastic reference for hashes and cracking is the [Pentest Monkey cheat sheet](http://pentestmonkey.net/cheat-sheet/john-the-ripper-hash-formats) but here's a few specific commands I've run to crack hashes:

    john --format=netntlm hashes-i-collected.txt --wordlist=/usr/share/seclists/Passwords/rockyou.txt

Check this great presentation on password cracking from [Derby Con 2015](http://www.irongeek.com/i.php?page=videos/derbycon5/fix-me18-my-password-cracking-brings-all-the-hashes-to-the-yard-larry-pesce)

mimikatz
-------
A great tool for gathering credential data from Windows systems.

A fantastic "unofficial" guide is here: http://adsecurity.org/?page_id=1821

Here's a mimikatz cheat sheet maintained on Github:
[https://github.com/mdsecresearch/Publications/blob/master/cheatsheets/RedRelease.pdf](https://github.com/mdsecresearch/Publications/blob/master/cheatsheets/RedRelease.pdf)

ncrack
--------
An app for brute-forcing credentials in RDP, SSH, etc.  An example of brute-forcing RDP:

    ncrack -v -u administrator -P /opt/SecLists/Passwords/rockyou.txt -p 3389 f.q.d.n

nikto
--------
A great app for scanning sites for vulns!

`nikto -h http://your.host.goes.here` - will give you a basic scan.

If you find your scan timing out a lot or crashing from errors, try to be a bit more gentle.  Take a look at Nikto's [options page](https://cirt.net/nikto2-docs/options.html).  There's a `nikto.conf` file (for me it was in `/etc/nikto.conf`) with a *Failures* option set to *20*.  I set it to 100.  Then I did this:

`nikto -h http://your.host.goes.here -Display -V -E -timeout 60`

This shows verbose output of all errors as you hit them, and also sets timeout to 60 seconds for errors (rather than default of 20 (I think)) to help troubleshoot your scan further.  

Another helpful tweak is the ``

nmap
--------
Port scanner + a zillion other things. Here's a great [cheat sheet](https://pentestlab.wordpress.com/2012/08/17/nmap-cheat-sheet/) to help you setup the most common kinds of scans.

### A few great quick references:
* [HighOnCoffee nmap cheat sheet (Highoncoffee)](https://highon.coffee/blog/nmap-cheat-sheet/)
* [NixCraft's Top 30 Nmap Command Examples For Sys/Network Admins (Cyberciti.biz)](https://www.cyberciti.biz/networking/nmap-command-examples-tutorials/)
* [Top 10 nmap Commands Every Sysadmin Should Know (Bencane.com)](http://bencane.com/2013/02/25/10-nmap-commands-every-sysadmin-should-know/)
* [NMAP cheat sheet (Hackertarget.com)](https://hackertarget.com/nmap-cheatsheet-a-quick-reference-guide/)
* [Information on timing and performance (nmap.org)](https://nmap.org/book/man-performance.html)
* [Using timing templates in nmap (cyberpedia.in)](http://cyberpedia.in/using-timing-templates-in-nmap/)

### Basic scans

#### Ping sweep

    nmap -sn 192.168.1.0/24

#### Find all active IPs in a network:

    nmap -sP 192.168.1.0/24; arp-scan --localnet  | grep "192.168.1.[0-9]* *ether"

*Source: [CommandLineKungFu](http://www.commandlinefu.com/commands/view/18230/find-all-active-ip-addresses-in-a-network)*

#### Find active IPs in a network AND export to a nice clean text file:

	nmap -n -sn -v 192.0.2.0/24 -oG - | awk '/Up$/{print $2}' > ips.txt

#### Thorough and quick TCP scan:

    nmap -p 1-65535 -sV -sS -T4 the.target.ip.address

#### Scan of all ports while ignoring ping, using a target list of *targets.txt* and exporting output to all 3 formats (called OUTPUT) and also using very verbose output

	nmap -p 1-65535 -sV -sS -T4 -Pn -iL targets.txt -oA OUTPUT -vv

#### Scanning some popular/common open ports
    nmap -PE -PM -PS 21,22,23,25,26,53,80,81,110,111,113,135,139,143,179,199,443,445,465,514,548,554,587,993,995

#### Scan the top 1000 ports - both TCP/UDP - and export to all 3 formats (called OUTPUT)

	nmap -vv -O -Pn -sTUV –top-ports 1000 -oN output the.target.ip.address

*Thanks [Daniel Miessler](https://danielmiessler.com/blog/nmap-use-the-top-ports-option-for-both-tcp-and-udp-simultaneously/#gs.kgigV7M)*

#### UDP scan

	nmap -p 1-65535 -sU the.target.ip.address


#### Scan through a proxy

    nmap 1.2.3.4 --proxy PROXYHOST:PORT

### Advanced scans

#### Find low hanging fruit w/nmap + searchsploit

	nmap -p- -sV -oX a.xml **ip**; searchsploit --nmap a.xml

*Source: [g0tmi1k](https://twitter.com/g0tmi1k/status/793844870481846272)*


### Scripting engine

`--script`

Calls the scripting engine to do one of katrillions of things.

#### http-method

`http-methods`
will show what http methods are available on a site such as track and trace.  Example:

    nmap -p 80,443 --script http-methods 1.2.3.4

#### ms-sql-info

This will poll the host for basic sql information:

    nmap f.q.d.n --script=ms-sql-info.nse

#### ssl-cert / ssl-enum-ciphers    

 This checks cert information, weak ciphers and SSLv2.

    nmap -p80,443 --script ssl-cert,ssl-enum-ciphers 1.2.3.4

### Other helpful nmap tools

* [Ndiff](https://nmap.org/ndiff/) "is a tool to aid in the comparison of Nmap scans."
* [Seccubus](https://www.seccubus.com/) "automates vulnerability scanning with: Nessus, OpenVAS, NMap, SSLyze, Medusa, SkipFish, OWASP ZAP and SSLlabs."

openssl
--------
Command line utility to test for various SSL configs and vulns.  A great resource I've found for this is [Explore Security's SSL manual cheatsheet](http://www.exploresecurity.com/wp-content/uploads/custom/SSL_manual_cheatsheet.html).

To test for RC4 ciphers (yep, I still have to do that quite a bit!):

`openssl s_client -cipher RC4 -connect site:port`

proxychains
--------
Proxychains is a handy way to leverage shells (such as via Meterpreter) to do other attacks/scans with tools that reside on the same box the shell lives on.

Here's pretty much the go-to article for configuration [https://www.offensive-security.com/metasploit-unleashed/proxytunnels/](https://www.offensive-security.com/metasploit-unleashed/proxytunnels/)

recon-ng
--------
Open source reconnaissance framework.

* Here's a nice tutorial + video on it: [https://strikersecurity.com/blog/getting-started-recon-ng-tutorial/](https://strikersecurity.com/blog/getting-started-recon-ng-tutorial/)

* And another: [https://www.youtube.com/watch?v=CyKkun8dZjE](https://www.youtube.com/watch?v=CyKkun8dZjE)

responder
--------
A network poisoner and fantastic for grabbing hashes for further cracking.  [Grab the tool](https://github.com/SpiderLabs/Responder) and then take careful look at the help (`responder.py -h`) to ensure you're launching with the right flags, as stuff can break.  I usually use:

    python /opt/Responder/Responder.py -I eth0 -Ffr

Then, once things are getting poisoned, it's easy to "watch" the logs directory for .txt files of hashes by doing:

`watch -n5 cat /opt/Responder/logs/*.txt`

Now, I'm not interested in system accounts with a dollar sign in them, so to see accounts *without* that character, you can do:

`grep -v '\$' /opt/Responder/logs/*.txt`

scanpbnj
--------
Scanpbnj is a great way to leverage nmap to make a scanning point in time snapshot.  Then you can run the same scanpbnj scan again and see the diffs that come out of the scan.  Get the tool info [here](https://www.aldeid.com/wiki/ScanPBNJ).  There's also a great help reference I use [here](http://spl0it.org/files/PBNJ-sysadmin-article-feb07.html).  

To install:

    sudo apt-get install pbnj

If you have problems running the tool after installing it, you might have to also install libperl shell with:

    apt-get install libshell-perl

Here's kind of my go-to command for using scanpbnj:

    scanpbnj -i targets.txt -a '-PE -PM -PS -sTU --top-ports 1000'

You could certainly add the `V` to `sTUV` to get versioning information but I'm not as concerned about that when I'm just trying to spot what ports/services change between scans.

scapy
--------
Here's a slick [cheat sheet](http://pen-testing.sans.org/blog/2016/04/05/scapy-cheat-sheet-from-sans-sec560) for using scapy.

sqlmap
--------
The sqlmap [project](https://github.com/sqlmapproject/sqlmap) is an "automatic SQL injection and database takeover tool."

### Usage
* Check out the [wiki](https://github.com/sqlmapproject/sqlmap/wiki/Usage) for the down n' dirty command line Kung Fu
* OWASP has a nice [automated audit using SQLmap](https://www.owasp.org/index.php/Automated_Audit_using_SQLMap) page with this handy general syntax:

````
python sqlmap.py -v 2 --url=http://mysite.com/index --user-agent=SQLMAP --delay=1 --timeout=15 --retries=2
--keep-alive --threads=5 --eta --batch --dbms=MySQL --os=Linux --level=5 --risk=4 --banner --is-dba --dbs --tables --technique=BEUST
-s /tmp/scan_report.txt --flush-session -t /tmp/scan_trace.txt --fresh-queries > /tmp/scan_out.txt
````

*Note: double-check syntax before running as I had a conflict with some of these flags.  I believe the tool told me I couldn't use `-v 2` and `--eta` in the same command.*

sslscan
--------
Typical use:

`sslscan --no-failed FULLY.QUALIFIED.DOMAIN.TLD`

To get an export XML do:

     sslscan --no-failed --xml=file.xml

sslyze
--------
Most of this is referenced from the [Quickstart](https://code.google.com/p/sslyze/wiki/QuickStart) hosted by Google.

    sslyze --sslv2 --sslv3 --tlsv1 --tlsv1_2 --tlsv1_1 --hide_rejected_ciphers f.q.d.n

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

*Session Resumption*

`--resum` : Tests the server for session resumption support, using both session IDs and TLS session tickets (RFC 5077).

`--resum_rate` : Estimates the average rate of successful session resumptions by performing 100 session resumptions.

*Server Certificate*

`--certinfo=basic` : Verifies the server's certificate validity against Mozilla's trusted root store, and prints relevant fields of the certificate.

*Output to XML*

`-xml=filename.xml` - so for example: `sslscan --regular -xml=output.xml SOME.FQDN.YOU-WANNA.SCAN`

testssl
--------
This is a great tool for conducting a series of TLS/SSL ciphers.

Go to [testssl.sh](https://testssl.sh) to grab the tool.  While you're there, grab [Aha](https://github.com/theZiz/aha) as that lets you pipe the output to an HTML file so you can preserve the output's colors - which is nice!  Here's an example for doing that:

First, make sure your "aha" gets compiled by doing this in the *aha* dir:

    make

Then, run your SSL test and pipe through *aha*:

`/opt/testssl/testssl.sh F.Q.D.N | /opt/aha/aha >OUTPUT.html`

To test a bunch of hosts, you could make a `targets.txt` with something like:

```
host1
host2
host3
```

Then scan 'em all at once with:

`/opt/testssl/testssl.sh --file targets.txt | /opt/aha/aha > OUTPUT.html`

WPScan
--------
[WPScan](https://wpscan.org/) is "a black box WordPress vulnerability scanner."  Here's a down n' dirty usage guide:

### Basic commands

`wpscan --update` - run this first!  It updates the database!

`wpscan --help` - gets help!

`wpscan --url www.somesite.com` - does the basic, "gentle" checks

`wpscan --url www.somesite.com -e ap,at,u,tt` - this is a *very* intrusive check and uses *all* the enumeration options in the next section!  Careful!  And you might want to use some of the flags in the *Extra helpful flags* section to make the scan a little less intense for your target.  For example, something like this might be more appropriate:

`wpscan --url https://www.somesite.com -e ap,at,u,tt --throttle 1000 --threads 1 --request-timeout 60 --connect-timeout 60`

### Brute forcing
`wpscan --url www.somesite.com --wordlist ~/rockyou.txt --username administrator` does a brute-force of the *administrator* username using the *rockyou.txt* word list

### Enumerate stuff
`wpscan --url www.somesite.com --enumerate` runs all enumeration tools

`-p` - enumerates plugins (**watch this setting carefully because you need to use `-ap` to enumerate *all* plugins!**)

`-t` enumerates installed themes (**watch this setting carefully because you need to use `-at` to enumerate *all* themes!**)

`-vt` enumerate vulnerable themes

`-u` enumerates users

`-tt` enumerates installed timthumbs

### Extra helpful flags

`--throttle <milliseconds>` - for example, I've been using `--throttle 1000` in order to be a bit less intense on my target site.  If this is used, you should also set `--threads 1`

`--request-timeout` and `--connect-timeout` help your scan recover smoothly from site errors/timeouts

`--random-agent` - scans with a random user agent string
