# zip
I always forget how to zip up a whole folder while password-protecting it, but this'll do it!

    zip -er name-of-your.zip name-of-dir-to-be-zipped
     
To break it down, this zips and encrypts a .zip file of folder named **name-of-dir-to-be-zipped**

* `-e` enables encryption for your zip file. This is what makes it ask for the password.

* `-r` makes the command recursive, meaning that all the files inside the folder will be added to the zip file.

* `name-of-your.zip` is the name of the output file.

* `name-of-dir-to-be-zipped` is the folder you want to zip.