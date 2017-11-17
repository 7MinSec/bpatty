# openssl

Command line utility to test for various SSL configs and vulns.  A great resource I've found for this is [Explore Security's SSL manual cheatsheet](http://www.exploresecurity.com/wp-content/uploads/custom/SSL_manual_cheatsheet.html).

To test for RC4 ciphers (yep, I still have to do that quite a bit!):

`openssl s_client -cipher RC4 -connect site:port`
