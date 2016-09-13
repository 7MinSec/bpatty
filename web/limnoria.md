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

###"Factoids"
You can add one with:

    !learn #channel-name tenaciousd is The greatest band on earth

Then when people type `!tenaciousd` they will get that response.

If you want an alternate descriptor, use the same command again with a different string, like:

    !learn #channel-name tenaciousd is The greatest band on earth.

To forget a factoid and all its various associations, use:

    !forget #channel-name tenaciousd * 

###"Dunno" commands
These are cheeky things your bot can say when a command isn't recognized.  Add them with:

    !dunno add #channel-name "You are not making sense."

###"News" database

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

###"Quotes" database

####Add a quote

    !quote add #channel-name "Brothers don't shake hands. Brothers gotta hug." - Tommy Callahan, Tommy Boy (http://www.imdb.com/title/tt0114694/quotes)

