# gpg

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
