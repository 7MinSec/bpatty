# scp

A few handy *scp* commands:

## Download folder full of files from a remote host to your local machine
Connect to a host over SCP, then download a root folder (and everything in it) called `/cap`:

    scp -r root@192.168.3.101:/cap .
    
## Upload a file to a remote host

	scp /my/local/file.txt root@destination:/folder/to/upload/to