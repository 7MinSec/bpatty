# Network

arpwatch
--------
*arpwatch* looks to be a cool way to partially satisfy [Critical Security Control #1](https://www.cisecurity.org/controls/) (Inventory of Authorized and Unauthorized Devices).  The idea is you use arpwatch to keep an eye on all MAC addresses in the environment, and get alerted when new devices pop up.  

I've not dug too much into it yet, but here's a great [how to guide](https://www.virtualizationhowto.com/2016/02/arpwatch-smtp-configuration/) that I found.

curl
--------
A great util to slurp Web stuff off of Web sites

### To check if a site uses HSTS:

`curl -s -D- https://test.com | grep Strict`

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

`tshark -r 03-18-16.pcap -Tfields -eip.proto -eip.src -etcp.dstport tcp | sort -u #For received TCP`

`tshark -r 03-18-16.pcap -Tfields -eip.proto -eip.src -eudp.dstport udp | sort -u #For received UDP`

iptables
--------
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

### Sample basic configuration
If I spin up a new Digital Ocean droplet, my starter config might be like the following, which locks down http/ssh access to only me while I test stuff out:

    sudo apt-get install iptables-persistent
    sudo service iptables-persistent start
    sudo iptables -F
    sudo iptables -A INPUT -i lo -j ACCEPT
    sudo iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
    sudo iptables -A INPUT -s my.public.ip.address -p tcp -m tcp --dport 22 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
    sudo iptables -A INPUT -s my.public.ip.address -p tcp -m tcp --dport 80 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
    sudo iptables -P INPUT DROP
    sudo iptables-save > /etc/iptables/rules.v4

Then when I want to give "everybody" access to the Web site, I'll do this:

    sudo iptables -L --line-numbers

Then for the HTTP rule, I yank it out with:

    sudo iptables -D INPUT 3 (for rule 3)

Then I let "anybody" access HTTP with:

    sudo iptables -A INPUT -p tcp --dport 80 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT

### Configuration for a Unifi hosted controller:
This config opens the necessary ports so that *just* your IP address (identified by *my.public.ip.address*), as well as the servers for the Uptime Robot service, has access to the necessary ports:

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


netcat
--------
Here's a great [cheat sheet](https://www.sans.org/security-resources/sec560/netcat_cheat_sheet_v1.pdf) from SANS.

SimpleHTTPServer
--------
Starts up a HTTP server on port 8000 in whatever directory you run the command from:

`python -m SimpleHTTPServer`

If the server you've got a shell on won't allow outbound connections to ports like *8000* you can specify a different outbound port with:

`python -m SimpleHTTPServer 80`

tcpdump
--------
Here's one of my favorite resources for command line fun w/this tool: [http://www.rationallyparanoid.com/articles/tcpdump.html](http://www.rationallyparanoid.com/articles/tcpdump.html).

### To capture a dump to a file:

     tcpdump -v -w capture.cap

### To capture traffic where a certain destination IP is communicated with:

    tcpdump -n dst your.target.ip.address -v

### To capture just certain traffic, such as all NTP related traffic, the format is like this:

    sudo tcpdump -i eth0 'port 123' -vv

### To capture traffic between one host, such as the localhost, and an entire network (helpful during an nmap scan):

    sudo tcpdump src host 192.168.0.5 and dst net 192.168.0.0/24

### To capture traffic to a host with verbosity and also write it to a .cap file:

	sudo tcpdump -n dst the.destination.ip.address -v -w somefile.cap

### To capture traffic from one host while excluding one or more ports:

````
tcpdump src 172.16.46.25 and port not 22 and port not 8834
````

tshark
--------
[tshark](https://www.wireshark.org/docs/man-pages/tshark.html) is a great utility for dumping and analyzing network traffic.

The [Billy Madison](https://www.vulnhub.com/entry/billy-madison-11,161/) VulnHub challenge will have you analyze a pcap full of email correspondence.  In reading through user [walkthroughs](http://www.mrb3n.com/?p=342) I saw a clever use of tshark to break apart the individual emails easily.  The syntax is:

	for stream in `tshark -r capture.cap -T fields -e tcp.stream | sort -n | uniq`
	do
	    echo $stream
	    tshark -r capture.cap -w stream-$stream.cap -Y "tcp.stream==$stream"
	done

wget
--------
A non-interactive file-getter from the Interwebs.  Example:

`wget http://1.2.3.4/file.name`

Helpful flags:

`--no-check-certificate` - ignores SSL certificates
