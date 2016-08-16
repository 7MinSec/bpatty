##iptables
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
