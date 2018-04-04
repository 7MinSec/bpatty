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

## Al-khaser
Public malware techniques used in the wild: Virtual Machine, Emulation, Debuggers, Sandbox detection.

https://github.com/LordNoteworthy/al-khaser

## Free training from SecureIdeas
https://blog.secureideas.com/2018/01/professionally-evil-web-app-pen-testing-101-course.html

## Windows privesc guide:
http://www.sploitspren.com/2018-01-26-Windows-Privilege-Escalation-Guide/

## IDA Pro is free!
https://www.hex-rays.com/products/ida/support/download_freeware.shtml

## Fix keyring issue with Kali
wget -q -O - https://archive.kali.org/archive-key.asc  | apt-key add

## Add this to environment check .ps1
https://adsecurity.org/?p=3700

MISC STUFF
https://posts.specterops.io/introducing-the-adversary-resilience-methodology-part-one-e38e06ffd604
https://twitter.com/hacks4pancakes/status/967223000096559111?s=12
https://twitter.com/vysecurity/status/967217863995076609?s=12
https://www.troyhunt.com/ive-just-launched-pwned-passwords-version-2/
https://twitter.com/lennyzeltser/status/967424069040852993?s=12
https://twitter.com/jacksonvd/status/967770718640336896?s=12

Bloodhound:
https://github.com/BloodHoundAD/BloodHound/wiki/Getting-started

https://blog.cptjesus.com/posts/newbloodhoundingestor

https://www.scip.ch/en/?labs.20171102



I have covered this extensively across presentations and ADSecurity blog posts. Here are a few:
https://adsecurity.org/wp-content/uploads/2016/08/DEFCON24-2016-Metcalf-BeyondTheMCSE-RedTeamingActiveDirectory.pdf …
https://adsecurity.org/?p=3719
https://adsecurity.org/?p=3658


https://t.co/ZKAHCuNton?ssr=true

https://t.co/vN6saTX8Zt?ssr=true

http://www.hackingarticles.in/understanding-guide-mimikatz/

ATTACK Navigator
https://www.mitre.org/capabilities/cybersecurity/overview/cybersecurity-blog/the-attck%E2%84%A2-navigator-a-new-open-source


https://pen-testing.sans.org/blog/2017/08/21/pen-test-poster-white-board-powershell-find-juicy-stuff-in-file-system?utm_medium=Social&utm_source=Twitter&utm_content=SANSPenTest+BLOG+White+Board+PowerShell+Find+Juicy+Stuff&utm_campaign=SANS+Pen+Test


BlueHat IL 2017: Marina Simakov & Tal Be'ery, Microsoft - YouTube
https://www.youtube.com/watch?v=HE7X7l-k-A4

Deeper WEF (WEFFLES) explanations:
https://t.co/fKkfwPzq8f?ssr=true

AD security is awesome:
https://twitter.com/pyrotek3/status/971762070961127424?s=12

Tron script to declutter/clean a machine:
https://www.reddit.com/r/TronScript/

Top 5 ways I got DA before lunch:
https://medium.com/@adam.toscher/top-five-ways-i-got-domain-admin-on-your-internal-network-before-lunch-2018-edition-82259ab73aaa

Lazy recon:
https://github.com/nahamsec/lazyrecon

Get domain admin from the outside:
https://markitzeroday.com/pass-the-hash/crack-map-exec/2018/03/04/da-from-outside-the-domain.html

Dump stuff:
https://blog.stealthbits.com/extracting-password-hashes-from-the-ntds-dit-file/
(There's another article for this I think)
