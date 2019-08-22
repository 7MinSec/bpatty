# Windows scripts

Egress_Filtering_Check.ps1
-----
[This script](https://bpatty.rocks/scripts/windows/egress_filtering_check.ps1) will check which ports are allowed inbound > out to the Internet.

Email_Stuff_To_Yourself.ps1
-----
[This script](https://bpatty.rocks/scripts/windows/email_stuff_to_yourself.ps1) is a quick 'n dirty "email yourself some stuff" from a PowerShell command line.

Environment_Check.ps1
-----
[This script](https://bpatty.rocks/scripts/windows/environment_check.ps1) is designed to gather some helpful baseline information in a Windows Active Directory environment.

Get_ADUserLastLogon.ps1
------
[This script](https://bpatty.rocks/scripts/windows/get_aduserlastlogon.ps1) allows us to lookup a user account and see the last time he/she logged on, if ever.  

Import_AD_Users.ps1
-----
[This script](https://bpatty.rocks/scripts/windows/import_ad_users.ps1) imports a [CSV file full of test users](https://bpatty.rocks/scripts/windows/lusers.csv) for use in a test AD environment.  See the [lab setup](/pentesting/lab_setup/index.md) guide for more information.

LAPS_check_reloaded.ps1
-----
[This script](https://bpatty.rocks/scripts/windows/laps_check_reloaded.ps1) will check to see if Local Administrator Password Solution has been installed in your network environment.

Nessus_SortyMcSortleton.ps1
-----
[This script](https://bpatty.rocks/scripts/windows/nessus_sortymcsortleton.ps1) was designed to take the default .csv export from a Nessus scan, remove duplicates, and then create a final .csv with these columns:

Plugin name, severity, plugin pub date, exploitability ease, synopsis, description, solution, see also, hosts, CVSS base score, CVSS temporal score, number of affected hosts, vulnerability age in days (does nothing), plugin ID.

Powershell (general)
------
[This page](https://bpatty.rocks/scripts/windows/powershell.md) has some general PowerShell syntax and quick references.

Service_Account_Seeker.ps1
---------
[This script](https://bpatty.rocks/scripts/windows/service_account_seeker.ps1) enumerates Windows servers out of Active Directory, ping them to check availability, and then captures details about each service account in use.

ShieldsUp.ps1
----------
[This script](https://bpatty.rocks/scripts/windows/shieldsup.ps1) disables all radios on a Windows machine - be they wired, wireless, Bluetooth, etc.  This helps especially for forensics investigations when you want to stop a machine from communicating with the outside world!
