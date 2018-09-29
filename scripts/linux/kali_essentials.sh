#Kali Essentials
#This script does some `git-clone`ing to pull down tools I always carry with me on my Kali boxes:
##################
##################
#Aha helps take output from testssl.sh and make it nice and HTML-y
git clone https://github.com/theZiz/aha.git /opt/aha

#bettercap is a nice mitm framework - I did an episode on it here: https://7ms.us/7ms-228-fun-with-bettercap/
git clone https://github.com/evilsocket/bettercap.git /opt/bettercap

#b374k is a nice PHP shell.  Quick ref to compile a shell: php -f index.php -- -o myShell.php -p myPassword -s -b -z gzcompress -c 9
git clone https://github.com/b374k/b374k.git /opt/b374k

#chuckle is might handy when it comes to SMB relay exploitation
git clone https://github.com/nccgroup/chuckle.git /opt/chuckle
wget https://github.com/CoreSecurity/impacket/blob/impacket_0_9_15/examples/smbrelayx.py /opt/chuckle/

#Commix is a command-injection tool that I've never gotten to run successfully in any live pentests, but the examples sure look neat ;-)
git clone https://github.com/stasinopoulos/commix.git /opt/commix

#CrackMapExec is "A swiss army knife for pentesting networks" - https://www.youtube.com/watch?time_continue=10&v=Dd4ZAm2mwwA
apt-get install crackmapexec

#egress framework helps you test network segmentation easily with a few python commands
git clone https://github.com/stufus/egresscheck-framework.git /opt/egress

#empire is "a PowerShell and Python post-exploitation agent"
git clone https://github.com/adaptivethreat/Empire.git /opt/empire

#eyewitness is a nice recon tool for putting some great visualization behind nmap scans
git clone https://github.com/FortyNorthSecurity/EyeWitness.git /opt/eyewitness

#findsploit finds exploits in local and online databases
git clone https://github.com/1N3/Findsploit.git /opt/findsploit

#foospidy is a BIG BUNCH O' PAYLOADS for fuzzing and fun!
git clone https://github.com/foospidy/payloads.git /opt/foospidy

#hatecrack helps you crack hashes
git clone https://github.com/trustedsec/hate_crack.git /opt/hatecrack

#impacket is "a collection of Python classes for working with network protocols"
#I currently primarily use it for ntlmrelayx.py
git clone https://github.com/CoreSecurity/impacket.git /opt/impacket

#mailsniper is a great enumeration/pilfering tool to run against Exchange environments
git clone https://github.com/dafthack/MailSniper.git /opt/mailsniper

#mitmf is a mitm framework that I've not tried out yet
git clone https://github.com/byt3bl33d3r/MITMf.git /opt/mitmf

#PCCredz parses pcaps for sensitive data
git clone https://github.com/lgandx/PCredz /opt/pcredz

#Powersploit is "a collection of Microsoft PowerShell modules that can be used to aid penetration testers during all phases of an assessment"
git clone https://github.com/PowerShellMafia/PowerSploit.git /opt/powersploit

#PowerupSQL is a tool for discovering, enumerating and potentially pwning SQL servers!
git clone https://github.com/NetSPI/PowerUpSQL.git /opt/powerupsql

#Printer Exploit Toolkit finds printer exploits!
git clone https://github.com/RUB-NDS/PRET.git /opt/pret

#recon-ng is a great tool for reconning all the things
git clone https://bitbucket.org/LaNMaSteR53/recon-ng.git /opt/recon-ng

#responder is awesome for LLMNR, NBT-NS and MDNS poisoning
git clone https://github.com/lgandx/Responder.git /opt/responder

#seclists is a "collection of multiple types of lists used during security assessments"
git clone https://github.com/danielmiessler/SecLists.git /opt/seclists

#sniper is a great automated recon scanner
git clone https://github.com/1N3/Sn1per.git /opt/sniper

#spiderfoot is a cool Webapp scanner that I'll often run to get a 2nd opinion from Burp/AppSpider
git clone https://github.com/smicallef/spiderfoot.git /opt/spiderfoot

#sslyze is a good tool for running ssl/tls checks
git clone https://github.com/nabla-c0d3/sslyze.git /opt/sslyze

#testssl is a great script for checking variou ssl/tls vulns
git clone https://github.com/drwetter/testssl.sh.git /opt/testssl

#veil generates payloads that can bypass AV
git clone https://github.com/Veil-Framework/Veil-Evasion /opt/veil-evasion
