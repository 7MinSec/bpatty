# Powershell
A collection of resources on using/abusing Powershell.

### Quick ref guide for stuff I commonly do

#### Downloading files
[This post](https://blog.jourdant.me/post/3-ways-to-download-files-with-powershell) offers "three methods for downloading files using PowerShell - weighed up with their pros and cons."

#### Execution policy
Use something like this to bypass ExecutionPolicy for single file:

`PowerShell.exe -ExecutionPolicy Bypass -File name-of-script.ps1`

#### Get-ADUserLastLogon
It's often helpful to be able to see when an account has last logged on.  The following snippet (taken from [this TechNet article](https://technet.microsoft.com/en-us/library/dd378867(v=ws.10).aspx)) has us create a module called *Import-Module* and then specify a username to look for:

    Import-Module ActiveDirectory

    function Get-ADUserLastLogon([string]$userName)
    {
      $dcs = Get-ADDomainController -Filter {Name -like "*"}
      $time = 0
      foreach($dc in $dcs)
      {
        $hostname = $dc.HostName
        $user = Get-ADUser $userName | Get-ADObject -Properties lastLogon
        if($user.LastLogon -gt $time)
        {
          $time = $user.LastLogon
        }
      }
      $dt = [DateTime]::FromFileTime($time)
      Write-Host $username "last logged on at:" $dt }
      Get-aduserlastlogon insert-username-here

    get-aduserlastlogon NAME-OF-USER

##### Get-Help
Guess what?  It gets help! If you're just jumping into Powershell, you might want to run a `update-help` to get the latest help info sucked down to your machine.

#### Get-Hotfix
This will help list/dump hotfix information from an installed machine.  Some examples:

`get-hotfix | export-csv c:\temp\hotfixes.csv`
Dumps a .CSV of all hotfixes installed on the machine.  Make sure to check the [privesc page](../../pentesting/netpen/privesc.md) as the host you're pentesting might be missing key patches that will give you an easy win!

`get-hotfix -id KB12345 -ComputerName SQL01`
This will search to see if KB12345 is installed on a computer called **SQL01**

#### Get-ItemProperty
Gets...you know...properties of an item.  One good use I've found for this is querying the version of .NET installed via:

`Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full`

You can do that remotely with this syntax:

`Invoke-command -computer RemoteComputerName {Get-ItemProperty HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\run}`

#### Get-WmiObject
Helps query machines for info about their OS, hardware, etc.

`Get-WmiObject win32_OperatingSystem -Computername SQL`
This will get the OS type from a computer called **SQL**.  Reference the [Wikipedia page](https://en.wikipedia.org/wiki/Comparison_of_Microsoft_Windows_versions) on MS software versions to match up your results.  For instance **5.2.3790** is Windows 2003, SP2.

### Training opportunities

* The SANS [PowerShell cheat sheet](https://pen-testing.sans.org/blog/2016/05/25/sans-powershell-cheat-sheet) rocks.
* [Basics of Powershell Logging](https://attendee.gotowebinar.com/register/7471153301583943939) was a Webinar put on by Carlos Perez in the fall of 2016.  You can see the recording of this session by registering for the GoToWebinar.

### Tools for pentesters

#### Autoruns
This [module](https://github.com/p0w3rsh3ll/AutoRuns) "was designed to help do live incident response and enumerate autoruns artifacts that may be used by legitimate programs as well as malware to achieve persistence."

#### DeepBlueCLI
Is a [PowerShell module](https://github.com/sans-blue-team/DeepBlueCLI) for hunt teaming via Windows event logs.

#### Empire
My write-up on Empire was getting lengthy, so I moved it to [its own page](../../pentesting/network_pentesting/empire.md).

#### Inveigh
Is a "Windows PowerShell LLMNR/NBNS spoofer/man-in-the-middle [tool](https://github.com/Kevin-Robertson/Inveigh)."

#### Mailsniper
Is a [PowerShell script](https://github.com/dafthack/MailSniper) developed by [Black Hills Information Security](http://www.blackhillsinfosec.com/?p=5296) to "search through email in a Microsoft Exchange environment for specific terms (passwords, insider intel, network architecture information, etc.). It can be used as a non-administrative user to search their own email, or by an Exchange administrator to search the mailboxes of every user in a domain."

#### PowerSploit
Is a "[collection of Microsoft PowerShell modules](https://github.com/PowerShellMafia/PowerSploit) that can be used to aid penetration testers during all phases of an assessment."

#### PowerUpSQL
Is a "PowerShell [toolkit](https://github.com/NetSPI/PowerUpSQL) for attacking SQL server."  Check out the [wiki](https://github.com/NetSPI/PowerUpSQL/wiki) as well.

#### PowerPath
Is on [Github](https://github.com/andyrobbins/PowerPath) and, according to [this post](https://wald0.com/?p=68), combines several scripts and techniques to "prove that it is possible to automate Active Directory domain privilege escalation analysis."

#### PowerShell Suite
Is [here](https://github.com/FuzzySecurity/PowerShell-Suite) and advertises itself as "There are great tools and resources online to accomplish most any task in PowerShell, sometimes however, there is a need to script together a util for a specific purpose or to bridge an ontological gap. This is a collection of PowerShell utilities I put together either for fun or because I had a narrow application in mind."

#### PSAttack
[PSAttack](https://github.com/jaredhaight/PSAttack) states it is "A portable console aimed at making pentesting with PowerShell a little easier."
