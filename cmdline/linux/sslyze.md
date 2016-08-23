#sslyze
https://code.google.com/p/sslyze/wiki/QuickStart

    sslyze --sslv2 --slv3 --tlsv1 --tlsv1_2 --tlsv1_1 --hide_rejected_ciphers f.q.d.n
 
From the manual:

    python sslyze.py --regular www.target1.com

This is what you'll want to use most of the time. It performs a regular HTTP scan. It's a shortcut for `--sslv2` `--sslv3` `--tlsv1` `--reneg` `--resum` `--certinfo=basic` `--hide_rejected_ciphers` `--http_get`.

Options:

*OpenSSL Cipher Suites*

`--sslv2 --sslv3 --tlsv1` : Lists the SSL 2.0, 3.0 and TLS 1.0 OpenSSL cipher suites supported by the server.

`--tlsv1_1 --tlsv1_2` : Lists the TLS 1.1 and 1.2 OpenSSL cipher suites supported by the server. Requires OpenSSL 1.0.1 or later.

`--http_get` : Option - For each cipher suite, sends an HTTP GET request after completing the SSL handshake and returns the HTTP status code.

`--hide_rejected_ciphers` : Option - Hides the (usually long) list of cipher suites that were rejected by the server.

*Session Renegotiation*

`--reneg` : Checks whether the server is vulnerable to insecure renegotiation. Requires OpenSSL 0.9.8m or later.

Session Resumption
`--resum` : Tests the server for session resumption support, using both session IDs and TLS session tickets (RFC 5077).

`--resum_rate` : Estimates the average rate of successful session resumptions by performing 100 session resumptions.

*Server Certificate*

`--certinfo=basic` : Verifies the server's certificate validity against Mozilla's trusted root store, and prints relevant fields of the certificate.
