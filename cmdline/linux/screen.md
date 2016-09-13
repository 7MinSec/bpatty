#Screen
"Screen is a console application that allows you to use multiple terminal sessions within one window. The program operates within a shell session and acts as a container and manager for other terminal sessions, similar to how a window manager manages windows."

Info here is heavily referenced from [this Digital Ocean support article](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-screen-on-an-ubuntu-cloud-server).  

##Start a new screen session
    screen -R name-of-session
    
Once you're running ssh or whatever you wanna leave running, hit `Ctrl+a d` to escape out of the screen session and leave it running.

To see all open *screen* sessions:

    screen -ls
    
If you had one called *bot* for example, you could reattach to it with:

    screen -R bot