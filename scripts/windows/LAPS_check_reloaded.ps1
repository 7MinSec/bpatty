# LAPS-check_reloaded.ps1
# Updated April 4, 2018.  Basically I was making this WAY too hard.  Now it's simpler :-)
#
# First, make sure you've got LAPS up and running.  See this blog/podcast for a how-to:
# https://7ms.us/7ms-252-laps-local-administrator-password-solution/
#
#
# Check which machines have LAPS installed:
Get-ADComputer -filter {ms-mcs-admpwdexpirationtime -like '*'} -Properties 'ms-mcs-admpwd','ms-mcs-admpwdexpirationtime' | select dnshostname,ms-mcs-admpwd > .\LAPS-yes.txt

# Check which machines DON'T have LAPS installed:
Get-ADComputer -filter {ms-mcs-admpwdexpirationtime -like '*'} -Properties 'ms-mcs-admpwd','ms-mcs-admpwdexpirationtime' | select dnshostname,ms-mcs-admpwd > .\LAPS-no.txt

# Now we can compare the two files to find where LAPS is not deployed:
Compare-Object -ReferenceObject (Get-Content .\LAPS-yes.txt) -DifferenceObject (Get-Content .\LAPS-no.txt) | where sideindicator -eq "=>" | select inputobject > .\LAPS-needed-report.txt
