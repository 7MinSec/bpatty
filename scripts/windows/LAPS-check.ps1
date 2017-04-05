# LAPS-check.ps1
# by Brian Johnson (https://7ms.us)
#
# I'm writing up a guide to install Microsoft Local Administrator Password Solution, and I'm finding that
# for whatever reason, some clients (*cough*WINDOWS EIGHT*cough*) aren't installing the .msi gracefully
# via GPO.  
# 
# So, I'm creating this PS script to crawl an AD for active computers and then querying them for the presence of
# C:\Program Files\LAPS or C:\Program Files (x86)\LAPS which would indicate LAPS is installed successfully.

# Clear the today variable, you know...just in case.
Clear-Variable today -ErrorAction SilentlyContinue

# Set variable of "today" to, well, today
$today = Get-Date -Format yyyy-MM-dd

# Create a working directory with today's date.  If it exists, big whoop.  Ignore it.
New-Item -ItemType Directory -Path ".\$((Get-Date).ToSTring('yyyy-MM-dd'))" -ErrorAction SilentlyContinue

# Setting today's date to variable "d"
$d = Get-Date

# Import ActiveDirectory module
Import-Module ActiveDirectory

# Not sure if I need GP module, so disabling for now
# Import-Module GroupPolicy

# Pull list of enabled computers from AD, dump to .txt file
Get-ADComputer -filter "enabled -eq '$true'" | select -Expand name | sort-object > $today\AllComputers.txt

# Setting a variable of "servers" to be the list we will soon pull from AD.
$servers = Get-Content $today\AllComputers.txt

# Remove the list of pingable machines in case this is a repeat run
Remove-Item $today\LAPS-PingCheck.csv -ErrorAction SilentlyContinue

# Add a starter row to the pingable list of machines CSV
Add-Content $today\LAPS-PingCheck.csv "Hostname,Status,Date and time checked"

# This is the loop that checks each system for pingability
foreach ($server in $servers){
  if (Test-Connection -computer $server -count 2 -ErrorAction SilentlyContinue){
     Add-Content $today\LAPS-pingcheck.csv "$server,up,$d"   
  }
  else{
     Add-Content $today\LAPS-pingcheck.csv "$server,down,$d"
  }
}


# Now we'll import that list of pingable machines and sort them into a list called LAPS-LiveHosts
Import-Csv "$today\LAPS-pingcheck.csv"| where-object {$_.Status -eq "up"} | select -Expand Hostname | sort-object > $today\LAPS-LiveHosts.txt

# Now we'll make a csv that checks if the LAPS path exists.  We'll remove any existing ones first...
Remove-Item $today\LAPS-PathCheck.csv -ErrorAction SilentlyContinue
Add-Content $today\LAPS-PathCheck.csv "Hostname,32-bit LAPS,64-bit LAPS,Installed Progs,Date and time"

# The "livehosts" will be a list of hosts that respond to a ping
$livehosts = Get-Content $today\LAPS-LiveHosts.txt

# Lets loop through and check each host for 32-bit LAPS
foreach ($livehost in $livehosts)
{

     if ( (Test-Path -Path "\\$livehost\c$\Program Files (x86)\LAPS") -eq $True)
          {Add-Content $today\LAPS-PathCheck.csv "$livehost,Yes,,,$d"}
     else 
          {Add-Content $today\LAPS-PathCheck.csv "$livehost,No,,,$d"}
}

# And lets also check for 64-bit LAPS
foreach ($livehost in $livehosts)
{

     if (Test-Path -Path "\\$livehost\c$\Program Files\LAPS") 
          {Add-Content $today\LAPS-PathCheck.csv "$livehost,,Yes,,$d"}
     else 
          {Add-Content $today\LAPS-PathCheck.csv "$livehost,,No,,$d"}
}

foreach ($livehost in $livehosts)
{
if ( (Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | select DisplayName | sls VMWare) -Match "345VMWare")
           {Add-Content $today\LAPS-PathCheck.csv "$livehost,NA,NA,Yes,$d"}
     else 
          {Add-Content $today\LAPS-PathCheck.csv "$livehost,NA,NA,No,$d"}

}

# Finally, make a nice organized list of the path checks, sorted by host name
Remove-Item $today\LAPS-PathCheck-Sorted.csv -ErrorAction SilentlyContinue
Import-Csv $today\LAPS-PathCheck.csv | sort hostname | Export-Csv -Path $today\LAPS-PathCheck-Sorted.csv
