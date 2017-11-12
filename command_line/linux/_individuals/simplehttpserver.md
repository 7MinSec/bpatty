# SimpleHTTPServer
Starts up a HTTP server on port 8000 in whatever directory you run the command from:
 
    python -m SimpleHTTPServer

If the server you've got a shell on won't allow outbound connections to ports like *8000* you can specify a different outbound port with:

    python -m SimpleHTTPServer 80
