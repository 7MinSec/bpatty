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
# - Let people pick any combination of tools to be run
# - Allow multiple IPs or a .txt of IPs to be loaded
#
# !/usr/bin/python
import time
import subprocess


def intro():
    print("\033[11;32;40m Hi and welcome to SSOTT = S.can S.ome O.f T.he T.hings! \n")
    print("v0000000000000000000000.1")
    print("I accept no responsibility for the mayhem that will ensue from you running this.")
    print('')


def yes_or_no(question):
    while "I don't get it... try again.":
        reply = str(raw_input(question + ' (y/n): ')).lower().strip()
        if reply[:1] == 'y':
            return True
        if reply[:1] == 'n':
            return False


def askrun():
    ip = raw_input("\033[1;37;40m What ip/FQDN do you wanna scan?: ")
    print('')
    print('')
    print(
            "Wait, are you serious?  I can't believe this.  You know what?  I was JUST thinking that " + ip + " would be, like, TOTALLY perfect to scan right now.")
    print('')
    print('')
    print('Rapid fire round...')
    runDirb = yes_or_no('Would you like to run Dirb during this scan?')
    runNikto = yes_or_no('How about Nikto?')
    runSslScan = yes_or_no('And SSLScan?')

    # check for libxml2-utils
    checkerCmd = "dpkg -l libxml2-utils"
    libChecker = subprocess.Popen(checkerCmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True)
    libCheckerOutput = libChecker.communicate()
    if libCheckerOutput[1] == "dpkg-query: no packages found matching libxml2-utils\n":
        installPackage = yes_or_no(
            "You don't have the libxml2-utils package installed, which is required in order to provide you with searchploit suggestions after the Nmap scan. Would you like me to install this package now?")
        if installPackage:
            subprocess.call("apt -y install libxml2-utils", shell=True)
            print("Sweet!")
        else:
            print("Got it, continuing without searchsploit...")

    startScans(ip, runDirb, runNikto, runSslScan)


def startScans(ip, runDirb, runNikto, runSslScan):
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
    print("Ok NMAP is done!!")
    # End NMAP scan

    if runNikto:
        print("Now moving on to NIKTO scan after this 5 second commercial break.")
        time.sleep(5)
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
        print("Ok Nikto is done!!")
        # Nikto HTTP done

    if runDirb:
        print("Now starting Dirb... after this 5 second nap.")
        time.sleep(5)
        print("Mmmmmkay. First up, the HTTP version of the site...")
        subprocess.call("dirb http://" + ip + " -o " + ip + "-dirb-80.txt", shell=True)
        time.sleep(5)
        print('')
        subprocess.call(
            "swaks --to me@mydomain.com --from 'alerts@somedomain.com' --server smtp.gmail.com:587 -tls --auth-user alerts@somedomain.com --auth-password 'SOMEPASSWORD' --body 'This is the body of the message' --header 'Subject: DIRB80 done for " + ip + "' --attach ./" + ip + "-dirb-80.txt",
            shell=True)
        print('*' * 30)
        print("Sweet!  That's done!  Now we'll dirb the HTTPS version!")
        time.sleep(5)
        subprocess.call("dirb https://" + ip + " -o " + ip + "-dirb-443.txt", shell=True)
        subprocess.call(
            "swaks --to me@mydomain.com --from 'alerts@somedomain.com' --server smtp.gmail.com:587 -tls --auth-user alerts@somedomain.com --auth-password 'SOMEPASSWORD' --body 'This is the body of the message' --header 'Subject: Nikto80 done for " + ip + "' --attach ./" + ip + "-dirb-443.txt",
            shell=True)
        print('*' * 30)
        print("Ok, Dirb complete!!")
        # Dirb HTTP done

    if runSslScan:
        # SSLScan start
        print("Now it's SSLScan time... but first, a 5-second nap.")
        time.sleep(5)
        subprocess.call("sslscan --nofailed --xml=" + ip + "-sslscan.xml " + ip, shell=True)
        subprocess.call(
            "swaks --to me@mydomain.com --from 'alerts@somedomain.com' --server smtp.gmail.com:587 -tls --auth-user alerts@somedomain.com --auth-password 'SOMEPASSWORD' --body 'This is the body of the message' --header 'Subject: SSLSCAN done for " + ip + "' --attach ./" + ip + "-sslscan.xml",
            shell=True)
        # SSLScan stop
        print('*' * 30)
        print("Awesome, SSLScan finished!")
        print('')

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
    intro()
    askrun()