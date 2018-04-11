# Caldera
This is a quick getting started guide using a Ubuntu 16.04 server.  

## Server setup

Run this stuff:

`apt-get update && apt-get upgrade`

`sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5`

`echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.6 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.6.list`

`sudo apt-get update`

`sudo apt-get install -y mongodb-org`

`apt-get install -y python3-dev`

`apt-get install -y python3-pip`

`pip3 install --upgrade setuptools`

`git clone https://github.com/mitre/caldera.git /opt/caldera`

`cd /opt/caldera/caldera`

`pip3 install -r requirements.txt`

Open up `/etc/mongod.conf`

Find the place that says *#replication* and uncomment the line and add the following so it looks like this:

```
replication:  
  replSetName: caldera
```

Go [here](https://github.com/mitre/caldera-crater/releases) and download *CraterMainWin7.exe* or *CraterMainWin8up.exe* and save it to `/opt/caldera/dep/crater/crater/CraterMain.exe` (note the path and spelling of the .exe - it's gotta be exact!)  

`sudo service mongod start`

`cd /opt/caldera/caldera`

`python3 caldera.py`

## Client Configuration
Go to the [Caldera agent](https://github.com/mitre/caldera-agent/releases) download site and save  and put it in `c:\program files (x86\cagent)` along with https://my-caldera-server:8888/conf.yml

Open `conf.yml` you might want to change the machine name to a FQDN or IP.

Now run:

`cagent.exe --startup auto install`

`cagent.exe start`
