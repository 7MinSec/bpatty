# Environment-check.ps1
# v0.1 - March 27, 2017
# by Brian Johnson (https://7ms.us)
#
# This script is designed to gather some helpful baseline information in an Active Directory environment.
# Run this on a DC, and a subfolder of today's date will be created and all info will be dumped in there.
#


#Create a directory with today's date
New-Item -ItemType Directory -Path ".\$((Get-Date).ToString('yyyy-MM-dd'))"

# Import the Active Directory module - we'll be making use of that
import-module activedirectory

# Import the GroupPolicy module - we'll need that too
import-module grouppolicy

# Set a variable of today using today's date
$today = Get-Date -Format yyyy-MM-dd

# Check PowerShell version
echo Lets check PS version
$PSVersionTable.PSVersion
$PSVersionTable.PSVersion > $today\powershell_version.txt

# Search for users with passwords that don't expire and dump to text file
search-adaccount -PasswordNeverExpires | FT Name,enabled -A > $today\Users_Passwords_Dont_Expire.txt

# Find disabled users and dump to text file
search-ADAccount -AccountDisabled | select samaccountname | sort samaccountname > $today\Users_Disabled.txt

# Find users who have never logged in, and dump to what?  A text file.
search-adaccount -accountinactive -usersonly | select samaccountname | sort samaccountname > $today\Users_Never_Logged_In.txt

# Get members of Domain Admins group...and plop into text file
get-adgroupmember "Domain Admins" | select name > $today\Groups_Domain_Admins.txt

# Get members of Enterprise Admins group and export to .txt 
get-adgroupmember "Enterprise Admins" | select name > $today\Groups_Enterprise_Admins.txt

# Get members of Administrators group...in a text file 
get-adgroupmember "Administrators" | select name > $today\Groups_Admins.txt

# Get members of Schema Admins group....in a...text...file....
get-adgroupmember "Schema Admins" | select name > $today\Groups_Schema_Admins.txt

# Export default domain policy to HTML to...you know what?  I don't think I need to tell you what kind of file this dumps to
Get-ADDefaultDomainPasswordPolicy > $today\GPO_Default_Domain.txt

# Retrieving password policy
Get-ADDefaultDomainPasswordPolicy > $today\GPO_Password_Policy.txt

# Exporting all GPOs to html
Get-GPOReport -All -ReportType HTML -Path $today\GPO_ALL.html

# Get list of computers
get-adcomputer -Properties * -Filter * | Export-csv -Path $today\Computers-ALL.csv
get-ADComputer -Filter "Enabled -eq '$true'" | select -Expand name | sort-object > $today\Computers_Enabled_Shortlist.txt
Get-ADComputer -Filter "Enabled -eq '$false'" > $today\Computers_Disabled.txt

# Under construction:
# Get hotfixes from all servers
# $servers =  get-content $today\Computers_Enabled_shortlist.txt
# foreach ($server in $servers)
# {Get-hotfix -ComputerName $server | select __server,hotfixid,description,installedon,installedby | sort installedon | convertto-csv | out-file $today\$server-hotfixes.csv}
# Get-WmiObject -Class Win32_Product -Computername $server | Select-Object -Property Name | Sort-Object Name > $today\$server-installed-programs.txt}
#
# The line below will retrieve installed .Net version for a local computer
# Check https://msdn.microsoft.com/en-us/library/hh925568(v=vs.110).aspx for the full list
# but here are a few important ones: 394271 is 4.6.1.  379893 is 4.5.2.  378758 is 4.5.1.  
# 
# (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full'  -Name Release).Release
#
# Get installed .net for remote computer:
# Invoke-command -computer RemoteComputerName {(Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full'  -Name Release).Release}
