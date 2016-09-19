#Docker
How to get it up and running in Ubuntu 16.04.  

##Install Docker
    apt-get install docker.io

Simple, yeah?
    
##Install Rainmap
I heard about this from [Jerry Gamblin's blog](http://jerrygamblin.com/2016/08/30/rainmap-container/) - it's basically a slick Web interface for [nmap](../cmdline/linux/nmap.md).

Head to [https://hub.docker.com/r/jgamblin/rainmap/](https://hub.docker.com/r/jgamblin/rainmap/) for instructions, but it basically boils down to installing the docker with:

    docker pull jgamblin/rainmap

###Run it
Since rainmap stays "open" in the command line, I recommend you first use [screen](../cmdline/linux/screen.md) to setup a special session for it.  That way you can completely log out via SSH and the docker will stay running.

    screen -R rainmapscreen
    
With the new screen created, you can run rainmap and follow the prompts:

    docker run -ti -p 8080:8080 --name rainmap jgamblin/rainmap
    
Now, just hit `Ctrl+a d` to exit the screen session, and go to `http://ip.of.your.docker:8080/console` to login!

###Run it (again)
After doing a `Ctrl+C` to stop the Web interface, if you run the same `docker` command to start the docker again, you might get this:

>docker: Error response from daemon: Conflict. The name "/rainmap" is already in use by container eeecfa0ff3f58a4ed67a4fa045beae462a49fb7d9df9a30c0f259f90c1684d59. You have to remove (or rename) that container to be able to reuse that name..

You can remove it with:

    docker rm rainmap 

Then start it again with:

    docker run -ti -p 8080:8080 --name rainmap jgamblin/rainmap
    
##Install Juice-Shop
Juice Shop, according to [OWASP](https://www.owasp.org/index.php/OWASP_Juice_Shop_Project) is "an intentionally insecure webapp for security trainings written entirely in Javascript which encompasses the entire OWASP Top Ten and other severe security flaws."

    docker pull bkimminich/juice-shop
    
###Run it

    docker run -d -p 3000:3000 bkimminich/juice-shop
    
    