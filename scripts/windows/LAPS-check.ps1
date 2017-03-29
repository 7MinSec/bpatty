# LAPS-check.ps1
# v0.1 - March 29, 2017
# by Brian Johnson (https://7ms.us)
#
# I'm writing up a guide to install Microsoft Local Administrator Password Solution, and I'm finding that
# for whatever reason, some clients (*cough*WINDOWS EIGHT*cough*) aren't installing the .msi gracefully
# via GPO.  
# 
# So, I'm creating this PS script to crawl an AD for active computers and then querying them for the presence of
# C:\Program Files\LAPS or C:\Program Files (x86)\LAPS which would indicate LAPS is installed successfully.
#
#
get-ADComputer -Filter "Enabled -eq '$true'" | select -Expand name | sort-object > Computers_Enabled.txt
$servers = get-content Computers_Enabled.txt
foreach ($server in $servers)
