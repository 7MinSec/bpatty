#du
Commands to get various disk usage stats.  

One of my favorites is this command, which gives you a list of root folders and their sizes (helps find bloated folders)

    du -h --max-depth=1 / | sort -h
