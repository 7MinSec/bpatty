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

##Sample basic configuration
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
    
##Configuration for a Unifi hosted controller:
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