# How to install Lets Encrypt SSL cert on Unifi Controller
Check out the [how-to video](https://7ms.us/7ms-227-lets-encrypt-installing-ssl-certs-for-nessus-and-ubiquiti-unifi-2/) I made for more help, but basically my video *heavily* borrowed from this excellent one: [http://www.stevejenkins.com/blog/2016/06/use-existing-ssl-certificate-linux-unifi-controller/](http://www.stevejenkins.com/blog/2016/06/use-existing-ssl-certificate-linux-unifi-controller/).

Head to [https://certbot.eff.org](https://certbot.eff.org) and choose the proper platform.  In my case I chose *None of the Above* and *Ubuntu 14.04* in the menus at the top of the page.

Download **certbot**:

    wget https://dl.eff.org/certbot-auto
    chmod a+x certbot-auto
    
Generate a cert:

    ./path/to/certbot-auto certonly
    
Download Steve Jenkins' script [here](https://gist.github.com/stevejenkins/639ca3470b28e07b36bacb29efcec37f).  I just made the following modifications:


    # CONFIGURATION OPTIONS
    UNIFI_HOSTNAME=FQDN.OF.MY.SERVER
    #UNIFI_DIR=/opt/UniFi (I commented this line out because the one below applied to my server config):
    UNIFI_DIR=/usr/lib/unifi
    UNIFI_SERVICE_NAME=unifi (I think by default the spelling is "UniFi" but I put it as all lowercase since that is how it showed up in the service list)
    # FOR LET'S ENCRYPT SSL CERTIFICATES ONLY
    LE_MODE=yes

