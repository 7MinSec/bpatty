## hashcat
An awesome pw-cracking utility.  I like that you can run it against a whole folder full of .rule files, so if I just want to throw a basic "kitchen sink" of wordlists against a .txt doc, I'd do:

    hashcat -m 5500 -a 1 NTLM-hashes-2-be-cracked.txt /usr/share/hashcat/rules/*.rule

This is a great rule set to get as well: [https://github.com/praetorian-inc/Hob0Rules](https://github.com/praetorian-inc/Hob0Rules).  
