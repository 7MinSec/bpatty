#Limnoria
A popular IRC bot.  


##Install
This area follows an install for Ubuntu 16.04 which is pretty straight forward when following [this article](https://github.com/ProgVal/Limnoria),  For me, the long and short of it is I ran these commands as root:

    git clone https://github.com/ProgVal/Limnoria.git
    sudo pip install -r requirements.txt
    sudo python setup.py install
    
###Add a basic user    
Then continue with [this guide](http://doc.supybot.aperio.fr/en/latest/use/install.html) and add a basic user to your box, such as with `useradd brian`.  Then `su brian` and create a bot folder, like `mkdir ~/bot` and then `cd ~/bot`.

###Run the bot creation wizard
Run `supybot-wizard` which will walk you through the initial config of your bot.  When you're done, it will right the config file out to something like `bot.conf`.

###Connect your bot to IRC
When you're ready to rock, issue this command: `supybot bot.conf` and you should see your bot pop up on IRC and join the channels you've instructed it to!

###Identify yourself as "boss"
    identify your-username your-password

##Bot commands

###Config commands
You can use the `!config` command to fine-tune the bot on the fly.  Here's what I've used so far:

    !config supybot.reply.mores.instant 2

The `!supybot.reply.mores.instant` property "Determines how many mores will be sent instantly."  I needed to use it because when people were issuing `!news` in the #7MS channel, the news would be truncated if there were too many items.

Read more about these commands [here](https://gist.github.com/oscarcp/2989245).

###Factoids
You can add one with:

    !learn #channel-name tenaciousd is The greatest band on earth

Then when people type `!tenaciousd` they will get that response.

If you want an alternate descriptor, use the same command again with a different string, like:

    !learn #channel-name tenaciousd is The greatest band on earth.

To forget a factoid and all its various associations, use:

    !forget #channel-name tenaciousd * 

###Dunno commands
These are cheeky things your bot can say when a command isn't recognized.  Add them with:

    !dunno add #channel-name "You are not making sense."

###News database

####Add a news article to the database

    news add #channel-name 600 This is the subject: and this is the text of full readout
    
The `600` is for how many seconds you want the news to be active. Quick ref:

* 86400 = 1 day
* 604800 = 1 week
* 2419200 = about a month

####List all news items

    news #channel-name
    
####Get details on a specific item

    news #channel-name 5

####Forget a news item

    news remove #channelname 1    

###Praise database
A fun way to add praise "templates" when people do/say good things in the channel.

####Add a praise
The `$who` will be replaced by the user you elect to praise

    !praise add #channel-name "Everybody should give $who electronic high-fives for being the best $who that $who can be."
    
####Praise a user
In a channel, do this

    !praise name-of-user


###RSS
You can add RSS feeds for sites, which you can then "announce" to various channels.  I didn't have that plugin loaded by default, so I did:

    !load rss
    
Which then told me I didn't have the "feedparser" loaded.  I installed it with:

    apt-get install python3-feedparser
    
Then the module was able to load!

####Adding RSS feed to bot
You can teach the bot about an RSS feed with this format:

    rss add name-of-feed https://url.of.feed.to-add

For example:

    rss add 7MS https://7ms.us/rss/
    
Then you can "announce" feed updates to channels by using:

    rss announce add #channel-name name-of-feed

So something like this should work:

    rss announce add #7ms 7ms

###Quotes database

####Add a quote

    !quote add #channel-name "Brothers don't shake hands. Brothers gotta hug." - Tommy Callahan, Tommy Boy (http://www.imdb.com/title/tt0114694/quotes)

###Success database
Things the bot can say when it successfully understands a command.

####Add a "success":

    !success add #channel-name "Got it.  You and I are on the same page."