Linux command line
==================

arpwatch
--------
*arpwatch* looks to be a cool way to partially satisfy [Critical Security Control #1](https://www.cisecurity.org/controls/) (Inventory of Authorized and Unauthorized Devices).  The idea is you use arpwatch to keep an eye on all MAC addresses in the environment, and get alerted when new devices pop up.  

I've not dug too much into it yet, but here's a great [how to guide](https://www.virtualizationhowto.com/2016/02/arpwatch-smtp-configuration/) that I found.

asciinema
--------
Creates ascii "movies" that record keystrokes and output (good for when you're doing a lot of command line work and want to have log of it later).
 
To install:
 
    curl -sL https://asciinema.org/install | sh
 
To begin a recording while eliminating any gaps in time over 1 second and saving the file to FILENAME:
 
    asciinema rec -w 1 -t "My title" NAME-OF-FILE
 
To play the file back:
 
    asciinema  -play FILENAME


bluto
--------
Bluto’s a neat tool that does DNS brute forcing, some Googling and other social-y/recon-y stuff.
 
To install:
 
    sudo pip install git+git://github.com/RandomStorm/Bluto
 
Then type bluto plus the domain name and you’re good to go!

cat
--------
A nice utility for concatenating and printing files.

### Use cases:

#### Get unique words out of a file

*This* command is nice if you've got a large file full of various text, numbers, etc. and you need an output of *just* unique words from it:

    cat comment_file.txt | tr " " "\n" | sort | uniq


#### Clear Linux terminal history

    cat /dev/null /home/brian/.bash_history

### Command line switches

#### -s
According to the man page, this will "squeeze multiple adjacent empty lines, causing the output to be single spaced."

So if you have a file called `spacey.txt` with something like:

    Line 1
    (empty space)
    (empty space)
    Line 2
    
If you run it through `cat -s spacey.txt` the output will be:

    Line 1
    (empty space)
    Line 2
    
curl
--------
A great util to slurp Web stuff off of Web sites

### To check if a site uses HSTS:

     curl -s -D- https://test.com | grep Strict
