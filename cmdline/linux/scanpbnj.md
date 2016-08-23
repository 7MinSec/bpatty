#scanpbnj
Scanpbnj is a great way to leverage nmap to make a scanning point in time snapshot.  Then you can run the same scanpbnj scan again and see the diffs that come out of the scan.  Get the tool info [here](https://www.aldeid.com/wiki/ScanPBNJ).  There's also a great help reference I use [here](http://spl0it.org/files/PBNJ-sysadmin-article-feb07.html).  

To install:

    sudo apt-get install pbnj

If you have problems running the tool after installing it, you might have to also install libperl shell with:

    apt-get install libshell-perl

Here's kind of my go-to command for using scanpbnj:

    scanpbnj -i targets.txt -a '-PE -PM -PS -sTU --top-ports 1000'

You could certainly add the `V` to `sTUV` to get versioning information but I'm not as concerned about that when I'm just trying to spot what ports/services change between scans.
