#Sed
A stream editor.

I don't use `sed` a whole lot, but here are some examples where it really saved my butt.

#Delete sentences starting with "this" and ending with "that"

**TLDR**: In the 7 Minute Security [full episode guide](FILL-ME_IN-LATER-K_THANKS-BYE), I thought it would be a good idea to embed `<iframe>` links of MP3s for each episode.  That was *not* a good idea as if you try to load 200+ iframes on a single page, browsers tend to barf.  

*Aaaaanyway* I wanted a way to quickly go through my episode guide Markdown document and strip out all sentences starting with `<iframe>` and ending with `</iframe>`.  Here was the `sed` command to do just that:

    sed -e 's/\<iframe.*\>//' episodes.md > episodes2.md
    
#Doing a "rip and replace" of IPs in a file
For the [Tommy Boy](FILlllmeinlater) VM, I needed a Wordpress database to be updated with whatever IP the VM booted with.  To do that, I (ab)used the gracious help of one of [g0tmi1k](https://blog.g0tmi1k.com)'s scripts which queried the VM's lan IP with:

    lanip=$(ip addr | grep inet | grep -v '127.0.0.1' | cut -d"/" -f1 | awk '{print $2}' | head -n 1)
    
And then replaced it in a file by doing:

    sed "s/x\.x\.x\.x/${lanip}/g" input-file output-file



















