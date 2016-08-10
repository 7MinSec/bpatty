#EdgeRouterX
A collection of tidbits for managing EdgeRouterX.  I did a full write-up on some of these things [here](https://7ms.us/7ms-217-installing-ubiquiti-edgerouter-x-and-ap-part-2/).

##Xbox NAT setup
First setup a static IP for your Xbox, then use the commands below (thank you [this post](https://community.ubnt.com/t5/EdgeMAX/Xbox-1-Strict-NAT-problem/td-p/1371769/page/2) for the solution!!!) The one important prerequisite is to set your Xbox up with a static IP address - in the example below I used 192.168.7.77.

    configure
    set service upnp2 listen-on switch0.7
    set service upnp2 nat-pmp enable
    set service upnp2 secure-mode enable
    set service upnp2 wan eth1
    set service upnp2 acl rule 10 action deny
    set service upnp2 acl rule 10 description "Block default Xbox Live port 3074"
    set service upnp2 acl rule 10 external-port 3074
    set service upnp2 acl rule 10 local-port 0-65535
    set service upnp2 acl rule 10 subnet 192.168.7.0/24
    set service upnp2 acl rule 20 action allow
    set service upnp2 acl rule 20 description "Allow XBOX-1"
    set service upnp2 acl rule 20 external-port 1024-65535
    set service upnp2 acl rule 20 local-port 0-65535
    set service upnp2 acl rule 20 subnet 192.168.7.77/32

##Creating isolated guest networks
Follow [this KB article](https://help.ubnt.com/hc/en-us/articles/218889067-EdgeMAX-How-to-Protect-a-Guest-Network-on-EdgeRouter) to setup segmented VLANs.

##Setup a cloud-hosted UniFi controller
I created an audio/video walkthrough [here](https://7ms.us/7ms-220-installing-ubiquiti-edgerouter-x-and-ap-part-3/) on this topic, but one of the most important things (to me) is to lock down your cloud access controller once it's setup.  For that I use the following iptables rules:

    sudo apt-get install iptables-persistent
    sudo service iptables-persistent start
    sudo iptables -F
    sudo iptables -A INPUT -i lo -j ACCEPT
    sudo iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
    sudo iptables -A INPUT -s my.public.ip.address -p tcp -m tcp --dport 22 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
    sudo iptables -A INPUT -s my.public.ip.address -p tcp -m tcp --dport 8081 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
    sudo iptables -A INPUT -s my.public.ip.address -p tcp -m tcp --dport 8080 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
    sudo iptables -A INPUT -s my.public.ip.address -p tcp -m tcp --dport 8443 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
    sudo iptables -A INPUT -s my.public.ip.address -p tcp -m tcp --dport 8880 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
    sudo iptables -A INPUT -s my.public.ip.address -p tcp -m tcp --dport 8843 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
    sudo iptables -A INPUT -s my.public.ip.address -p tcp -m tcp --dport 27117 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
    sudo iptables -A INPUT -s my.public.ip.address -p tcp -m tcp --dport 80 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
    sudo iptables -P INPUT DROP
    sudo iptables-save > /etc/iptables/rules.v4
    
Then, let your AP get "adopted" by the cloud access controller following [this article](https://community.ubnt.com/t5/UniFi-Routing-Switching/USG-cloud-controller/td-p/1156708).  The key command to issue is:

    set-inform http://ip.address-of.my-cloud.controller:8080/inform

