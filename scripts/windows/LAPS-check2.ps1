# LAPS-check2.ps1
#
# This is a second stab at making it a bit easier to figure out whether LAPS is deployed in your
# environment or not.  
# 
# First, make sure you've got LAPS up and running.  See this blog/podcast for a how-to:
# https://7ms.us/7ms-252-laps-local-administrator-password-solution/
#
# Once you've got LAPS installed on a bunch of machines, you can use the following script to query
# workstations for their local Administrator password, which will be an easy indicator that the LAPS
# GPOs are installed and working properly on the target machines
# 
#

# First we'll import the admpws.ps.  If you get an error on this step, you need to make sure you
# run the LAPS.x64/LAPS.x86 MSI (whichever is appropriate) and then install the 
# Management Tools > PowerShell Module option.
Import-Modle AdmPwd.ps

# Now import the Active Directory module
Import-Module ActiveDirectory

# Next we'll pull all non-server AD objects and make a simple list of them called "workstations.txt"
Get-ADComputer -Filter {OperatingSystem -NotLike "Windows Server*"} | select -Expand name | sort-object > .\workstations.txt

# The workstations.txt will now be slurped into a variable called $workstations
$workstations = Get-Content .\workstations.txt

# Using the $workstations variable we'll do a foreach loop that queries AD for the 
# local Administrator password
foreach ($workstation in $workstations)
Get-AdmPwdPassword -ComputerName $workstation | 

# If you don't see anything in the Password column, that means LAPS has not been
# deployed to that workstation