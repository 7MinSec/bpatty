# Install a hosted UniFi controller
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

#Sections to add:

##Install a LetsEncrypt SSL certificate
