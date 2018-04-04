# Web tech
You know...like Docker and stuff

Docker
-----
How to get it up and running in Ubuntu 16.04.  

### Install Docker

    apt-get install docker.io

Simple, yeah?

#### Some quick reference docker commands:
* List docker images that are currently running: `docker ps`
* Export a docker to a .tar file: `docker save NAME > /tmp/NAME.tar`
* Exec a command on a docker image: `docker exec -t -i abcd(HUGE LONG STRING)3fsdfslifjsdlifsjdfsdlf cat /etc/passwd`

### Install some cool docker thingies!

#### Install Juice-Shop
Juice Shop, according to [OWASP](https://www.owasp.org/index.php/OWASP_Juice_Shop_Project) is "an intentionally insecure webapp for security trainings written entirely in Javascript which encompasses the entire OWASP Top Ten and other severe security flaws."

    docker pull bkimminich/juice-shop

##### Run it

     docker run -d -p 3000:3000 bkimminich/juice-shop

##### Run it with a 7 Minute Security theme!

    docker run -d -e "NODE_ENV=7ms" -p 3000:3000 bkimminich/juice-shop

##### Make images/backups

One thing I found during my hacking of Juice Shop was that my brute-force or sqlmap efforts would cause the container to die, and thus I'd have to restarted, which wiped out my scoreboard.  Using [this site](https://gist.github.com/thaJeztah/8d0e901bd21329d80cf2) (h/t hackern0v1c3 on IRC) taking a point-in time snapshot is pretty easy:

    docker commit --message="This is the description of my snapshot" 130s9df83js09d a_short_description:093016

The `130s...` is the id of the container you want to make an image of.

#### Install Rainmap
I heard about this from [Jerry Gamblin's blog](http://jerrygamblin.com/2016/08/30/rainmap-container/) - it's basically a slick Web interface for [nmap](../cmdline/linux/nmap.md).

Head to [https://hub.docker.com/r/jgamblin/rainmap/](https://hub.docker.com/r/jgamblin/rainmap/) for instructions, but it basically boils down to installing the docker with:

    docker pull jgamblin/rainmap

##### Run it

    docker run -ti -p 8080:8080 --name rainmap jgamblin/rainmap

Since rainmap stays "open" in the command line, I recommend you first use [screen](../cmdline/linux/screen.md) to setup a special session for it.  That way you can completely log out via SSH and the docker will stay running.

    screen -R rainmapscreen

With the new screen created, you can run rainmap and follow the prompts:

    docker run -ti -p 8080:8080 --name rainmap jgamblin/rainmap

Now, just hit `Ctrl+a d` to exit the screen session, and go to `http://ip.of.your.docker:8080/console` to login!

##### Run it (again)
After doing a `Ctrl+C` to stop the Web interface, if you run the same `docker` command to start the docker again, you might get this:

>docker: Error response from daemon: Conflict. The name "/rainmap" is already in use by container eeecfa0ff3f58a4ed67a4fa045beae462a49fb7d9df9a30c0f259f90c1684d59. You have to remove (or rename) that container to be able to reuse that name..

You can remove it with:

    docker rm rainmap

Then start it again with:

    docker run -ti -p 8080:8080 --name rainmap jgamblin/rainmap

#### Install Quassel
Basically I followed [this article](https://getcarina.com/docs/tutorials/quassel-on-carina/) to get Quassel installed, but the steps boiled down to:

Get yourself a Ubuntu droplet on AWS, DigitalOcean, etc.

Run the `apt-get update` and `apt-get upgrade` routine.

Install docker with `apt-get install docker.io`

Pull the Quassel Docker image with `docker pull linuxserver/quassel-core`

Create a volume container to store Quassel data:

	docker create \
	--name quassel-data \
	--volume /config \
	linuxserver/quassel-core

Run Quassel:

	docker run \
	--name quassel-core \
	--volumes-from quassel-data \
	--publish 4242:4242 \
	linuxserver/quassel-core

Open port 4242 (I recommend doing this first from your own public IP to finish the config, then open up so you can be connected from anywhere).

Download a [Quassel client](http://quassel-irc.org/downloads) and connect to your core on port 4242.

Follow the steps to configure the core and (optionally) open up port 4242 to the Internet so you can connect from anywhere.

##### Install Lets Encrypt SSL cert on Quassel core

Install LetsEncrypt with

	sudo apt-get install letsencrypt

Then generate a cert for the FQDN of your Quassel core.  Example:

	sudo letsencrypt certonly --standalone -d quassel.mydomain.com

Make sure LetsEncrypt servers can hit your Quassel core via:

	sudo iptables -A INPUT -p tcp --dport 443 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT

Then incorporate your LetsEncrypt cert into Quassel.  I followed [this site] (https://github.com/joelpet/docker-quassel-irc/commit/b1c2341e460d9dfb95c9e16c3e0323734b598a8e) which said to basically `cat` the two LetsEncrypt .pem files into a `quasselCert.pem` file:

	cat .../privkey.pem .../fullchain.pem > /full/path/to/wherever/you/find/quasselCert.pem

Then script your LetsEncrypt auto-renewal by following [this](http://hackernovice.com/2016/10/10/lets-encrypt-renewal/).

Hugo
------

### Basic install on Digital Ocean w/Ubuntu 16.04

Pulled down install package:

    wget https://github.com/spf13/hugo/releases/download/v0.16/hugo_0.16-1_amd64.deb

Installed with:

    dpkg -i hugo_0.16-1_amd64.deb

Change to the dir I want to install Hugo on:

    cd /var/www

Make a new Hugo site there:

    hugo new site .

Create a test post:

    hugo new post/hithere.md

Installed a sample theme:

    git clone https://github.com/fredrikloch/hugo-uno.git themes/uno

Edit `config.toml` to change a few basics:

    baseurl = "http://replace-this-with-your-hugo-site.com/"
    languageCode = "en-us"
    title = "My New Hugo Site"
    theme = "uno"

Started the server on port 80:

    sudo hugo server --bind=0.0.0.0 --baseUrl=http://the.public-ip.or.FQDN --port=80


Limnoria
--------
A popular IRC bot.  

### Install
This area follows an install for Ubuntu 16.04 which is pretty straight forward when following [this article](https://github.com/ProgVal/Limnoria),  For me, the long and short of it is I ran these commands as root:

    git clone https://github.com/ProgVal/Limnoria.git
    sudo pip install -r requirements.txt
    sudo python setup.py install

Note: if `pip` is not installed, install it with `sudo apt-get install python-pip python-dev build-essential`

#### Add a basic user    
Then continue with [this guide](http://doc.supybot.aperio.fr/en/latest/use/install.html) and add a basic user to your box, such as with `adduser brian` (then follow the .  Then `su brian` and create a bot folder, like `mkdir ~/bot` and then `cd ~/bot`.

#### Run the bot creation wizard
Run `supybot-wizard` which will walk you through the initial config of your bot.  When you're done, it will right the config file out to something like `bot.conf`.

#### A few security-ish things...
Before you actually connect to IRC (see next section), I recommend you open up `bot.conf` and make one slight change:

    supybot.plugins.Factoids.requireVoice: True

By setting this value to `True` only users with voice or above can make the bot learn/forget stuff.  Now that's a personal preference - mainly because I don't want people doing stuff like `!learn #7ms braimee is a moron`! or whatever :-)

#### Connect your bot to IRC
When you're ready to rock, issue this command: `supybot bot.conf` and you should see your bot pop up on IRC and join the channels you've instructed it to!

Update: last time I did this, the bot log kept saying things like "only SASL blah blah accepted."  I had to open my `bot.conf` file and there were some fields there dealing with SASL username and password.  I set these to the bot name and password I had setup previously in the wizard, then ran `supybot bot.conf` again and BLAMO!  Connected.

#### Identify yourself as "boss"

    user identify your-username your-password

Or

    identify your-username your-password

### Bot commands

#### Config commands
You can use the `!config` command to fine-tune the bot on the fly.  Here's what I've used so far:

    !config supybot.reply.mores.instant 2

The `!supybot.reply.mores.instant` property "Determines how many mores will be sent instantly."  I needed to use it because when people were issuing `!news` in the #7MS channel, the news would be truncated if there were too many items.

Read more about these commands [here](https://gist.github.com/oscarcp/2989245).

#### Factoids
You can add one with:

    !learn #channel-name tenaciousd is The greatest band on earth

Then when people type `!tenaciousd` they will get that response.

If you want an alternate descriptor, use the same command again with a different string, like:

    !learn #channel-name tenaciousd is The greatest band on earth.

To forget a factoid and all its various associations, use:

    !forget #channel-name tenaciousd *

#### Dunno commands
These are cheeky things your bot can say when a command isn't recognized.  Add them with:

    !dunno add #channel-name "You are not making sense."

#### News database

##### Add a news article to the database

    news add #channel-name 600 This is the subject: and this is the text of full readout

The `600` is for how many seconds you want the news to be active. Quick ref:

* 86400 = 1 day
* 604800 = 1 week
* 2419200 = about a month

##### List all news items

    news #channel-name

##### Get details on a specific item

    news #channel-name 5

##### Forget a news item

    news remove #channelname 1    

#### Praise database
A fun way to add praise "templates" when people do/say good things in the channel.

##### Add a praise
The `$who` will be replaced by the user you elect to praise

    !praise add #channel-name "Everybody should give $who electronic high-fives for being the best $who that $who can be."

##### Praise a user
In a channel, do this

    !praise name-of-user


#### RSS
You can add RSS feeds for sites, which you can then "announce" to various channels.  I didn't have that plugin loaded by default, so I did:

    !load rss

Which then told me I didn't have the "feedparser" loaded.  I installed it with:

    apt-get install python3-feedparser

Then the module was able to load!

##### Adding RSS feed to bot
You can teach the bot about an RSS feed with this format:

    rss add name-of-feed https://url.of.feed.to-add

For example:

    rss add 7MS https://7ms.us/rss/

Then you can "announce" feed updates to channels by using:

    rss announce add #channel-name name-of-feed

So something like this should work:

    rss announce add #7ms 7ms

#### Quotes database

##### Add a quote

    !quote add #channel-name "Brothers don't shake hands. Brothers gotta hug." - Tommy Callahan, Tommy Boy (http://www.imdb.com/title/tt0114694/quotes)

#### Say command

With my version of Limnoria (2016.08.07) the `say` command wasn't working correctly.  I could `say` quotegrabs, but couldn't make the bot say something in a specific channel.  I found out the issue was the [Anonymous plugin has to be loaded](https://github.com/ProgVal/Limnoria/tree/2c1de2328bbf56741ea39541a293f1cc26496f68/plugins/Anonymous) like so:

    !load anonymous

Then, you can make the bot `say` things by sending it a PM like so:

    anonymous say #7ms Is this thing on?

#### Scheduler
You can make the bot say things in the future.  For example, to say something an hour into the future:

    scheduler add 3600 announce say #7ms Hello, this is just a test

To say something on a regular basis, use this context:

    scheduler repeat hourlyhello 3600  announce say #7ms Hello, this is just an hourly test of the bot scheduling system.  If you're seeing this, stuff is working right.  If you don't see this, please report to an operator immediately!

The `hourlyhello` is just a name identifier for your reference.

#### Success database
Things the bot can say when it successfully understands a command.

##### Add a "success":

    !success add #channel-name "Got it.  You and I are on the same page."

### Locking down the bot
By setting your bot with this command (READ ALL THIS BEFORE YOU DO), it pretty much won't let *anybody* register, make it `learn` commands, etc.  What I'm testing right now is I first identified with my bot, then issued this:

    admin capability add braimee user

I *think* that then, going forward, I should be able to identify with the bot if necessary.  Otherwise, the command below locks things down *so* hard that you can't even ID with the bot.  So, use this command at your own risk:

    !config supybot.capabilities.default False

Minecraft
--------
Once I get a Linux server up and running, here's my quick script for getting Minecraft up and running (heavily borrowed from [this Digital Ocean article](https://www.digitalocean.com/community/tutorials/how-to-set-up-a-minecraft-server-on-linux)):

	mkdir /minecraft
	cd /minecraft
	apt-get install default-jre -y
	#default-jdk?
	wget https://s3.amazonaws.com/Minecraft.Download/versions/1.10.2/minecraft_server.1.10.2.jar
	screen -S "Minecraft server"
	java -Xmx1024M -Xms1024M -jar minecraft_server.1.10.2.jar nogui
	echo eula=true > eula.txt
	java -Xmx1024M -Xms1024M -jar minecraft_server.1.10.2.jar nogui

Then hit *Ctrl+a* , *d* to detach from the "screen"

To reattach screen type *screen -R*

Edit *server.properties* to tweak the server properties.
