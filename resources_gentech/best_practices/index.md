# Best Practices

First time PC/Mac setup
--------

### Once it's out of the box...
Whenever I get a new machine, here are some general things I do to update/secure it:

* Download and install all latest OS/app updates, then set things to auto-patch wherever possible

* Change screen saver to require password when activated (see **System Preferences -> Security & Privacy** on the Mac side, **Control Panel ->Personalization** on the PC)
* Use Firefox or Chrome as primary browser and install:
 * uBlock Origin
 * LastPass plugin
* Install these apps:
 * [ProXPN](http://proxpn.me) when connected to any wifi but my own
 * VMWare/VirtualBox/etc - for any research or testing where I am even 1% suspicious I'll get bit by malware, I install a fully updated VM and snapshot it. When research is over I revert to golden VM
 * Firewall - [Little Snitch](https://www.obdev.at/products/littlesnitch/index.html) for Mac, [Glasswire](https://www.glasswire.com/) for PC.  I did a podcast episode on Glasswire [here](https://media.zencast.fm/embed/7-minute-security-podcast-podcast/89.mp3)
 * Antivirus/antimalware - I don't currently run anything on the Mac, but regularly scan my PCs with [MalwareBytes](http://malwarebytes.com) products.  Sophos also offers a [free install package](https://home.sophos.com/reg) for Macs and PCs.
* *Don't* install (or uninstall *or* enable [click to play](http://krebsonsecurity.com/2013/03/help-keep-threats-at-bay-with-click-to-play/)) these things:
  * Flash (see [Krebs article](http://krebsonsecurity.com/2014/05/why-you-should-ditch-adobe-shockwave/) on this)
  * Java (see [Krebs article](http://krebsonsecurity.com/how-to-unplug-java-from-the-browser/) on this)
* Encrypt hard drive (FileVault for Mac, Bitlocker for PC)
* Put tape over the Webcam
* Backup your stuff! I like [CrashPlan](http://www.crashplan.com) and did a podcast episode on it [here](https://media.zencast.fm/embed/7-minute-security-podcast-podcast/27.mp3).

### Mac-specific hardening
* Consider this [MacOS Security and Privacy Guide](https://github.com/drduh/macOS-Security-and-Privacy-Guide) for further security on your Mac system.

Internet safety
-------
Here are some general tips I've assembled and sent out in various bits and pieces to friends, families, and enemies.  Wait, not enemies, but the first two.

### Email
 * Don't click on links.  
 * Don't open attachments.
 * Don't click on links.
 * Don't open attachments.
 * When in doubt if a received message is legit, *call* the sender to verify.
 * Don't reply to junk mail and ask them to "take you off their list."  This just confirms you're a real living, breathing person who is checking mail actively (this tip is for you, dad).
 * Create a "junk" account for any newsletters, shopping sites, or places you know are going to spam you with stuff you don't care about.  Use this junk account for all online interactions that are outside of personal communications with friends/family.  P.S. if you need a one-time use junk mail account, [Sharklasers](http://sharklasers.com) is *perfect* for this.

### Passwords
#### How should I manage my passwords?
The better question might be "How should I *not* manage" my passwords, as these are all no-nos:

* Unencrypted Excel spreadsheet
* Post-it notes on your monitor
* Notes hidden under your keyboard/desk/foot/chin

Instead, use a password vault like [LastPass](http://lastpass.com) or [1Password](http://1password.com) to manage passwords.


#### How long/strong of a password should I use?
Use whatever the maximum number of characters allowed is for the site/service.  For instance, if the site allows you to use a 64-character password, make your password vault tool make you one that is 64 characters with the maximum amount of complexity possible (numbers, symbols, mix of caps/uppercase, etc).  Then you'll get something like this:

`GhW7XpwUX@kiC6oe6p2[8zFfLKse.PBLbr26si6.tPcoKBK.J${(dVV8$Js6ZA(t`

The password above will take a bajillion years longer to crack than `Fall2016`, `Vikings123`, `TwinsWin2000` or many of the other horrendous passwords I've seen in the past.

#### What kinds of things make up a *bad* password?
Don't use any combination of these within your password:

* Birthday
* First name
* Last name
* Maiden name
* Kids' names
* Social security number
* Address
* Phone number

### Social media
#### Think about the "big picture" of your social media footprint
When I was in college, a professor gave me a piece of advice that has stuck with me even today: "Don't publish anything that you wouldn't want your spouse, best friend, current boss or future boss to read.  Or pretend that the sentence you just wrote will be on the front page of the paper, and that you will have to answer to it."  

#### General advice

* Know that your social media profiles can and *will* be looked at by your current/future employers
* Don't geo-tag your photos
* Don't post about your big out-of-town vacation until you get back
* If posting about something work-related, ensure there aren't sensitive bits of information leaking in the background, like:
 * Wifi passwords
 * Client names
 * Passwords
* Think about this fact that I just made up: no argument has ever been maturely settled on Twitter.
* Regularly review what apps are "plugged in" to your various social media accounts:
 * [Twitter](https://support.twitter.com/articles/76052)
 * [Facebook](https://www.facebook.com/help/204306713029340/)
 * [Instagram](https://instagram.com/accounts/manage_access)

### Web browsing
#### Which Web browser should I use?
* For non-techies: I recommend Chrome.  It will keep itself updated (I've seen instances where something (malware?) on a machine prevented Firefox from notifying about updates and the version has gotten stale - and thus vulnerable.
* For everybody else: Chrome or Firefox.
* For NOBODY: Internet Explorer or Edge.

### Wireless
#### Don't use open/free wireless hotspots
But if you have to, [keep these considerations in mind](https://thebestvpn.com/public-wifi-security/).  
