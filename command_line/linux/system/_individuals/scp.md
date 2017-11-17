# scp

A few handy *scp* commands:

## Download folder full of files from a remote host to your local machine
Connect to a host over SCP, then download a root folder (and everything in it) called `/cap`:

    scp -r root@192.168.3.101:/path/to/folder-you/want-to/download .
    
    
## Download a folder full of files over reverse ssh connection

For example, if you're using a PwnPulse and have a reverse shell bound to port 3333, you can SCP directly to the Pulse with:

    scp -r -P 3333 root@192.168.3.101:/folder-you-want-to-download .


    
## Upload a file to a remote host

	scp /my/local/file.txt root@destination:/the/folder/to/upload/to