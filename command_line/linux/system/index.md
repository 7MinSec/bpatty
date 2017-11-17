# System

asciinema
--------
Creates ascii "movies" that record keystrokes and output (good for when you're doing a lot of command line work and want to have log of it later).

To install:

    curl -sL https://asciinema.org/install | sh

To begin a recording while eliminating any gaps in time over 1 second and saving the file to FILENAME:

    asciinema rec -w 1 -t "My title" NAME-OF-FILE

To play the file back:

    asciinema  -play FILENAME

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
According to the man page, this will "squeeze multiple adjacent empty lines, causing the output to be single spaced.

So if you have a file called `spacey.txt` with something like:

    Line 1
    (empty space)
    (empty space)
    Line 2

If you run it through `cat -s spacey.txt` the output will be:

    Line 1
    (empty space)
    Line 2

du
-------
Commands to get various disk usage stats.  

One of my favorites is this command, which gives you a list of root folders and their sizes (helps find bloated folders)

    du -h --max-depth=1 / | sort -h

To find top 20 offenders in a directory:

    du -sh /opt | sort -hr | head -n 20

    du -sh /var | sort -hr | head -n 20

Git
--------
A way to, um, git stuff.

### Git - the simple guide
This is "just a [simple guide](http://rogerdudler.github.io/git-guide/) for getting started with git. no deep s*** ;)"

gpg
--------
This tool generates PGP keypairs.

Check out [this guide](http://linux.koolsolutions.com/2009/03/17/gpgpgp-keys-part-1-generating-gpgpgp-keys-on-debian-linux/) for more info.

Follow the steps to create the key.  Then list the keys using:

    gpg --list-keys

In the output you'll see a line like this:

**pub 2048R/1234569 2015-12-29**

The 1234569 identifies your unique key.  Keep this in mind.

To backup your keys, reference http://linux.koolsolutions.com/2009/04/01/gpgpgp-part-5-backing-up-restoring-revoking-and-deleting-your-gpgpgp-keys-in-debian/

This command will backup your public key:

    gpg -ao mypub.key --export 1234569

This will backup your private key:

    gpg -ao myprivate.key --export-secret-keys 1234569

Another great resource for creating keys, signing messages, etc. is:
[https://www.digitalocean.com/community/tutorials/how-to-use-gpg-to-encrypt-and-sign-messages-on-an-ubuntu-12-04-vps](https://www.digitalocean.com/community/tutorials/how-to-use-gpg-to-encrypt-and-sign-messages-on-an-ubuntu-12-04-vps)

grep
--------
A tool for finding words/lines matching a pattern. Some handy examples below:

Searching a file for an *exact* match:

    grep -w "some exact string you want to find" name-of-file-you-are-searching

Searching the current dir and all sub-dirs for something, like

    grep word-you-are-searching-for -r *

If you want to see what line a given string appears on in a file, do something like:

    grep -n brianjohnson /usr/share/wordlists/rockyou.txt

ls
------
The `ls` command is helpful for listing stuff!

# Listing a folder with JUST file names:
`ls -m1`

Would show...

```
abc.md
bbb.md
ddd.md
etc...
```

mysqldump
------
Handy for dumping out backups of mysql dbs

### To dump a backup
    mysqldump -u name-of-admin-user -p password > outputfile.sql

scp
--------

A few handy *scp* commands:

### Download folder full of files from a remote host to your local machine
Connect to a host over SCP, then download a root folder (and everything in it) called `/cap`:

    scp -r root@192.168.3.101:/path/to/folder-you/want-to/download .


### Download a folder full of files over reverse ssh connection

For example, if you're using a PwnPulse and have a reverse shell bound to port 3333, you can SCP directly to the Pulse with:

    scp -r -P 3333 root@192.168.3.101:/folder-you-want-to-download .

### Upload a file to a remote host

	scp /my/local/file.txt root@destination:/the/folder/to/upload/to

screen
--------
"Screen is a console application that allows you to use multiple terminal sessions within one window. The program operates within a shell session and acts as a container and manager for other terminal sessions, similar to how a window manager manages windows."

Info here is heavily referenced from [this Digital Ocean support article](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-screen-on-an-ubuntu-cloud-server).  

### Start a new screen session
    screen -R name-of-session

Once you're running ssh or whatever you wanna leave running, hit `Ctrl+a d` to escape out of the screen session and leave it running.

To see all open *screen* sessions:

    screen -ls

If you had one called *bot* for example, you could reattach to it with:

    screen -R bot

### Kill a screen session
I usually just have one session going so I like to *kill 'em all!!!* ;-)

    killall screen

sed
------
A stream editor.

I don't use `sed` a whole lot, but here are some examples where it really saved my butt.

### Delete sentences starting with "this" and ending with "that"

**TLDR**: In the 7 Minute Security [full episode guide](FILL-ME_IN-LATER-K_THANKS-BYE), I thought it would be a good idea to embed `<iframe>` links of MP3s for each episode.  That was *not* a good idea as if you try to load 200+ iframes on a single page, browsers tend to barf.  

*Aaaaanyway* I wanted a way to quickly go through my episode guide Markdown document and strip out all sentences starting with `<iframe>` and ending with `</iframe>`.  Here was the `sed` command to do just that:

    `sed -e 's/\<iframe.*\>//' episodes.md > episodes2.md`

### Doing a "rip and replace" of IPs in a file
For the [Tommy Boy](FILlllmeinlater) VM, I needed a Wordpress database to be updated with whatever IP the VM booted with.  To do that, I (ab)used the gracious help of one of [g0tmi1k](https://blog.g0tmi1k.com)'s scripts which queried the VM's lan IP with:

    lanip=$(ip addr | grep inet | grep -v '127.0.0.1' | cut -d"/" -f1 | awk '{print $2}' | head -n 1)

And then replaced it in a file by doing:

    sed "s/x\.x\.x\.x/${lanip}/g" input-file output-file

ssh-keygen
--------
Generates RSA/DSA keys:

    ssh-keygen -t rsa -b 2048

Then, to copy it to your target's authorized_keys list:

    cat id_rsa.pub | ssh username@f.q.d.n 'cat >> ~/.ssh/authorized_keys'

swaks
--------
Is an awesome cmd-line email client.  Install with `apt-get install swaks` and then you could use something like the command below to alert you any time a server boots:

    swaks --to you@yourdomain.com --from "someemail@someplace.com" --server smtp.gmail.com:587 -tls --auth-user someemail@someplace.com --auth-password 'YOURPASSWORDGOESHERE' --header "Subject: SERVER X JUST BOOTED!" --body 'This is the body of the message dude!' --attach /tmp/somefile.txt

zip
--------
I always forget how to zip up a whole folder while password-protecting it, but this'll do it!

    zip -er name-of-your.zip name-of-dir-to-be-zipped

To break it down, this zips and encrypts a .zip file of folder named **name-of-dir-to-be-zipped**

* `-e` enables encryption for your zip file. This is what makes it ask for the password.

* `-r` makes the command recursive, meaning that all the files inside the folder will be added to the zip file.

* `name-of-your.zip` is the name of the output file.

* `name-of-dir-to-be-zipped` is the folder you want to zip.
