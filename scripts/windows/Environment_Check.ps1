################################################################################
#
# Environment-Check.ps1
#
# This script is designed to gather some helpful baseline information in an
# Active Directory environment.
# Run this on a DC, and a subfolder of today's date will be created and all
# info will be dumped in there.
#
################################################################################
#
# Versions
#
# No.  Date           Person
# 0.1  Mar 27, 2017   Brian Johnson (https://7ms.us)
# 0.2  Apr 05, 2017   Xoke (https://keybase.io/xoke)
# 0.3  Nov 08, 2017   Brian.  Added check for applied pw policy and tweaked
# 										the Search-ADAccount portion of the script
# 0.4  April 4, 2018	Brian.  Added some checks for locked out accounts and exporting
#											GPOs to XML as well as HTML
# 
################################################################################

# Set a variable of today using today's date
$Today = Get-Date -Format yyyy-MM-dd

#Create a directory with today's date
New-Item -ItemType Directory -Path ".\$((Get-Date).ToString('yyyy-MM-dd'))"

# Try to import the Active Directory module - we'll be making use of that
If(!(Get-Module -Name ActiveDirectory))
{
	Import-Module ActiveDirectory
}

# Try to import the GroupPolicy module - we'll need that too
If(!(Get-Module -Name GroupPolicy))
{
	Import-Module GroupPolicy
}

# Check if the modules loaded
If(!(Get-Module -Name ActiveDirectory) -or !(Get-Module -Name GroupPolicy))
{
    Echo "Failed to load required modules"
    Exit
}

# Check PowerShell version
Echo "Lets check PS version"
$PSVersionTable.PSVersion
$PSVersionTable.PSVersion > $Today\PowerShell_Version.txt

# Search for users with passwords that don't expire and dump to text file
Search-ADAccount -PasswordNeverExpires | Sort Name | FT Name,Enabled -A | Where-Object { $_.Enabled -eq $true } > $Today\Users_Passwords_Dont_Expire.txt

# Find disabled users and dump to text file
Search-ADAccount -AccountDisabled | Select SAMAccountname | Sort SAMAccountname > $Today\Users_Disabled.txt

# Find users who have never logged in, and dump to what?  A text file.
Search-ADAccount -AccountInactive -UsersOnly | Select SAMAccountname | Sort SAMAccountname > $Today\Users_Never_Logged_In.txt

# Get members of Domain Admins group...and plop into text file
Get-ADGroupMember "Domain Admins" | Select Name | Sort Name > $Today\Groups_Domain_Admins.txt

# Get members of Enterprise Admins group and export to .txt
Get-ADGroupMember "Enterprise Admins" | Select Name | Sort Name > $Today\Groups_Enterprise_Admins.txt

# Get members of Administrators group...in a text file
Get-ADGroupMember "Administrators" | Select Name | Sort Name > $Today\Groups_Admins.txt

# Get members of Schema Admins group....in a...text...file....
Get-ADGroupMember "Schema Admins" | Select Name | Sort Name > $Today\Groups_Schema_Admins.txt

# Get a list of locked out users
Search-ADAccount -LockedOut > $Today\Locked_Out_Users.txt

# Export default domain policy to HTML to...you know what?  I don't think I need to tell you what kind of file this dumps to
Get-ADDefaultDomainPasswordPolicy > $Today\GPO_Default_Domain.txt

# Retrieving password policy
Get-ADDefaultDomainPasswordPolicy > $Today\GPO_Password_Policy.txt

# Get the current password policy
net accounts > $Today\Local_Pw_Policy.txt

# Exporting all GPOs to html
Get-GPOReport -All -ReportType HTML -Path $Today\GPO_ALL.html

# Exporting all GPOs to xml
Get-GPOReport -All -ReportType xml -Path $Today\GPO_ALL.xml

# Get list of computers

Get-ADComputer -Properties * -Filter * | Export-csv -Path $Today\Computers_ALL.csv
Get-ADComputer -Filter "Enabled -eq '$true'" | Select -Expand Name | Sort-Object > $Today\Computers_Enabled_Shortlist.txt
Get-ADComputer -Filter "Enabled -eq '$false'" > $Today\Computers_Disabled.txt

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
# (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full'  -Name Release).Release
#
# Get installed .net for remote computer:
# Invoke-command -computer RemoteComputerName {(Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full'  -Name Release).Release}
