#Kali Essentials
#This script does some `git-clone`ing to pull down tools I always carry with me on my Kali boxes:
#
##################
#PCCredz parses pcaps for sensitive data
git clone https://github.com/lgandx/PCredz /opt/pcredz
#recon-ng is a great tool for reconning all the things
git clone https://bitbucket.org/LaNMaSteR53/recon-ng.git /opt/recon-ng
#egress framework helps you test network segmentation easily with a few python commands
git clone https://github.com/stufus/egresscheck-framework.git /opt/egress
#testssl is a great script for checking variou ssl/tls vulns
git clone https://github.com/drwetter/testssl.sh.git /opt/testssl
#chuckle is might handy when it comes to SMB relay exploitation
git clone https://github.com/nccgroup/chuckle.git /opt/chuckle
wget https://github.com/CoreSecurity/impacket/blob/impacket_0_9_15/examples/smbrelayx.py /opt/chuckle/
#Commix is a command-injection tool that I've never gotten to run successfully in any live pentests, but the examples sure look neat ;-)
git clone https://github.com/stasinopoulos/commix.git /opt/commix
#eyewitness is a nice recon tool for putting some great visualization behind nmap scans
git clone https://github.com/ChrisTruncer/EyeWitness /opt/eyewitness
#Responder is awesome for LLMNR, NBT-NS and MDNS poisoning
git clone https://github.com/lgandx/Responder.git /opt/responder
#Sniper is a great automated recon scanner
git clone https://github.com/1N3/Sn1per.git /opt/sniper
#Aha helps take output from testssl.sh and make it nice and HTML-y
git clone https://github.com/theZiz/aha.git /opt/aha
#Another good tool for running ssl/tls checks
git clone https://github.com/iSECPartners/sslyze.git /opt/sslyze
#A cool Webapp scanner that I'll often run to get a 2nd opinion from Burp/AppSpider
git clone https://github.com/smicallef/spiderfoot.git /opt/spiderfoot
#A mitm framework - I did an episode on it here: https://7ms.us/7ms-228-fun-with-bettercap/
git clone https://github.com/evilsocket/bettercap.git /opt/bettercap
#A mitm framework that I've not tried out yet
git clone https://github.com/byt3bl33d3r/MITMf.git /opt/mitmf
#Generates payloads that can bypass AV
git clone https://github.com/Veil-Framework/Veil-Evasion /opt/veil-evasion
#Findsploit finds exploits in local and online databases
git clone https://github.com/1N3/Findsploit.git /opt/findsploit