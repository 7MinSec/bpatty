# du
Commands to get various disk usage stats.  

One of my favorites is this command, which gives you a list of root folders and their sizes (helps find bloated folders)

    du -h --max-depth=1 / | sort -h

To find top 20 offenders in a directory:

    du -sh /opt | sort -hr | head -n 20
    
    du -sh /var | sort -hr | head -n 20 