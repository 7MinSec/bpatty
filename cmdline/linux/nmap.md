# nmap
Port scanner + a zillion other things. Here's a great [cheat sheet](https://pentestlab.wordpress.com/2012/08/17/nmap-cheat-sheet/) to help you setup the most common kinds of scans.
      
## Basic scans

###Ping sweep

    nmap -sn 192.168.1.0/24
    
###Find all active IPs in a network:

    nmap -sP 192.168.1.0/24; arp-scan --localnet  | grep "192.168.1.[0-9]* *ether"

*Source: [CommandLineKungFu](http://www.commandlinefu.com/commands/view/18230/find-all-active-ip-addresses-in-a-network)*

###Thorough scan 
    -PE -PM -PS 21,22,23,25,26,53,80,81,110,111,113,135,139,143,179,199,443,445,465,514,548,554,587,993,995
    
###Scan through a proxy

    nmap 1.2.3.4 --proxy PROXYHOST:PORT
    
##Advanced scans

###Find low hanging fruit w/nmap + searchsploit

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