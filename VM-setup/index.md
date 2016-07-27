#Virtual Machines
This section is about initial setup of virtual machines and VM software. 
 
 * [Kali basic config](#kali)
 * [VMWare Fusion notes](#vmwarefusion)
 
##Kali basic config
<a id="kali"></a> 
###Initial install/setup
 
1. Download/install from Kali.org.
 
2. Review the top 10 post install tips (https://www.offensive-security.com/kali-linux/top-10-post-install-tips/).
 
3. Setup a folder on your Windows machine to easily share files with your Kali VM (see
http://www.howtogeek.com/189974/how-to-share-your-computers-files-with-a-virtual-machine/)
 
4. Ensure that your /etc/apt/sources.list file matches that of the [Kali rolling configuration](https://www.kali.org/news/kali-linux-rolling-edition-2016-1/) so that updates and dist upgrades are sucked down appropriately.  This is *necessary* after April 15, 2016!

5. Do an apt-get update && apt-get dist-upgrade to get updated packages such as NMAP7.

###Additional addons
Consider installing these optional add-ons (source: The Hacker Playbook 2), which can be easily copied/pasted/run using the commands below:
 
**Backdoor factory** - patch PE, ELF, Mach-O binaries with shellcode

    git clone https://github.com/secretsquirrel/the-backdoor-factory.git /opt/the-backdoor-factory
    cd /opt/the-backdoor-factory
    ./install.sh

**HTTPScreenShot**

    pip install selenium
    git clone https://github.com/breenmachine/httpscreenshot.git /opt/httpsscreenshot
    cd /opt/httpscreenshot
    chmod +x install-dependencies.sh && ./install-dependencies.sh
 
*The above commands are for 64-bit VMs.  If you have 32-bit machines, do:*

`wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.8-linux-i686.tar.bz2`

`bzip2 -d phantomjs-1.9.8-linux-i686.tar.bz2`

`tar xvf phantomjs-1.9.8-linux-i686.tar`

`cp phantomjs-1.9.8-linux-i686 /bin/phantomjs /usr/bin/`
 
* **SMBExec** - Rapid psexec style attack with samba tools

`git clone https://github.com/pentestgeek/smbexec.git /opt/smbexec`

`cd /opt/smbexec && ./install.sh`

  * Select 1
  * Select 4
  * After compilation, select 5

Done.

* **Masscan** - fastest Internet port scanner in 'da world!

`apt-get install git gcc make libpcap-dev`

`git clone https://github.com/robertdavidgraham/masscan.git /opt/masscan`

`cd /opt/masscan`

`make`

`make install`
 
* **Gitrob** - recon for GitHub organizations

`git clone https://github.com/michenriksen/gitrob.git /opt/gitrob`

`gem install bundler`

`service postgresql start`

`su postgres`

`createuser -s gitrob --pwprompt
createdb -O gitrob gitrob`

`exit`

`cd /opt/gitrob/bin`

`gem install gitrob`
 
* **CMSmap** - Python open source CMS scanner that automates process of detecting security flaws.

`git clone https://github.com/Dionach/CMSmap /opt/CMSmap`
 
* **Wpscan** - scans Wordpress blogs.

`git clone https://github.com/wpscanteam/wpscan.git /opt/wpscan`

`cd /opt/wpscan && ./wpscan.rb --update`
 
* **Eyewitness** - takes screenshots of stuff.

`git clone https://github.com/ChrisTruncer/EyeWitness.git /opt/EyeWitness`
 
* **Printer exploit finder**

`git clone https://github.com/MooseDojo/praedasploit /opt/praedasploit`
 
* **SQLmap** - SQL injection tool.

`git clone https://github.com/sqlmapproject/sqlmap /opt/sqlmap`
 
* **Recon-ng!**
`git clone https://bitbucket.org/LaNMaSteR53/recon-ng.git /opt/recon-ng`
 
* **Discover** - automates various pentesting tasks.

`git clone https://github.com/leebaird/discover.git /opt/discover`

`cd /opt/discover && ./setup.sh`
 
* **Beef** - browser-hooking fun.

`git clone https://github.com/beefproject/beef /opt/beef`
 
`cd /opt`

`wget https://raw.github.com/beefproject/beef/a6a7536e/install-beef`

`chmod +x install-beef`

`./install-beef`
 
* **Responder** - listens for LLMNR, NBT-NS and MDNS.

`git clone https://github.com/SpiderLabs/Responder.git /opt/Responder`
 
* **Custom scripts from The Hacker Playbook 2**:
`git clone https://github.com/cheetz/Easy-P.git /opt/Easy-P`

`git clone https://github.com/cheetz/Password_Plus_One /opt/Password_Plus_One`

`git clone https://github.com/cheetz/PowerShell_Popup /opt/PowerShell_Popup`

`git clone https://github.com/cheetz/icmpshock /opt/icmpshock`

`git clone https://github.com/cheetz/brutescrape /opt/brutescrape`

`git clone https://www.github.com/cheetz/reddit_xss /opt/reddit_xss`
 
* **Forked versions of Powersploit and Powertools**

`git clone https://github.com/cheetz/PowerSploit /opt/HP_PowerSploit`

`git clone https://github.com/cheetz/PowerTools /opt/HP_PowerTools`

`git clone https://github.com/cheetz/nishang /opt/nishang`

`wget http://ptscripts.googlecode.com/svn/trunk/dshashes.py -O /opt/NTDSXtract/dshashes.py`
 
* **DSHashes** - extracts user hashes in a format for NTDSXtract

`wget http://ptscripts.googlecode.com/svn/trunk/dshashes.py -O /opt/NTDSXtract /dshashes.py`
 
* **Sparta** (already in Kali 2)

`git clone https://github.com/secforce/sparta.git /opt/sparta`

`apt-get install python-elixir`

`apt-get install ldap-utils rwho rsh-client X11-apps finger`
 
* **NoSQLMap** - automated testing for MongoDB database servers and Webapps

`git clone https://github.com/tcstool/NoSQLMap.git /opt/NoSQLMap`
 
* **Spiderfoot** - open source footprinting tool
`mkdir /opt/spiderfoot/ && cd /opt/spiderfoot`

`wget http://sourceforge.net/projects/spiderfoot/files/spiderfoot-XXX-src.tar.gz/download`

`tar xzvf download`

`pip install lxml`

`pip install netaddr`

`pip install M2Crypto`

`pip install cherrypy`

`pip insatll mako`
 
* **WCE** - Windows credential editor
Go to [http://www.ampliasecurity.com/research/windows-credential/editor](http://www.ampliasecurity.com/research/windows-credential/editor)

Save and extract to /opt.
 
* **Mimikatz**  - used for pulling cleartext passwords from memory, Golden Ticket, skeleton key and more.

Grab from https://github.com/gentilkiwi/mimikatz/releases/latest and extract to /opt.
 
* **SET** - Social Engineering Toolkit

`git clone https://github.com/trustedsec/social-engineer-toolkit/ /opt/set/`

`cd /opt/set && ./setup.py install`
 
* **Powersploit** - PowerShell scripts for post-exploitation

`git clone https://github.com/mattifestation/PowerSploit.git /opt/PowerSploit`

`cd /opt/PowerSploit && wget https://raw.githubusercontent.com/obscuresec/random/master/StartListener.py && wget https://raw.githubusercontent.com/darkoperator/powershell_scripts/master/ps_encoder.py`
 
* **Nishang** - PS scripts for exploits and post-exploits

`git clone https://github.com/samratashok/nishang /opt/nishang`
 
* **Veil** - red team toolkit focused on evading detection.  Contains Veil-Evasion for generating AV-evading payloads, Veil-Catapult for delivering them to targets, Veil-Catapult for delivering them to targets, and Veil-PowerView for gaining situational awareness on Windows domains.  Veil will be used to create a Python-based Meterpreter .exe.

`git clone https://github.com/Veil-Framework/Veil /opt/Veil
cd /opt/Veil && ./Install.sh -c`
 
* **OWASP-ZAP**  - like Burp.  Included in Kali by default, but if you need it...

`https://code.google.com/p/zaproxy/wiki/Downloads?tm=2`
 
* **Fuzz lists** - scripts to use with Burp to fuzz parameters

`git clone https://github.com/danielmiessler/SecLists.git /opt/SecLists`
 
* **Password lists**
  * **Rock You**
[http://downloads.skullsecurity.org/passwords/rockyou.txt.bz2](http://downloads.skullsecurity.org/passwords/rockyou.txt.bz2) 
  * **Crackstation-human-only** - human passwords leaked from vacious databases.

[https://crackstation.net/buy-crackstation-wordlist-password-cracking-dictionary.htm](https://crackstation.net/buy-crackstation-wordlist-password-cracking-dictionary.htm) 

  * **M3g9tron Passwords Wordlist**
(site appears to be undergoing a renovation.  Visit [https://web.archive.org/web/20150316185559/https://xato.net/passwords/ten-million-passwords/#.VngbE1TyvIU](https://web.archive.org/web/20150316185559/https://xato.net/passwords/ten-million-passwords/#.VngbE1TyvIU) for a cached version.
 
Read this for more info about the password list: [http://blog.thireus.com/cracking-story-how-i-cracked-over-122-million-sha1-and-md5--hashed passwords](http://blog.thireus.com/cracking-story-how-i-cracked-over-122-million-sha1-and-md5--hashed passwords) 

 * **Net-Creds** - to parse PCAP files

`git clone https://github.com/DanMcInerney/net-creds.git /opt/net-creds`

Consider installing these extra Firefox addons (optional):
 
**Web dev tools:**
[https://addons.mozilla.org/en-US/firefox/addon/web-developer
](https://addons.mozilla.org/en-US/firefox/addon/web-developer) 

**Tamper-data** (which offers some Burp-like functionality in the browser)
[https://addons.mozilla.org/en-US/firefox/addon/tamper-data](https://addons.mozilla.org/en-US/firefox/addon/tamper-data) 

**Foxy-proxy**: a proxy you can easily switch on/off for use w/Burp.  Should already be installed in Kali image:
 
[https://addons.mozilla.org/en-US/firefox/addon/foxyproxy-standard](https://addons.mozilla.org/en-US/firefox/addon/foxyproxy-standard) 

**User agent switcher** - allows you to impersonate other browsers:[https://addons.mozilla.org/en-US/firefox/addon/user-agent-switcher](https://addons.mozilla.org/en-US/firefox/addon/user-agent-switcher)
 
**ReloadEvery** - keeps tabs "alive" by refreshing them after a certain amount of time. [https://addons.mozilla.org/en-US/firefox/addon/reloadevery/](https://addons.mozilla.org/en-US/firefox/addon/reloadevery/)

**Wappalyzer** - identifies technologies in use on a given site
https://addons.mozilla.org/en-US/firefox/addon/wappalyzer/

#VMWare Fusion notes
<a id="vmwarefusion"></a> 
##Change DHCP scope for vmnet1/vmnet8
See [this article](https://kb.vmware.com/selfservice/microsites/search.do?language=en_US&cmd=displayKC&externalId=1026510) but essentially you want to edit the `/Library/Preferences/VMware\ Fusion/networking` file to reflect the new DHCP range.  Specifically, edit this line (sometimes I have issues unless I shut down fusion completely):

    answer VNET_8_HOSTONLY_SUBNET 192.168.227.0
 
 
