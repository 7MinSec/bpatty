#Powershell
A collection of resources on using/abusing Powershell.

Quick references:

* The SANS [PowerShell cheat sheet](https://pen-testing.sans.org/blog/2016/05/25/sans-powershell-cheat-sheet) rocks.

#Command line basics

`get-help` - guess what?  It gets help! If you're just jumping into Powershell, you might want to run a `update-help` to get the latest help info sucked down to your machine.

`get-hotfix | export-csv c:\temp\hotfixes.csv` - dumps a .CSV of all hotfixes installed on the machine.  Make sure to check the [privesc page](../../pentesting/netpen/privesc.md) as the host you're pentesting might be missing key patches that will give you an easy win!

More to come...

#Tools for pentesters

##Autoruns
This [module](https://github.com/p0w3rsh3ll/AutoRuns) "was designed to help do live incident response and enumerate autoruns artifacts that may be used by legitimate programs as well as malware to achieve persistence."

##DeepBlueCLI
Is a [PowerShell module](https://github.com/sans-blue-team/DeepBlueCLI) for hunt teaming via Windows event logs.

##Empire
My write-up on Empire was getting lengthy, so I moved it to [its own page](../../pentesting/netpen/empire.md).

##Inveigh
Is a "Windows PowerShell LLMNR/NBNS spoofer/man-in-the-middle [tool](https://github.com/Kevin-Robertson/Inveigh)."

##Mailsniper
Is a [PowerShell script](https://github.com/dafthack/MailSniper) developed by [Black Hills Information Security](http://www.blackhillsinfosec.com/?p=5296) to "search through email in a Microsoft Exchange environment for specific terms (passwords, insider intel, network architecture information, etc.). It can be used as a non-administrative user to search their own email, or by an Exchange administrator to search the mailboxes of every user in a domain."

##PowerSploit
Is a "[collection of Microsoft PowerShell modules](https://github.com/PowerShellMafia/PowerSploit) that can be used to aid penetration testers during all phases of an assessment."

##PowerUpSQL
Is a "PowerShell [toolkit](https://github.com/NetSPI/PowerUpSQL) for attacking SQL server."  Check out the [wiki](https://github.com/NetSPI/PowerUpSQL/wiki) as well.

##PowerPath
Is on [Github](https://github.com/andyrobbins/PowerPath) and, according to [this post](https://wald0.com/?p=68), combines several scripts and techniques to "prove that it is possible to automate Active Directory domain privilege escalation analysis."

##PowerShell Suite
Is [here](https://github.com/FuzzySecurity/PowerShell-Suite) and advertises itself as "There are great tools and resources online to accomplish most any task in PowerShell, sometimes however, there is a need to script together a util for a specific purpose or to bridge an ontological gap. This is a collection of PowerShell utilities I put together either for fun or because I had a narrow application in mind."

---
#Additional things to add:
* Veil
* More "basic" command line stuff