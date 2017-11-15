# asciinema
Creates ascii "movies" that record keystrokes and output (good for when you're doing a lot of command line work and want to have log of it later).
 
To install:
 
    curl -sL https://asciinema.org/install | sh
 
To begin a recording while eliminating any gaps in time over 1 second and saving the file to FILENAME:
 
    asciinema rec -w 1 -t "My title" NAME-OF-FILE
 
To play the file back:
 
    asciinema  -play FILENAME