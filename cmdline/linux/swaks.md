# swaks
Is an awesome cmd-line email client.  Install with `apt-get install swaks` and then you could use something like the command below to alert you any time a server boots:

    swaks --to you@yourdomain.com --from "someemail@someplace.com" --server smtp.gmail.com:587 -tls --auth-user someemail@someplace.com --auth-password 'YOURPASSWORDGOESHERE' --header "Subject: SERVER X JUST BOOTED!" --body 'This is the body of the message dude!' --attach /tmp/somefile.txt
