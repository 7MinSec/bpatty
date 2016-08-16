#john (a.k.a. john the ripper)
A fantastic tool for cracking passwords.  A fantastic reference for hashes and cracking is the [Pentest Monkey cheat sheet](http://pentestmonkey.net/cheat-sheet/john-the-ripper-hash-formats) but here's a few specific commands I've run to crack hashes:

    john --format=netntlm hashes-i-collected.txt --wordlist=/usr/share/seclists/Passwords/rockyou.txt

Check this great presentation on password cracking from [Derby Con 2015](http://www.irongeek.com/i.php?page=videos/derbycon5/fix-me18-my-password-cracking-brings-all-the-hashes-to-the-yard-larry-pesce)
