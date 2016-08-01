#Logging and Alerting
Here's some stuff I figured out about logging/alerting systems and software

#Nagios
I went through an install of Nagios on Ubuntu 14 (heavily borrowed from [this Digital Ocean article](https://www.digitalocean.com/community/tutorials/how-to-install-nagios-4-and-monitor-your-servers-on-ubuntu-14-04)).  

First, install the prerequisites:

     sudo apt-get -y install apache2 mysql-server php5-mysql php5 libapache2-mod-php5 php5-mcrypt
     
Install other required packages:

     sudo apt-get install build-essential libgd2-xpm-dev openssl libssl-dev xinetd apache2-utils unzip
     
Get a nagios user/group setup:

    sudo useradd nagios
    sudo groupadd nagcmd
    sudo usermod -a -G nagcmd nagios

Download Nagios:

    wget https://assets.nagios.com/downloads/nagioscore/releases/nagios-4.1.1.tar.gz
    
Extract Nagios:

    tar xvf nagios-*.tar.gz
    
Install sendmail:

    ./configure --with-nagios-group=nagios --with-command-group=nagcmd 
    
Configure the install:

    ./configure --with-nagios-group=nagios --with-command-group=nagcmd --with-mail=/usr/sbin/sendmail
    
Compile Nagios:

    make all
    
Install extra Nagios stuff like scripts and config files:

    sudo make install
    sudo make install-commandmode
    sudo make install-init
    sudo make install-config
    sudo /usr/bin/install -c -m 644 sample-config/httpd.conf /etc/apache2/sites-available/nagios.conf
    
Download plugins

    cd ..
    wget http://www.nagios-plugins.org/download/nagios-plugins-2.1.1.tar.gz
    tar xvf nagios-plug*.tar.gz
    cd nagios-plugins-2.1.1/
    
Configure plugins:

    ./configure --with-nagios-user=nagios --with-nagios-group=nagios --with-openssl
    
Make and make/install:

    make
    sudo make install
    
Get NRPE:

Download latest from [Source Forge](http://downloads.sourceforge.net/project/nagios/nrpe-3.x/), then...

    tar xvf nrpe-*.tar.gz
    cd nrpe-*
    
Configure NRPE:

    ./configure --enable-command-args --with-nagios-user=nagios --with-nagios-group=nagios --with-ssl=/usr/bin/openssl --with-ssl-lib=/usr/lib/x86_64-linux-gnu
    
Build and install everything!!!!111(!!!!)!)!!!

    make all
    sudo make install
    sudo make install-xinetd
    sudo make install-daemon-config
    
