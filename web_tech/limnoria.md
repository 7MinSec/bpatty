# Limnoria
A popular IRC bot.  


## Install
This area follows an install for Ubuntu 16.04 which is pretty straight forward when following [this article](https://github.com/ProgVal/Limnoria),  For me, the long and short of it is I ran these commands as root:

    git clone https://github.com/ProgVal/Limnoria.git
    sudo pip install -r requirements.txt
    sudo python setup.py install
    
Note: if `pip` is not installed, install it with `sudo apt-get install python-pip python-dev build-essential`
    
### Add a basic user    
Then continue with [this guide](http://doc.supybot.aperio.fr/en/latest/use/install.html) and add a basic user to your box, such as with `adduser brian` (then follow the .  Then `su brian` and create a bot folder, like `mkdir ~/bot` and then `cd ~/bot`.

### Run the bot creation wizard
Run `supybot-wizard` which will walk you through the initial config of your bot.  When you're done, it will right the config file out to something like `bot.conf`.

### A few security-ish things...
Before you actually connect to IRC (see next section), I recommend you open up `bot.conf` and make one slight change:

    supybot.plugins.Factoids.requireVoice: True
    
By setting this value to `True` only users with voice or above can make the bot learn/forget stuff.  Now that's a personal preference - mainly because I don't want people doing stuff like `!learn #7ms braimee is a moron`! or whatever :-)

### Connect your bot to IRC
When you're ready to rock, issue this command: `supybot bot.conf` and you should see your bot pop up on IRC and join the channels you've instructed it to!

Update: last time I did this, the bot log kept saying things like "only SASL blah blah accepted."  I had to open my `bot.conf` file and there were some fields there dealing with SASL username and password.  I set these to the bot name and password I had setup previously in the wizard, then ran `supybot bot.conf` again and BLAMO!  Connected.

### Identify yourself as "boss"

    user identify your-username your-password
    
Or

    identify your-username your-password

## Bot commands

### Config commands
You can use the `!config` command to fine-tune the bot on the fly.  Here's what I've used so far:

    !config supybot.reply.mores.instant 2

The `!supybot.reply.mores.instant` property "Determines how many mores will be sent instantly."  I needed to use it because when people were issuing `!news` in the #7MS channel, the news would be truncated if there were too many items.

Read more about these commands [here](https://gist.github.com/oscarcp/2989245).

### Factoids
You can add one with:

    !learn #channel-name tenaciousd is The greatest band on earth

Then when people type `!tenaciousd` they will get that response.

If you want an alternate descriptor, use the same command again with a different string, like:

    !learn #channel-name tenaciousd is The greatest band on earth.

To forget a factoid and all its various associations, use:

    !forget #channel-name tenaciousd * 

### Dunno commands
These are cheeky things your bot can say when a command isn't recognized.  Add them with:

    !dunno add #channel-name "You are not making sense."

### News database

#### Add a news article to the database

    news add #channel-name 600 This is the subject: and this is the text of full readout
    
The `600` is for how many seconds you want the news to be active. Quick ref:

* 86400 = 1 day
* 604800 = 1 week
* 2419200 = about a month

#### List all news items

    news #channel-name
    
#### Get details on a specific item

    news #channel-name 5

#### Forget a news item

    news remove #channelname 1    

### Praise database
A fun way to add praise "templates" when people do/say good things in the channel.

#### Add a praise
The `$who` will be replaced by the user you elect to praise

    !praise add #channel-name "Everybody should give $who electronic high-fives for being the best $who that $who can be."
    
#### Praise a user
In a channel, do this

    !praise name-of-user


### RSS
You can add RSS feeds for sites, which you can then "announce" to various channels.  I didn't have that plugin loaded by default, so I did:

    !load rss
    
Which then told me I didn't have the "feedparser" loaded.  I installed it with:

    apt-get install python3-feedparser
    
Then the module was able to load!

#### Adding RSS feed to bot
You can teach the bot about an RSS feed with this format:

    rss add name-of-feed https://url.of.feed.to-add

For example:

    rss add 7MS https://7ms.us/rss/
    
Then you can "announce" feed updates to channels by using:

    rss announce add #channel-name name-of-feed

So something like this should work:

    rss announce add #7ms 7ms

### Quotes database

#### Add a quote

    !quote add #channel-name "Brothers don't shake hands. Brothers gotta hug." - Tommy Callahan, Tommy Boy (http://www.imdb.com/title/tt0114694/quotes)

### Say command

With my version of Limnoria (2016.08.07) the `say` command wasn't working correctly.  I could `say` quotegrabs, but couldn't make the bot say something in a specific channel.  I found out the issue was the [Anonymous plugin has to be loaded](https://github.com/ProgVal/Limnoria/tree/2c1de2328bbf56741ea39541a293f1cc26496f68/plugins/Anonymous) like so:

    !load anonymous
    
Then, you can make the bot `say` things by sending it a PM like so:

    anonymous say #7ms Is this thing on?
    
### Scheduler
You can make the bot say things in the future.  For example, to say something an hour into the future:

    scheduler add 3600 announce say #7ms Hello, this is just a test
    
To say something on a regular basis, use this context:

    scheduler repeat hourlyhello 3600  announce say #7ms Hello, this is just an hourly test of the bot scheduling system.  If you're seeing this, stuff is working right.  If you don't see this, please report to an operator immediately!
    
The `hourlyhello` is just a name identifier for your reference.

### Success database
Things the bot can say when it successfully understands a command.

####Add a "success":

    !success add #channel-name "Got it.  You and I are on the same page."
    
# Locking down the bot
By setting your bot with this command (READ ALL THIS BEFORE YOU DO), it pretty much won't let *anybody* register, make it `learn` commands, etc.  What I'm testing right now is I first identified with my bot, then issued this:

    admin capability add braimee user

I *think* that then, going forward, I should be able to identify with the bot if necessary.  Otherwise, the command below locks things down *so* hard that you can't even ID with the bot.  So, use this command at your own risk:

    !config supybot.capabilities.default False