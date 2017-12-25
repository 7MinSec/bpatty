# S.S.O.T.T = Scan SOME of the Things
# by @7MinSec
# v0.1
#
# This script was created because:
# * I don't know Python.
# * I wanna know Python.
# * I had a ton of IPs I was going to
#   do a select bit of scanning with.
# * I wanted to automate that.
#
# So this script does that stuff.
#
# Other things I want to do:
# - Have this script see if libxml2-util is installed (Searchsploit needs it and asks for it via 'apt -y install libxml2-utils')
# - Let people pick any combination of tools to be run
# - Allow multiple IPs or a .txt of IPs to be loaded
#
# !/usr/bin/python
import time
import subprocess


def askReDirb():
    yes = {'yes', 'y', 'ye', ''}
    no = {'no', 'n'}

    choice = raw_input().lower()
    if choice in yes:
        print('')
        print('')
        print('Wise choice! We\'ll run DIRB last.')
        startScan(True)
    elif choice in no:
        print('')
        print('')
        print('Ok... That\'s cool I guess... No dirb. :/')
        startScan(False)
    else:
        print("Please respond with 'yes' or 'no'")
        askReDirb()


def startScan(dirbSwitch):
    # Begin NMAP scan
    subprocess.call(
        "swaks --to me@mydomain.com --from 'alerts@somedomain.com' --server smtp.gmail.com:587 -tls --auth-user alerts@somedomain.com --auth-password 'SOMEPASSWORD' --body 'This is the body of the message' --header 'Subject: Scan started for " + ip + "'",
        shell=True)
    print("Ok, so first step is we're going to do an nmap scan of " + ip + "!  Here we gooooo...")
    time.sleep(5)
    print('')
    subprocess.call("nmap -n -O -Pn -sS -p- -sV -v -oX " + ip + "-nmap.xml " + ip, shell=True)
    subprocess.call("searchsploit --nmap " + ip + "-nmap.xml > " + ip + "-searchsploit.txt", shell=True)
    print('')
    print('*' * 30)
    subprocess.call(
        "swaks --to me@mydomain.com --from 'alerts@somedomain.com' --server smtp.gmail.com:587 -tls --auth-user alerts@somedomain.com --auth-password 'SOMEPASSWORD' --body 'This is the body of the message' --header 'Subject: NMAP done for " + ip + "' --attach ./" + ip + "-nmap.xml --attach ./" + ip + "-searchsploit.txt",
        shell=True)
    print('')
    print("Ok NMAP is done!!  Now moving on to NIKTO scan after this 5 second commercial break.")
    time.sleep(5)
    # End NMAP scan

    # Nikto HTTP/HTTPS start
    print('')
    subprocess.call(
        "nikto -h " + ip + " -p 80,443 -Display V -F htm -output " + ip + "-nikto.html -config /etc/nikto.conf",
        shell=True)
    print('')
    subprocess.call(
        "swaks --to me@mydomain.com --from 'alerts@somedomain.com' --server smtp.gmail.com:587 -tls --auth-user alerts@somedomain.com --auth-password 'SOMEPASSWORD' --body 'This is the body of the message' --header 'Subject: Nikto HTTP done for " + ip + "' --attach ./" + ip + "-nikto.html",
        shell=True)
    print('*' * 30)
    time.sleep(5)
    # Nikto HTTP done

    # SSLScan start
    print("Awesome!")
    print("Yahooooooooo!!")
    print("Lets take a quick break, and then we'll SSLSCAN this bad boy or girl...")
    time.sleep(5)
    subprocess.call("sslscan --nofailed --xml=" + ip + "-sslscan.xml " + ip, shell=True)
    subprocess.call(
        "swaks --to me@mydomain.com --from 'alerts@somedomain.com' --server smtp.gmail.com:587 -tls --auth-user alerts@somedomain.com --auth-password 'SOMEPASSWORD' --body 'This is the body of the message' --header 'Subject: SSLSCAN done for " + ip + "' --attach ./" + ip + "-sslscan.xml",
        shell=True)
    # SSLScan stop
    print('*' * 30)
    print('')

    if dirbSwitch:
        # Dirb80
        # start
        print("Mmmmmkay.  Now the last thing to do is to DIRB the site.  First up, the HTTP version of the site...")
        subprocess.call("dirb http://" + ip + " -o " + ip + "-dirb-80.txt", shell=True)
        time.sleep(5)
        print('')
        subprocess.call(
            "swaks --to me@mydomain.com --from 'alerts@somedomain.com' --server smtp.gmail.com:587 -tls --auth-user alerts@somedomain.com --auth-password 'SOMEPASSWORD' --body 'This is the body of the message' --header 'Subject: DIRB80 done for " + ip + "' --attach ./" + ip + "-dirb-80.txt",
            shell=True)
        print('*' * 30)
        # Dirb80
        # done

        # Dirb443
        # start
        print("Sweet!  That's done!  Now we'll dirb the HTTPS version!")
        time.sleep(5)
        subprocess.call("dirb https://" + ip + " -o " + ip + "-dirb-443.txt", shell=True)
        subprocess.call(
            "swaks --to me@mydomain.com --from 'alerts@somedomain.com' --server smtp.gmail.com:587 -tls --auth-user alerts@somedomain.com --auth-password 'SOMEPASSWORD' --body 'This is the body of the message' --header 'Subject: Nikto80 done for " + ip + "' --attach ./" + ip + "-dirb-443.txt",
            shell=True)
        print('*' * 30)
        # Dirb443
        # done

    print("And we're done! Wait while I pretend to do something advanced like think real hard or clean up files!")
    time.sleep(6)
    print("We'll zip everything up now...")
    subprocess.call("zip " + ip + ".zip " + ip + "-*", shell=True)
    print("And now we'll email it off to ya.")
    subprocess.call(
        "swaks --to me@mydomain.com --from 'alerts@somedomain.com' --server smtp.gmail.com:587 -tls --auth-user alerts@somedomain.com --auth-password 'SOMEPASSWORD' --body 'This is the body of the message' --header 'Subject: ALLlLlLlLLLL done for " + ip + "' --attach ./" + ip + ".zip",
        shell=True)
    print("Aaaaaaaand I'm spent.")


if __name__ == '__main__':
    print("\033[11;32;40m Hi and welcome to SSOTT = S.can S.ome O.f T.he T.hings! \n")
    print("v0000000000000000000000.1")
    print("I accept no responsibility for the mayhem that will ensue from you running this.")
    print('')
    ip = raw_input("\033[1;37;40m What ip/FQDN do you wanna scan?: ")
    print('')
    print('')
    print(
            "Wait, are you serious?  I can't believe this.  You know what?  I was JUST thinking that " + ip + " would be, like, TOTALLY perfect to scan right now.")
    print('')
    print('')
    print("Quick question though... did you want to run DIRB during this scan? [y/N]: ")
    askReDirb()
