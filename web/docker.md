#Docker
How to get it up and running in Ubuntu 16.04.  

##Install Docker
    apt-get install docker.io

Simple, yeah?

###Some quick reference docker commands:
* Export a docker to a .tar file: `docker save NAME > /tmp/NAME.tar`
* Exec a command on a docker image: `docker exec -t -i abcd(HUGE LONG STRING)3fsdfslifjsdlifsjdfsdlf cat /etc/passwd`
   
#Install some cool docker thingies!
* [Juice Shop](#juiceshop)
* [Rainmap](#rainmap)
* [Quassel](#quassel)

<a id="juiceshop"></a>
##Install Juice-Shop
Juice Shop, according to [OWASP](https://www.owasp.org/index.php/OWASP_Juice_Shop_Project) is "an intentionally insecure webapp for security trainings written entirely in Javascript which encompasses the entire OWASP Top Ten and other severe security flaws."

    docker pull bkimminich/juice-shop
    
###Run it

    docker run -d -p 3000:3000 bkimminich/juice-shop
    
###Make images/backups

One thing I found during my hacking of Juice Shop was that my brute-force or sqlmap efforts would cause the container to die, and thus I'd have to restarted, which wiped out my scoreboard.  Using [this site](https://gist.github.com/thaJeztah/8d0e901bd21329d80cf2) (h/t hackern0v1c3 on IRC) taking a point-in time snapshot is pretty easy:

    docker commit --message="This is the description of my snapshot" 130s9df83js09d a_short_description:093016
    
The `130s...` is the id of the container you want to make an image of.

<a id="rainmap"></a>
##Install Rainmap
I heard about this from [Jerry Gamblin's blog](http://jerrygamblin.com/2016/08/30/rainmap-container/) - it's basically a slick Web interface for [nmap](../cmdline/linux/nmap.md).

Head to [https://hub.docker.com/r/jgamblin/rainmap/](https://hub.docker.com/r/jgamblin/rainmap/) for instructions, but it basically boils down to installing the docker with:

    docker pull jgamblin/rainmap

###Run it

    docker run -ti -p 8080:8080 --name rainmap jgamblin/rainmap

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
    
<a id="quassel"></a>

##Install Quassel
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

###Install Lets Encrypt SSL cert on Quassel core

Install LetsEncrypt with

	sudo apt-get install letsencrypt

Then generate a cert for the FQDN of your Quassel core.  Example:

	sudo letsencrypt certonly --standalone -d quassel.mydomaian.com

Make sure LetsEncrypt servers can hit your Quassel core via:

	sudo iptables -A INPUT -p tcp --dport 443 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT

Then incorporate your LetsEncrypt cert into Quassel.  I followed [this site] (https://github.com/joelpet/docker-quassel-irc/commit/b1c2341e460d9dfb95c9e16c3e0323734b598a8e) which said to basically `cat` the two LetsEncrypt .pem files into a `quasselCert.pem` file:

	cat .../privkey.pem .../fullchain.pem > /full/path/to/wherever/you/find/quasselCert.pem

Then script your LetsEncrypt auto-renewal by following [this](http://hackernovice.com/2016/10/10/lets-encrypt-renewal/).