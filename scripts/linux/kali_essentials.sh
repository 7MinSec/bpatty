#Kali Essentials
#This script does some `git-clone`ing to pull down tools I always carry with me on my Kali boxes:
##################
##################
#Aha helps take output from testssl.sh and make it nice and HTML-y
sudo git clone https://github.com/theZiz/aha.git /opt/aha

#Awesome-nmap-grep makes it easy to grep nmap exports for just the data you need!
sudo git clone https://github.com/leonjza/awesome-nmap-grep.git /opt/awesome-nmap-grep

#bettercap is a nice mitm framework - I did an episode on it here: https://7ms.us/7ms-228-fun-with-bettercap/
# Update 9/18: I found it easier to install bettercap from https://github.com/bettercap/bettercap/releases but if you
# still want to do it via GitHub you can just do:
# git clone https://github.com/bettercap/bettercap.git /opt/bettercap

#b374k is a nice PHP shell.  Quick ref to compile a shell: php -f index.php -- -o myShell.php -p myPassword -s -b -z gzcompress -c 9
sudo git clone https://github.com/b374k/b374k.git /opt/b374k

#bpatty is...well...bpatty!
sudo git clone https://github.com/braimee/bpatty.git /opt/bpatty

#Bloodhound is awesome (https://stealingthe.network/quick-guide-to-installing-bloodhound-in-kali-rolling)
sudo apt-get install bloodhound -y

#brutescrape scrapes Web sites for verbiage in order to create a wordlist
sudo git clone https://github.com/cheetz/brutescrape.git /opt/brutescrape

#chuckle is might handy when it comes to SMB relay exploitation
sudo git clone https://github.com/nccgroup/chuckle.git /opt/chuckle
sudo wget https://github.com/CoreSecurity/impacket/blob/impacket_0_9_15/examples/smbrelayx.py /opt/chuckle/

#Commix is a command-injection tool that I've never gotten to run successfully in any live pentests, but the examples sure look neat ;-)
sudo git clone https://github.com/stasinopoulos/commix.git /opt/commix

#CrackMapExec is "A swiss army knife for pentesting networks" - https://www.youtube.com/watch?time_continue=10&v=Dd4ZAm2mwwA
sudo apt-get install crackmapexec -y

#Deathstar is a tool for automating domain admin (see https://gist.github.com/braimee/e3e462b634715ae06121c82d49c274e9)
sudo git clone https://github.com/byt3bl33d3r/DeathStar.git /opt/deathstar

#eaphammer does "Targeted evil twin attacks against WPA2-Enterprise networks. Indirect wireless pivots using hostile portal attacks."
sudo git clone https://github.com/s0lst1c3/eaphammer.git /opt/eaphammer

#egress framework helps you test network segmentation easily with a few python commands
git clone https://github.com/stufus/egresscheck-framework.git /opt/egress

#empire is "a PowerShell and Python post-exploitation agent"
sudo git clone https://github.com/adaptivethreat/Empire.git /opt/empire

#eyewitness is a nice recon tool for putting some great visualization behind nmap scans
sudo git clone https://github.com/FortyNorthSecurity/EyeWitness.git /opt/eyewitness

#findsploit finds exploits in local and online databases
sudo git clone https://github.com/1N3/Findsploit.git /opt/findsploit

#foospidy is a BIG BUNCH O' PAYLOADS for fuzzing and fun!
sudo git clone https://github.com/foospidy/payloads.git /opt/foospidy

#hashcombiner takes cracked hashes from a pot file and ties them back to their pwned user
sudo git clone https://github.com/hackern0v1c3/hash_combiner /opt/hashcombiner

#hatecrack helps you crack hashes
sudo git clone https://github.com/trustedsec/hate_crack.git /opt/hatecrack

#honeydoc creates docs/spreadsheets with fake names and social security numbers
sudo git clone https://github.com/jqreator/honeydoc /opt/honeydoc

#impacket is "a collection of Python classes for working with network protocols"
#I currently primarily use it for ntlmrelayx.py
sudo git clone https://github.com/CoreSecurity/impacket.git /opt/impacket

#impacket2 is just impacket but dirkjan's fork of it.  See https://dirkjanm.io/worst-of-both-worlds-ntlm-relaying-and-kerberos-delegation/
sudo git clone https://github.com/dirkjanm/impacket.git /opt/impacket2

#krbrelayx is helpful for the CVE-2019-1040 attack (https://dirkjanm.io/exploiting-CVE-2019-1040-relay-vulnerabilities-for-rce-and-domain-admin/)
sudo git clone https://github.com/dirkjanm/krbrelayx.git /opt/krbrelayx

#mailsniper is a great enumeration/pilfering tool to run against Exchange environments
sudo git clone https://github.com/dafthack/MailSniper.git /opt/mailsniper

#mitm6 is a way to tinker with ip6 and get around some ip4-level protections
sudo git clone https://github.com/fox-it/mitm6.git /opt/mitm6

#mitmf is a mitm framework that I've not tried out yet
sudo git clone https://github.com/byt3bl33d3r/MITMf.git /opt/mitmf

#nmap-bootstrap-xsl turns nmap scan output into pretty HTML
sudo git clone https://github.com/honze-net/nmap-bootstrap-xsl.git /opt/nmap-bootstrap-xsl

#netcreds "Sniffs sensitive data from interface or pcap"
sudo git clone https://github.com/DanMcInerney/net-creds /opt/netcreds

#PCCredz parses pcaps for sensitive data
sudo git clone https://github.com/lgandx/PCredz /opt/pcredz

#Powersploit is "a collection of Microsoft PowerShell modules that can be used to aid penetration testers during all phases of an assessment"
sudo git clone https://github.com/PowerShellMafia/PowerSploit.git /opt/powersploit

#PowerupSQL is a tool for discovering, enumerating and potentially pwning SQL servers!
sudo git clone https://github.com/NetSPI/PowerUpSQL.git /opt/powerupsql

#Printer Exploit Toolkit finds printer exploits!
sudo git clone https://github.com/RUB-NDS/PRET.git /opt/pret

#recon-ng is a great tool for reconning all the things
sudo git clone https://bitbucket.org/LaNMaSteR53/recon-ng.git /opt/recon-ng

#responder is awesome for LLMNR, NBT-NS and MDNS poisoning
sudo git clone https://github.com/lgandx/Responder.git /opt/responder

#seclists is a "collection of multiple types of lists used during security assessments"
sudo git clone https://github.com/danielmiessler/SecLists.git /opt/seclists

#SilentTrinity is "An asynchronous, collaborative post-exploitation agent powered by Python and .NET's DLR"
sudo git clone https://github.com/byt3bl33d3r/SILENTTRINITY.git /opt/silenttrinity

#sniper is a great automated recon scanner
sudo git clone https://github.com/1N3/Sn1per.git /opt/sniper

#spiderfoot is a cool Webapp scanner that I'll often run to get a 2nd opinion from Burp/AppSpider
sudo git clone https://github.com/smicallef/spiderfoot.git /opt/spiderfoot

#sslyze is a good tool for running ssl/tls checks
sudo git clone https://github.com/nabla-c0d3/sslyze.git /opt/sslyze

#testssl is a great script for checking variou ssl/tls vulns
sudo git clone https://github.com/drwetter/testssl.sh.git /opt/testssl

#veil generates payloads that can bypass AV
sudo git clone https://github.com/Veil-Framework/Veil-Evasion /opt/veil-evasion

#wifite is an easy way to audit wireless networks
sudo git clone https://github.com/derv82/wifite2.git /opt/wifite
