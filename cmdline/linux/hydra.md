# hydra
Another great app for brute-forcing services.  Here's an example for brute'in RDP:

    hydra -t 4 -V -l administrator -P 500-worst-passwords.txt rdp://f.q.d.n

Here's another example for SSH:

    hydra -l root -P /your/password/list.txt 1.2.3.4 ssh