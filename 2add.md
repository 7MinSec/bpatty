# To add
This is simply a big fat sloppy list of things I want to work into BPATTY eventually:

## Good crackin' tool

https://github.com/fireeye/gocrack

## Burp BApps that are recommended:

Swagger Parser, Wsdler, python scripter, json decoder, paramalyzer, ... (Lanmaster53)

retire.js, software vuln scanner, WAF detect, headers analyzer for some good starters (Sunny)

## Protecting DA creds
This is an interesting write-up on how to protect DA creds.
https://blogs.technet.microsoft.com/askpfeplat/2017/10/31/protecting-domain-administrative-credentials/

## BTOAB
https://www.n00py.io/2017/10/detecting-crackmapexec-cme-with-bro-sysmon-and-powershell-logs/

## Good Web app pentest thing
https://blog.zsec.uk/ltr101-method-to-madness/

## Nessus rules location

/opt/nessus/etc/nessus/nessusd.rules

## How to use git
https://github.com/oliviaguest/git-and-github-cheat-sheet

## Downdetector
http://downdetector.com/

## Fixing black screen stuff on Kali
https://msitpros.com/?p=3209

## CME primer
http://threat.tevora.com/quick-tip-skip-cracking-responder-hashes-and-replay-them/

## Cred defense toolkit
https://www.youtube.com/watch?v=4u5gCoCu88Q

## Honey accounts
https://jordanpotti.com/2017/11/06/honey-accounts/

## KRACK explained simply
https://www.youtube.com/watch?v=-biQTSUk0Lc

## See who's RDP'ing in?
query user /server: localhost

## Windows 10 controlled folders
https://www.bleepingcomputer.com/news/microsoft/windows-10s-controlled-folder-access-anti-ransomware-feature-is-now-live/

## Using GPO to manage local administrator
Here are some neat ideas on managing the local admins group via GPO. We have some of his setup in our environment and I’ve used similar concepts at a handful of clients. https://blogs.technet.microsoft.com/askpfeplat/2017/11/06/use-group-policy-preferences-to-manage-the-local-administrator-group/

## Subdomain finder
https://blog.appsecco.com/a-penetration-testers-guide-to-sub-domain-enumeration-7d842d5570f6?gi=d8c02f8bb063

## Ping with an audible bell when a machine comes back up:

ping -a ip

# Burp stuff
Create a folder called BurpProjectFiles

Create a new one on disk.  Under the BurpProjectFiles dir.  Make a new project in there called NonAdmin_Juice_Shop.burp.  

Take the defaults.

Setup options:

**Proxy**
Intercept is off.  Go to options, go to Intercept Server responses and check "Intercept server responses - YES".  Also "unhide hidden form fields."  

**Spider**
Options tab - spider engine...put number of threads to 5.

**Scanner**
In Options, check "URL path folders" and "URL path name".  Click "url to body" and "body to url" to see if posts can be sent as GETs.

Turn down number of threads to 5.  

Under Active Scanning optimization: THOROUGH>

In active scanning area, click SELECT ALL!

*Left off on section 3 - Hybrid Spidering Your Web App*

### Misc: fix NTLM in Burp:
https://support.portswigger.net/customer/portal/questions/11516769-ntlm-authentication

## Fix broken shared folders?
https://docs.kali.org/general-use/install-vmware-tools-kali-guest

## Security onion
`sudo sostat` - gives detailed information on service status

`sudo sostat-quick` guided tour of sostat output

`sudo sostat-redacted` gives REDACTED information to share with our mailing list

`/etc/nsm/rules/downloaded.rules` - rules downloaded by Pulledpork

`/etc/nsm/pulledpork` - local rules

`sudo so-allow` starts prompt for unblocking ports and stuff from firewall

## Collab stuff
This helped: https://www.slideshare.net/centralohioissa/jon-gorenflo-burp-collaborator

This helped: https://portswigger.net/burp/help/collaborator_deploying#dns

Open all the ports on Lightsail...then get a static IP...authentication

sudo apt-get install openjdk-8-jre

sudo java -Xms10m -Xmx200m -XX:GCTimeRatio=19 -jar burp.jar --collaborator-server

# Password policy - check on domain
Issue `net accounts` commands

## Fing
Put in stuff about VLAN support as well as the external network test?

## Sublister
https://tools.kali.org/information-gathering/sublist3r

## The case for NOT changing pw expiration?
https://er.educause.edu/blogs/2017/10/time-for-password-expiration-to-die

## Flushing DNS cache on Mac:
https://help.dreamhost.com/hc/en-us/articles/214981288-Flushing-your-DNS-cache-in-Mac-OS-X-and-Linux

## Sweet NSE scripts
https://twitter.com/bonsaiviking/status/950772687655309313?ref_src=twcamp%5Eshare%7Ctwsrc%5Eios%7Ctwgr%5Ecom.google.inbox.ShareExtension
