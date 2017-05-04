# nmap
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

    nmap -sn 192.168.1.0/24
    
### Find all active IPs in a network:

    nmap -sP 192.168.1.0/24; arp-scan --localnet  | grep "192.168.1.[0-9]* *ether"

*Source: [CommandLineKungFu](http://www.commandlinefu.com/commands/view/18230/find-all-active-ip-addresses-in-a-network)*

### Thorough and quick TCP scan:

    nmap -p 1-65535 -sV -sS -T4 the.target.ip.address
    
### Scan of all ports while ignoring ping, using a target list of *targets.txt* and exporting output to all 3 formats (called OUTPUT) and also using very verbose output

	nmap -p 1-65535 -sV -sS -T4 -Pn -iL targets.txt -oA OUTPUT -vv
    
### Scanning some popular/common open ports
    nmap -PE -PM -PS 21,22,23,25,26,53,80,81,110,111,113,135,139,143,179,199,443,445,465,514,548,554,587,993,995
    
### Scan the top 1000 ports - both TCP/UDP - and export to all 3 formats (called OUTPUT)

	nmap -vv -O -Pn -sTUV –top-ports 1000 -oA output the.target.ip.address

*Thanks [Daniel Miessler](https://danielmiessler.com/blog/nmap-use-the-top-ports-option-for-both-tcp-and-udp-simultaneously/#gs.kgigV7M)*

### UDP scan

	nmap -p 1-65535 -sU the.target.ip.address
    
### Scan through a proxy

    nmap 1.2.3.4 --proxy PROXYHOST:PORT
    
## Advanced scans

### Find low hanging fruit w/nmap + searchsploit

	nmap -p- -sV -oX a.xml **ip**; searchsploit --nmap a.xml

*Source: [g0tmi1k](https://twitter.com/g0tmi1k/status/793844870481846272)*


## Scripting engine

`--script`

Calls the scripting engine to do one of katrillions of things.
 
### http-method 
 
`http-methods`
will show what http methods are available on a site such as track and trace.  Example:

    nmap -p 80,443 --script http-methods 1.2.3.4
 
### ms-sql-info

This will poll the host for basic sql information:

    nmap f.q.d.n --script=ms-sql-info.nse 
    
### ssl-cert / ssl-enum-ciphers    
    
 This checks cert information, weak ciphers and SSLv2.

    nmap -p80,443 --script ssl-cert,ssl-enum-ciphers 1.2.3.4