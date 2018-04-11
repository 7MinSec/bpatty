# LAPS-check_reloaded.ps1
# 04/11/18: fixed a bunch of stuff to make this simpler.
#
#
# First, make sure you've got LAPS up and running.  See this blog/podcast for a how-to:
# https://7ms.us/7ms-252-laps-local-administrator-password-solution/
#
# And see detailed install notes here:
# http://bpatty.rocks/#!blue_team/Local_Administrator_Password_Solution_LAPS.md
#
#
# First, check which machines have LAPS installed:
$YesLAPS = Get-ADComputer -filter {ms-mcs-admpwdexpirationtime -like '*'} -Properties 'ms-mcs-admpwd','ms-mcs-admpwdexpirationtime' | select dnshostname,ms-mcs-admpwd

# Check which machines DON'T have LAPS installed:
$NoLAPS = Get-ADComputer -filter {ms-mcs-admpwdexpirationtime -notlike '*'} -Properties 'ms-mcs-admpwd','ms-mcs-admpwdexpirationtime' | select dnshostname,ms-mcs-admpwd

# Write a new report
echo "============================================" > .\LAPS_report.txt
echo "=== These hosts do NOT have LAPS installed ==" >> .\LAPS_report.txt
echo "============================================" >> .\LAPS_report.txt
echo $NoLAPS >> .\LAPS_report.txt
echo "============================================" >> .\LAPS_report.txt
echo "=== These hosts DO have LAPS installed ==" >> .\LAPS_report.txt
echo "============================================" >> .\LAPS_report.txt
echo $YesLAPS >> .\LAPS_report.txt

# Pop open the report in Notepad
notepad .\LAPS_report.txt
