# Critical Security Controls
If you're not familiar with the CSCs, one good place to start is this guide: [CIS Controls Implementation Guide for Small- and Medium-Sized Enterprises (SMEs)](https://www.cisecurity.org/white-papers/cis-controls-sme-guide/) - and you can just grab the PDF [here](https://www.cisecurity.org/wp-content/uploads/2017/09/CIS-Controls-Guide-for-SMEs.pdf).

On this page, I'm trying to assemble a good list of free/cheap tools and techniques to help orgs map to the CSC top 5/10/15/20.


## Control 1: Inventory of Authorized and Unauthorized Devices

"Actively manage (inventory, track, and correct) all hardware devices on the network so that only authorized devices are given access, and unauthorized and unmanaged devices are found and prevented from gaining access."

How to do it?

### Snipe-IT 
This looks to be a great open source tool that helps you keep track of all your stuff.

### Installing Snipe-IT
If you've got a fresh Ubuntu box, just run this:

````
cd /tmp
wget https://raw.githubusercontent.com/snipe/snipe-it/master/install.sh
chmod 744 install.sh
./install.sh
````

After that my thing for Apache2 just showed the default page, so I did this:

`mv 000-default.conf 000-default.conf.bak`

Then 

`service apache2 restart`

Then import some stuff - see here for some samples: https://snipe-it.readme.io/docs/importing
