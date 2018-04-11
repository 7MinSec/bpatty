# Honeypots

OpenCanary
--------
[OpenCanary](https://github.com/thinkst/opencanary) is a "daemon that runs several canary versions of services that alerts when a service is (ab)used."  I talk more about OpenCanary in [this episode](https://7ms.us/7ms-238-network-monitoring-101-part-2-nmap-papertrailapp-and-opencanary/) of the 7 Minute Security podcast.

These are my quick n' dirty install steps for getting OpenCanary up and running:

### Basic install

	sudo apt-get install python-dev python-pip python-virtualenv
	virtualenv venv/
	. venv/bin/activate
	pip install opencanary

Now, use `opencanaryd` to generate a base config file:

    /root/venv/bin/opencanaryd --copyconfig

This should make an `.opencanary.conf` file in root's home folder.  

At this point you should be ready to launch `/root/venv/bin/opencanaryd start` but before you do that, you might want to install SMB per the section below.  If not, skip to "Config file tweaks" section.

### Install SMB
To install SMB service:

    apt-get install samba

Edit `/etc/samba/smb.conf` and I pretty much copied the sample from the readme but with a couple tweaks.  I did things like rename the server string, netbios name, and I also made a `/share` folder with some "juicy" files in it.  Here's my `smb.conf`:

	 [global]
	       workgroup = BCORP
	       server string = DC-01
	       netbios name = DC-01
	       dns proxy = no
	       log file = /var/log/samba/log.all
	       log level = 0
	       syslog only = yes
	       syslog = 0
	       vfs object = full_audit
	       full_audit:prefix = %U|%I|%i|%m|%S|%L|%R|%a|%T|%D
	       full_audit:success = pread
	       full_audit:failure = none
	       full_audit:facility = local7
	       full_audit:priority = notice
	       max log size = 100
	       panic action = /usr/share/samba/panic-action %d

	       #samba 4
	       server role = standalone server

	       #samba 3
	       #security = user

	       passdb backend = tdbsam
	       obey pam restrictions = yes
	       unix password sync = no
	       map to guest = bad user
	       usershare allow guests = yes
	    [myshare]
	       comment = Admin share
	       path = /share
	       guest ok = yes
	       read only = yes
	       browseable = yes
	       #vfs object = audit


### Config file tweaks
I had some problems with the basic `.opencanary.conf` file that gets created (it was something to do with `hpfeeds` and was a similar issue to [this](https://github.com/thinkst/opencanary/issues/12)).  

My modified `.opencanary.conf` file is below.  NOTE: It is configured for email alerts, but at the time of this writing (11/21/16) email alerts are *not* firing and I don't know why *but* I have a workaround posted further down this page.

	{
	    "device.node_id": "opencanary-1",
	    "ftp.banner": "FTP server ready",
	    "ftp.enabled": true,
	    "ftp.port":21,
	    "http.banner": "Apache/2.2.22 (Ubuntu)",
	    "http.enabled": true,
	    "http.port": 80,
	    "http.skin": "nasLogin",
	    "http.skin.list": [
	        {
	            "desc": "Plain HTML Login",
	            "name": "basicLogin"
	        },
	        {
	            "desc": "Synology NAS Login",
	            "name": "nasLogin"
	        }
	    ],
	    "httpproxy.port": 8080,
	    "httpproxy.skin": "squid",
	    "httproxy.skin.list": [
		{
		    "desc": "Squid",
		    "name": "squid"
		},
		{
		    "desc": "Microsoft ISA Server Web Proxy",
		    "name": "ms-isa"
		}
	    ],
	"logger": {
	    "class" : "PyLogger",
	    "kwargs" : {
	        "handlers": {
	            "SMTP": {
	                "class": "logging.handlers.SMTPHandler",
	                "mailhost": ["smtp.gmail.com", 587],
	                "fromaddr": "my-google-apps-account@somewhere.com",
	                "toaddrs" : ["who-i-want-to-receive-alerts@domain.com"],
	                "subject" : "OpenCanary Alert",
			"secure" : ["True"],
	                "credentials" : ["my-google-apps-account@somewhere.com", "THIS-IS-MY-PASSWORD!"]
	             }
	         }
	     }
	 },

	    "logger": {
		"class" : "PyLogger",
		"kwargs" : {
		    "formatters": {
			"plain": {
			    "format": "%(message)s"
			}
		    },
		    "handlers": {
			"console": {
			    "class": "logging.StreamHandler",
			    "stream": "ext://sys.stdout"
			},
			"file": {
			    "class": "logging.FileHandler",
			    "filename": "/var/tmp/opencanary.log"
			},
			"syslog-unix": {
			    "class": "logging.handlers.SysLogHandler",
			    "address": ["localhost", 514],
			    "socktype": "ext://socket.SOCK_DGRAM"
			},
			"json-tcp": {
			    "class": "opencanary.logger.SocketJSONHandler",
			    "host": "127.0.0.1",
			    "port": 1514
			}
			}
	}
	},
	    "portscan.synrate": "5",
	    "smb.auditfile": "/var/log/samba-audit.log",
	    "smb.configfile": "/briar/config/smb.conf",
	    "smb.domain": "corp.thinkst.com",
	    "smb.enabled": false,
	    "smb.filelist": [
	        {
	            "name": "2016-Tender-Summary.pdf",
	            "type": "PDF"
	        },
	        {
	            "name": "passwords.docx",
	            "type": "DOCX"
	        }
	    ],
	    "smb.mode": "workgroup",
	    "smb.netbiosname": "FILESERVER",
	    "smb.serverstring": "Windows 2003 File Server",
	    "smb.sharecomment": "Office documents",
	    "smb.sharename": "Documents",
	    "smb.sharepath": "/changeme",
	    "smb.workgroup": "OFFICE",
	    "mysql.banner": "5.5.43-0ubuntu0.14.04.1",
	    "mysql.port": 3306,
	    "mysql.enabled": true,
	    "ssh.enabled": true,
	    "ssh.port": 8022,
	    "ssh.version": "SSH-2.0-OpenSSH_5.1p1 Debian-4",
	    "rdp.enabled": false,
	    "sip.enabled": true,
	    "snmp.enabled": false,
	    "ntp.enabled": true,
	    "tftp.enabled": true,
	    "ntp.port": "123",
	    "telnet.port": "23",
	    "telnet.enabled": true,
	    "telnet.banner": "",
	    "telnet.honeycreds" : [
		{
		    "username" : "admin",
		    "password" : "password"

		},
		{
		    "username" : "admin",
		    "password" : "admin123"
		}
	    ],
	    "mssql.enabled": false,
	    "vnc.enabled": false
	}

### Configure email alerts
I mentioned above that although my .conf file is configured for email alerts, it's currently not working.  So here's my hacky way of getting it going:

#### Setup screen session for MSSQL/telnet/ssh/ntp alerts
First install `inotify-tools`:

    apt-get install inotify-tools

Then setup a `screen` to monitor these alerts in:

    screen -R watch1

Now inside that `screen` session, setup a script to monitor the `opencanary.log` file:

	#!/bin/sh
	while inotifywait -e modify /var/tmp/opencanary.log; do
	  /scripts/occhanges.sh
	done

(More on `occhanges.sh` in a bit)

Exit this screen session with `Ctrl+A, D`

#### Setup screen session for SMB alerts
Setup a `screen` session to monitor SMB alerts in:

    screen -R watch2

Now inside that `screen` session, setup a script to monitor the `/var/log/samba-audit.log` file:

	#!/bin/sh
	while inotifywait -e modify /var/log/samba-audit.log; do
	  /scripts/occhanges-smb.sh
	done

(More on `occhanges.sh` in a bit)

Exit this screen session with `Ctrl+A, D`

#### Implement swaks to send the actual email alerts
Install `swaks` if you don't have it:

    apt-get install swaks

Write a script to fire email alerts if the OpenCanary logs are changed.  Here are my scripts per the examples above:

##### /scripts/occhanges-smb.sh
	swaks --to me@domain.com --from "alerts@domain.com" --server smtp.gmail.com:587 -tls --auth-user alerts@mydomain.com --auth-password 'SOME-AWESOME-PASSWORD!' --header "Subject: [OC] SMB canary has left the coal mine!" --body 'SMB BREACH!  AHOOOOOGAH!  AHOOOOGAH!' --attach /tmp/smb.txt

##### /scripts/occhanges.sh
	swaks --to me@domain.com --from "alerts@domain.com" --server smtp.gmail.com:587 -tls --auth-user alerts@mydomain.com --auth-password 'SOME-AWESOME-PASSWORD!' --header "Subject: [OC] A canary has left the coal mine!" --body 'We've had some sort of FTP/SSH/SQL/etc. BREACH!  AHOOOOOGAH!  AHOOOOGAH!' --attach /tmp/oc.txt
