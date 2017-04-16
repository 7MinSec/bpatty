# Service_Account_Seeker
# v0.1 - Brian Johnson, https://7ms.us
#
# Q: What is this? 
# A: A script to enumerate Windows servers out of Active Directory, 
# ping them to ensure uptime, and capture details about each service account in use.
#
# Q: What are pre-reqs?
# A: This runs best from a machine with Powershell 3 or greater.  You can run this
# command to determine which PS is installed: $PSVersionTable.PSVersion
#
# If Powershell 2 is installed the fail will script on "-Append" commands because "Append"
# is only supported in PS 3 or greater.  See below for an alternate code block you can swap
# in to make this script run in PS2.
#
# Q: Where should I run this?
# A: Run from a domain controller.
#
Write-Host "Ok, lets do this!" -ForegroundColor "green"
Write-Host "`n"
Write-host "`n"

Write-Host "Importing Active Directory module" -ForegroundColor "Green"
Write-host "`n"
Write-host "`n"

Import-Module ActiveDirectory
Write-Host "DONE! That was easy." -ForegroundColor "Green"
Write-Host "`n"
Write-Host "Now, lets scrape AD for all machines with Windows server operating systems" -ForegroundColor "Green"
Write-host "`n"

# The Get-ADComputer statement below gets all Windows servers.  The line below that is commented
# out but will grab accounts from ALL machines, so tweak as you see fit.
Get-ADComputer -Filter {OperatingSystem -Like "Windows Server*"} | select -Expand name | sort-object > .\servers.txt
#Get-ADComputer -Filter {OperatingSystem -Like "*"} | select -Expand name | sort-object > .\servers.txt
$servers = Get-Content .\servers.txt

Write-Host "DONE! Easy-peasy." -ForegroundColor "Green"
Write-Host "`n"
Write-Host "Now we'll delete the .CSV called Service_Accounts.csv if it exists" -ForegroundColor "Green"
Write-Host "`n"

$ServerCSVFile = ".\Service_Accounts.csv"
if (Test-Path $ServerCSVFile){
    Remove-Item $ServerCSVFile
}

Write-Host "Ok, now we'll send a few pings to each server to find the *live* ones," -Foregroundcolor Green
Write-Host "then dump those into a CSV file called Service_Accounts.csv." -Foregroundcolor Green
Write-Host "This might take a while.  Grab a coffee.  Or 10." -ForegroundColor Green

foreach ($server in $servers)
{
if (Test-Connection -computer $server -count 2 -ErrorAction SilentlyContinue){
	if ($PSVersionTable.PSVersion.Major -gt 2) {
		Get-WmiObject win32_service -ComputerName $server | select-object __SERVER, name, startname, startmode | Export-Csv -Append -Path .\Service_Accounts.csv
	}
	else {
		Get-WmiObject win32_service -ComputerName $server | select-object name, startname, startmode, __SERVER | Export-Csv -Path .\Services_$SERVER.tmp
	}
}
else{}
}
if ($PSVersionTable.PSVersion.Major -le 2 ) {
	copy *.tmp Service_Accounts.csv
	del /f *.tmp
}

Write-Host "`n"
Write-Host "Done.  Service_Accounts.csv created.  Thanks for playing." -ForegroundColor Green
Write-Host "`n"
