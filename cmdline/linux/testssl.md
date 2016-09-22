#testssl
This is a great tool for conducting a series of TLS/SSL ciphers.

Go to [testssl.sh](https://testssl.sh) to grab the tool.  While you're there, grab [Aha](https://github.com/theZiz/aha) as that lets you pipe the output to an HTML file so you can preserve the output's colors - which is nice!  Here's an example for doing that:

First, make sure your "aha" gets compiled by doing this in the *aha* dir:

    make

Then, run your SSL test and pipe through *aha*:

    /opt/testssl/testssl.sh F.Q.D.N | /opt/aha/aha >OUTPUT.html

To test a bunch of hosts, you could make a `targets.txt` with something like:

    host1
    host2
    host3
    
Then scan 'em all at once with:

/opt/testssl/testssl.sh --file targets.txt | /opt/aha/aha > OUTPUT.html