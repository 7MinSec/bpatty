#Hugo
Here's how I installed Hugo on a Digital Ocean Ubuntu droplet:

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
    
