#EdgeRouterX
A collection of tidbits for managing EdgeRouterX.  I did a full write-up on some of these things [here](https://7ms.us/7ms-217-installing-ubiquiti-edgerouter-x-and-ap-part-2/).

##Xbox NAT setup
First setup a static IP for your Xbox, then use the commands below (thank you [this post](https://community.ubnt.com/t5/EdgeMAX/Xbox-1-Strict-NAT-problem/td-p/1371769/page/2) for the solution!!!  The one important prerequisite is to set your Xbox up with a static IP address - in the example below I used 192.168.7.77.

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
