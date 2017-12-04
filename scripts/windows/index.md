# Windows scripts

Egress_Filtering_Check.ps1
-----
[This script](Egress_Filtering_Check.ps1) will check which ports are allowed inbound > out to the Internet.

Email_Stuff_To_Yourself.ps1
-----
[This script](Email_Stuff_To_Yourself.ps1) is a quick 'n dirty "email yourself some stuff" from a PowerShell command line.

Environment_Check.ps1
-----
[This script](Environment_Check.ps1) is designed to gather some helpful baseline information in a Windows Active Directory environment.

Get_ADUserLastLogon.ps1
------
[This script](Get_ADUserLastLogon.ps1) allows us to lookup a user account and see the last time he/she logged on, if ever.  

LAPS_check_reloaded.ps1
-----
[This script](LAPS_check_reloaded.ps1) will check to see if Local Administrator Password Solution has been installed in your network environment.

Nessus_SortyMcSortleton.ps1
-----
[This script](Nessus_SortyMcSortleton.ps1) was designed to take the default .csv export from a Nessus scan, remove duplicates, and then create a final .csv with these columns:

Plugin name, severity, plugin pub date, exploitability ease, synopsis, description, solution, see also, hosts, CVSS base score, CVSS temporal score, number of affected hosts, vulnerability age in days (does nothing), plugin ID.

powershell.md
------
[This page](powershell) has some general PowerShell syntax and quick references.

Service_Account_Seeker.ps1
---------
[This script](Service_Account_Seeker.ps1) enumerates Windows servers out of Active Directory, ping them to check availability, and then captures details about each service account in use.
