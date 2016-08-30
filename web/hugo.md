#Hugo

## Basic install on Digital Ocean w/Ubuntu 16.04

Pulled down install package:

    wget https://github.com/spf13/hugo/releases/download/v0.16/hugo_0.16-1_amd64.deb
    
Installed with:

    dpkg -i hugo_0.16-1_amd64.deb
    
Change to the dir I want to install Hugo on:

    cd /var/www
    
Make a new Hugo site there:

    hugo new site .
    
Create a test post:

    hugo new post/hithere.md
    
Installed a sample theme:

    git clone https://github.com/fredrikloch/hugo-uno.git themes/uno

Edit `config.toml` to change a few basics:

    baseurl = "http://replace-this-with-your-hugo-site.com/"
    languageCode = "en-us"
    title = "My New Hugo Site"
    theme = "uno"
    
Started the server on port 80:

    sudo hugo server --bind=0.0.0.0 --baseUrl=http://the.public-ip.or.FQDN --port=80
    
---

#Under construction:
The data following is under construction...
    
    
## Setup multiple Hugo instances on single DO droplet on Ubuntu 16.04
[This article](https://www.digitalocean.com/community/tutorials/how-to-set-up-apache-virtual-hosts-on-ubuntu-16-04) is a big help, but basic steps are:

Install Apache:

    sudo apt-get install apache2
    
Create a config file for site #1:

    sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/site1.conf 

Open site1.conf and insert a config similar to:

    <VirtualHost *:80>
    ServerAdmin webmaster@localhost
    ServerName domain.com
	 ServerAlias www.domain.com
    DocumentRoot /var/www/html/site1
    <Directory /var/www/site1/public>
    allow from all
    Options Indexes FollowSymLinks
    AllowOverride None
    Require all granted
    </Directory>
    </VirtualHost>

Create second, third, fourth, etc. site in a similar manner by making an appropriate .conf file with correct `DocumentRoot` and other settings.

Use `a2ensite` to enable each site:

    sudo a2ensite site1.conf
    sudo a2ensite site2.conf

Disable the default site:

    sudo a2dissite 000-default.conf
    
Restart Apache to make these changes stick:

    service apache2 reload

    
    
    
    
    hugo --theme=geo --buildDrafts
    
    
