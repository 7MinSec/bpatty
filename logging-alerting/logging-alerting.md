#Logging and Alerting
Here's some stuff I figured out about logging/alerting systems and software

##Graylog
Heavily borrowed from [this article](http://docs.graylog.org/en/2.0/pages/installation/os/ubuntu.html) and also [this one](http://www.itzgeek.com/how-tos/linux/ubuntu-how-tos/how-to-install-graylog-on-ubuntu-16-04.html).

###Install prerequisites:

    apt-get install apt-transport-https openjdk-8-jre-headless uuid-runtime pwgen

###Install Mongodb:

    apt-get install mongodb-server

###Install Elastisearch stuff:

    wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
    echo "deb https://packages.elastic.co/elasticsearch/2.x/debian stable main" | sudo tee -a /etc/apt/sources.list.d/elasticsearch-2.x.list
    sudo apt-get update && sudo apt-get install elasticsearch
    
###Edit Elastisearch config file:

    pico /etc/elasticsearch/elasticsearch.yml
    
 Uncomment the *cluster.name* and set to *graylog*
 
###Start Elastisearch:

    sudo /bin/systemctl daemon-reload
    sudo /bin/systemctl enable elasticsearch.service
    sudo /bin/systemctl restart elasticsearch.service

###Install Graylog:

    wget https://packages.graylog2.org/repo/packages/graylog-2.0-repository_latest.deb
    sudo dpkg -i graylog-2.0-repository_latest.deb
    sudo apt-get update && sudo apt-get install graylog-server

###Edit server.conf
    pico /etc/graylog/server/server.conf
    
Fill in `password_secret_` (with `pwgen -N 1 -s 96`) and `root_password_sha2` fields (with `echo -n yourpassword | sha256sum`) for sure.  Also, set:

    is_master = true
    elasticsearch_shards = 1
    root_email = "your@email.address"
    root_timezone = UTC
    rest_listen_uri = http://your.local.ip.address:12900/
    web_listen_uri = http://your.local.ip.address:9000/

###Enable Graylog during system startup

    sudo systemctl daemon-reload
    sudo systemctl enable graylog-server.service
    sudo systemctl start graylog-server.service
    
