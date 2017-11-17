# Windows system commands

robocopy
--------
Sometimes I have trouble copying things from my local drive to the network shares.  I found out this has to do with virus scanning on the server - it kills one of the files on the fly and thus mucks up my file-copying efforts.  In cases like these I use Robocopy to do the job.  Example:

    robocopy "C:\Users\me\my-big-subfolder" "P:\destination" /e /r:3

* The `/e` is for all subfolders
* The `/r:3` is to only do 3 retries.  Otherwise, in the case of a file getting nuked by AV, I may get stuck in a loop where my machine tries again and again and again and again to copy it to the network drive.
