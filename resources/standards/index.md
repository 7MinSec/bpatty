# Standards

Critical Security Controls
--------
If you're not familiar with the CSCs, one good place to start is this guide: [CIS Controls Implementation Guide for Small- and Medium-Sized Enterprises (SMEs)](https://www.cisecurity.org/white-papers/cis-controls-sme-guide/) - and you can just grab the PDF [here](https://www.cisecurity.org/wp-content/uploads/2017/09/CIS-Controls-Guide-for-SMEs.pdf).  They've got a tool called [CIS-CAT](https://learn.cisecurity.org/cis-cat-landing-page) to help you benchmark systems against the CIS standards.

On this page, I'm trying to assemble a good list of free/cheap tools and techniques to help orgs map to the CSC top 5/10/15/20.

### Control 1: Inventory of Authorized and Unauthorized Devices

"Actively manage (inventory, track, and correct) all hardware devices on the network so that only authorized devices are given access, and unauthorized and unmanaged devices are found and prevented from gaining access."

How to do it?

### Control 2: Inventory of Authorized and Unauthorized Software

* [CIS blog article on keeping a watchful eye on software](https://www.cisecurity.org/keeping-a-watchful-eye-on-software/?utm_campaign=Controls&utm_source=hs_email&utm_medium=email&utm_content=58833125&_hsenc=p2ANqtz-9gG2ml8z1d7HhLt1Zhb6pGRdx82H3TgaUGzOBsJS9q4DLjiKkAloj5VPLMbI65b1ZMwbU24MSpwO9srPJ-6ZcZNL-ryQ&_hsmi=58833125)
* [Script to help inventory systems](https://github.com/CIS-CERT/CIS-ESP)

#### Snipe-IT
This looks to be a great open source tool that helps you keep track of all your stuff.

#### Installing Snipe-IT
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

GDPR
-------
There's a [podcast episode](https://7ms.us/7ms-294-gdpr-me-asap/) where I talk about my first GDPR assessment, and here's also a few helpful links to get up to speed on GDPR:

* [GDPR for dummies](http://www.dummies.com/education/politics-government/general-data-protections-regulation-gdpr/)
* [GDPR for you](https://7ms.us/7ms-294-gdpr-me-asap/) is a great GDPR primer with some solid downloadables as well


NIST CSF (Cyber Security Framework)
--------
* Tenable has a [nice article](https://www.tenable.com/blog/understanding-nist-s-cybersecurity-framework) on the framework
* Rapid 7 has one too, also featuring [a video](https://www.rapid7.com/resources/nist-cybersecurity-framework-explained/)
* FRSecure has a [blog article](https://frsecure.com/blog/how-to-use-and-not-use-the-nist-csf/) on how to use (and not use) the framework

PCI
-------
I found that [this site](http://blog.securitymetrics.com/2016/10/how-do-merchant-levels-determine-pci.html) does a nice job of understanding PCI merchant levels, when it's necessary to get a QSA involved, etc.
