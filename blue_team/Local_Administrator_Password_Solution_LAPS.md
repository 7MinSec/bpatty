# Microsoft LAPS (Local Administrator Password Solution)


## Setup LAPS management workstation

1. From the workstation where you will manage LAPS, log in as a domain admin.

2. Download the LAPS bundle at [https://www.microsoft.com/en-us/download/details.aspx?id=46899](https://www.microsoft.com/en-us/download/details.aspx?id=46899).

3. Run the **LAPS.x64.msi** and in the install, choose to install the **AdmPwd GPO Extension** (selected by default) but also the **Management Tools** by clicking the drop-down and selecting **Entire feature will be installed on local hard drive**.  After completing these steps you should now see Local Administrator Password Solution in the installed programs list).

## Configure policy store for LAPS

1. Copy `C:\Windows\PolicyDefinitions\AdmPwd.admx` to `\\yourdomain.com\sysvol\yourdomain.com\Policies\PolicyDefinitions\`

2. Copy `C:\Windows\PolicyDefinitions\en-us
\AdmPwd.adml` to `\\yourdomain.com\sysvol\yourdomain.com\Policies\en-us\PolicyDefinitions\`.  

Note, if your central store is not setup, you will want to follow [this article](https://support.microsoft.com/en-us/help/929841/how-to-create-the-central-store-for-group-policy-administrative-template-files-in-windows-vista) to get it configured first.

## Configure AD for LAPS

1. Back at your administrative LAPS workstation, ensure you are running at least Powershell 3.x (run **$PSVersionTable.PSVersion** to determine that, then install [WMF 5.1](https://www.microsoft.com/en-us/download/details.aspx?id=54616) to quickly jump from older versions of PS to the current).

2. Log off from your LAPS management workstation as a domain administrator level account.

3. Give your account *Schema Admins* permissions.

4. Log back on, log out again (for the *Schema Admins* token to take effect), and then back *in* again.  Tip - you can run `gpresult /V` from the workstation to check whether or not you've successfully added yourself to *Schema Admins*.

5. From the LAPS management workstation, run these PowerShell commands:

 ```
 Import-module AdmPwd.PS
 ```

 ```
 Update-AdmPwdADSchema
 ```

6. Next you need to grant computers the ability to update their password attribute.  We'll designate this by OU.  

 **Warning: I had to run these commands with a new PowerShell window that had a domain admin level account but *not* as my account that currently had Schema Admins permissions**:

 ````
 Set-AdmPwdComputerSelfPermission -OrgUnit "name of the OU to delegate permissions"
 ````

 If you're not sure what should go inside the quotes, open up **Active Directory Users and Computers** and click **View > Advanced Features**, then right-click the OU you want, click **Properties**, then **Attribute Editor** and copy the value from *distinguishedName*.  So, for example:

 ````
 Set-AdmPwdComputerSelfPermission -OrgUnit "OU=My Really Cool Computer Group Thats Gonna Get Laps,DC=i,DC=got,DC=worms"
 ````

7. To double-check what permissions you've set on a given OU, issue this PowerShell command:

 ````
 Find-AdmPwdExtendedRights -Identity "PWN-COMPUTERS"
 ````

 Run this for each OU you've run the *Set-AdmPwdComputerSelfPermission* command on. It should by default return `NT AUTHORITY\SYSTEM, YOURDOMAIN\Domain Admins` by default.

 Note: if this command doesn't work, issue the `Import-module AdmPwd.PS command` again.

 Note 2: if you can't read the *ExtendedRightHolders* column very well, try running:

 ````
 Find-AdmPwdExtendedRights -Identity "PWN-COMPUTERS" | select-object -expandproperty ExtendedRightHolders
 ````

8. If you need to cleanup the *ExtendedRightHolders* assignments, on a DC open **ADSIEdit** and right-click the OU that has computer accounts you're installing LAPS on, such as the *PWN-COMPUTERS* OU.  Click **Properties**, then **Security > Advanced**, then click groups/users you don't want to be able to read passwords and click **Edit**.  Then uncheck **All Extended Rights**.

9. Next, add rights to users/groups to allow them to retrieve a computer's password:

 ````
 Set-AdmPwdReadPasswordPermission -Identity "PWN-COMPUTERS" -AllowedPrincipals "Domain Admins"
 ````
 Repeat this command for each OU and user/group that needs the `Set-AdmPwdReadPasswordPermission` permissions.

10. Remove the *Schema Admins* permissions from your account you did all this work with.

11.  Optionally, log out from your LAPS admin workstation.

## Create GPO to deploy LAPS package

1. From a domain controller, open **Group Policy Management** and create a new GPO in *Group Policy Objects* but don't link it to anything yet.  Call it something smart like *Deploy LAPS*.  Configure it like so:

* **Comp Config > Policies > Software Settings > Software installation > New > Package** and add **\\\your-dc-name\name-of-share\LAPS.x64** as *Assigned*.

* *Comp Config > Policies > Software Settings > Software installation* and add **\\\your-dc-name\name-of-share\LAPS.x32** as *Assigned*.

 * Look at the properties for the *LAPS.x32* and under **Deployment > Advanced** uncheck the box for **Make this 32-bit X86 app available to Win64 machines**.

Note: Do *not* install this on domain controllers or LAPS will change the default Administrator account for the domain.  Yikes.  *Source: [ADSecurity.org](https://adsecurity.org/?p=1790)*.  

What I did in my test LAB is just link this policy (and the one discussed below) only to the machine OUs I had created for workstations and servers.  You could also add a WMI filter (see [this MS article](https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/jj717288(v=ws.11))) to add a safety net by intentionally only installing LAPS on all machines that are *not* domain controllers:

````
Select * from WIN32_OperatingSystem where ProductType="1" or ProductType="3"
````

## Create GPO to enforce LAPS config
Next, create a GPO that's not linked to anything (reminder, you'll want to eventually apply this to servers and workstations but NOT domain controllers!).  The settings you need to config are:

* **Computer Configuration > Policies > Administrative Templates > LAPS > Enable local admin password management > Enabled**.  This will, every 30 days, randomize the local admin with crazy 14-character password!

* **Computer Configuration > Policies > Administrative Templates > LAPS > Password Settings** can be tuned to however aggressive you want.

* **Computer Configuration > Policies > Administrative Templates > LAPS > Name of administrator account to manage** you only need to enable/configure this if you're not using the regular ol' administrator account called *Administrator*.  For instance, I had a client who created a new local admin on each machine called *Superman*, so they would want to enable this setting and use the *Superman* account.  Otherwise just leave this alone, as even if you've simply renamed the Administrator account, it will be auto-detected by its SID.

* **Computer Configuration > Policies > Administrative Templates > LAPS > Do not allow password expiration time longer than required by policy**.  [This site](https://www.scip.ch/en/?labs.20170713) recommends the setting be enabled, because "LAPS observes the currently set expiration date and only makes a change at that time. If an expiration date is then set beyond the defined value, LAPS would otherwise perform the change only at that point."

Note: Do *not* install this on domain controllers or LAPS will change the default Administrator account for the domain.  Yikes.  *Source: [ADSecurity.org](https://adsecurity.org/?p=1790)*.  

What I did in my test LAB is just link this policy (and the one discussed below) only to the machine OUs I had created for workstations and servers.  You could also add a WMI filter (see [this MS article](https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/jj717288(v=ws.11))) to add a safety net by intentionally only installing LAPS on all machines that are *not* domain controllers:

````
Select * from WIN32_OperatingSystem where ProductType="1" or ProductType="3"
````    

## Troubleshooting

### What if my machines are set to refresh the LAPS password every X days and a machine is not on when that time passes?
As far as I know, the machines check this value upon boot.  The way I tested it is I installed LAPS on a machine and used PowerShell to query its local admin password.  Then I setup a GPO to rotate the LAPS password every 24 hours. I immediately shut down the machine and powered it on a few days later.  The LAPS password had changed.

### OK so how do I know which machines have LAPS successfully deployed?
To see *all* machines with LAPS installed, as well as their local admin password, run:

````
Get-ADComputer -filter {ms-mcs-admpwdexpirationtime -like '*'} -Properties 'ms-mcs-admpwd','ms-mcs-admpwdexpirationtime' | select dnshostname,ms-mcs-admpwd
````

*P.S. to find machines without LAPS installed, you can run:*

````
Get-ADComputer -filter {ms-mcs-admpwd -notlike "*"} | select dnshostname
````

### LAPS isn't installing on some machines, and those machines have system logs indicating problems with the install

With my Windows 10 machines, I was seeing system log events like ID 102, with an error similar to "The install of application Local Administrator Password Solution from policy LAPS - deploy failed.  The error was %%1612."  I also had errors of "The error was %%2.  I tried a combination of things below, and I'm not 100% sure if it's the last item or a combination of the items that fixed it, but for what it's worth:

* In the GPO that actually installs the LAPS software, enable **Computer Configuration > Policies > Administrative Templates > System > Group Policy > Specify startup policy processing wait time** and set the value to **30 seconds**

* When you look at the share permissions for the folder containing your LAPS install files, ensure that the basic share permissions include all Domain Users with read access, and then in the NTFS permissions, ensure that you add **Domain Computers** with read access.

* I found with some of the Win 10 machines that after the first reboot, LAPS gets installed, but after the *second* reboot the policy settings for actually enforcing the new local admin password get processed.

### It seems like some machines just won't install the .msi via Group Policy mo matter what!  Wassupwitdat?
I've found that Windows 8 machines seem to be real stubborn when it comes to receiving this .msi gracefully.  I'm still researching workarounds, but for some of them I've just run (as local admin) this command on the offending machines:

````
msiexec /i <file location>LAPS.x##.msi /quiet` (where `##` is `86` or `64`)
````

*Source:* [https://prajwaldesai.com/how-to-install-and-deploy-microsoft-laps-software/](https://prajwaldesai.com/how-to-install-and-deploy-microsoft-laps-software/)

*This is a great troubleshooting site as well: [https://blog.thesysadmins.co.uk/deploying-microsoft-laps-part-1.html](https://blog.thesysadmins.co.uk/deploying-microsoft-laps-part-1.html).*

### Eh, I'm not 100% sure I setup permissions for LAPS right.  How do I know that general users can't just query the password right out of AD?
Good point.  [This article](https://blog.netspi.com/running-laps-around-cleartext-passwords/) by NetSPI brings to light some of the dangers of a misconfigured LAPS install.  I recommend running their [get LAPS passwords](https://github.com/kfosaaen/Get-LAPSPasswords/blob/master/Get-LAPSPasswords.ps1) script to ensure you've got permissions buttoned up correctly.  What I did is logged into one of my workstations as user Barb Wire (*bwire*), downloaded the `Get-LAPSPasswords.ps1` and did this:

````
import-module Get-LAPSPasswords.ps1
````

````
Get-LAPSPasswords -DomainControllers IP.OF.MY.DOMAINCONTROLLER -credential MYDOMAIN\bwire | format-table -autosize
````

Provide your credentials when prompted.

In the output that appears, if you get data populated in the `Password` column, that's bad :-(.  It means you've got something screwed up in the LAPS permissions where you're allowing ANY user to query AD for stores LAPS passwords.
