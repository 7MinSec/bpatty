# LAPS-check_reloaded.ps1
# 04/11/18: fixed a bunch of stuff to make this simpler.
# Wish list: a single output with a "has LAPS" and "doesn't have LAPS" column
#
#
# First, make sure you've got LAPS up and running.  See this blog/podcast for a how-to:
# https://7ms.us/7ms-252-laps-local-administrator-password-solution/
#
# And see detailed install notes at http://bpatty.rocks/#!pentesting/blue_team/Local_Administrator_Password_Solution_LAPS.md
#
#
# First, check which machines have LAPS installed:
Get-ADComputer -filter {ms-mcs-admpwdexpirationtime -like '*'} -Properties 'ms-mcs-admpwd','ms-mcs-admpwdexpirationtime' | select dnshostname,ms-mcs-admpwd > .\LAPS-yes.txt

# Check which machines DON'T have LAPS installed:
Get-ADComputer -filter {ms-mcs-admpwdexpirationtime -notlike '*'} -Properties 'ms-mcs-admpwd','ms-mcs-admpwdexpirationtime' | select dnshostname,ms-mcs-admpwd > .\LAPS-no.txt

# Now we can compare the two files to find where LAPS is not deployed:
Compare-Object -ReferenceObject (Get-Content .\LAPS-yes.txt) -DifferenceObject (Get-Content .\LAPS-no.txt) | where sideindicator -eq "=>" | select inputobject > .\LAPS-report.txt

# Open the report to show which machines don't have LAPS
notepad LAPS-report.txt
