# tcpdump
Here's one of my favorite resources for command line fun w/this tool: [http://www.rationallyparanoid.com/articles/tcpdump.html](http://www.rationallyparanoid.com/articles/tcpdump.html).

To capture traffic where a certain destination IP is communicated with:
 
    tcpdump -n dst your.target.ip.address

To capture just certain traffic, such as all NTP related traffic, the format is like this:

    sudo tcpdump -i eth0 'port 123' -vv

To capture traffic between one host, such as the localhost, and an entire network (helpful during an nmap scan):

    sudo tcpdump src host 192.168.0.5 and dst net 192.168.0.0/24
