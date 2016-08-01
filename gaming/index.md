#Gaming
Install scripts/tips/etc. for various games

##Minecraft
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

pico *server.properties* to tweak the server

