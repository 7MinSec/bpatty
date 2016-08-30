# nmap
Port scanner + a zillion other things. Here's a great [cheat sheet](https://pentestlab.wordpress.com/2012/08/17/nmap-cheat-sheet/) to help you setup the most common kinds of scans.
 
## To scan multiple targets from a text file called targets.txt:

    nmap -p 80,443 -iL targets.txt
     
## Basic thorough scan
 
    -PE -PM -PS 21,22,23,25,26,53,80,81,110,111,113,135,139,143,179,199,443,445,465,514,548,554,587,993,995
    
## Using script engine

`--script`

Calls the scripting engine to do one of katrillions of things.
 
### http methods: 
 
`http-methods`
will show what http methods are available on a site such as track and trace.  Example:

    nmap -p 80,443 --script http-methods 1.2.3.4
 
This checks cert information, weak ciphers and SSLv2.

    nmap -p80,443 --script ssl-cert,ssl-enum-ciphers 1.2.3.4

### sql/mssql

This will poll the host for basic sql information:

    nmap f.q.d.n --script=ms-sql-info.nse 
    
 