# ncrack
An app for brute-forcing credentials in RDP, SSH, etc.  An example of brute-forcing RDP:

    ncrack -v -u administrator -P /opt/SecLists/Passwords/rockyou.txt -p 3389 f.q.d.n
