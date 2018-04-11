# WEFFLES

## Intro
This is an abbreviated install/setup guide for WEFFLES (Windows Event Logging Forensic Logging Enhancement Services) that is described in awesome detail [here](https://blogs.technet.microsoft.com/jepayne/2017/12/08/weffles/).  

## Requirements
* Active Directory for GPOs to setup/config WEFFLES
* A server to slurp up events.  I'm going to use a Windows Server 2008 R2 VM with 2 CPUs, 4GB of memory and 40GB HD.
* [PowerBI Desktop](https://powerbi.microsoft.com/en-us/desktop/) for the console/data slicer.
* .NET 4.5 - for PowerBI Desktop
* .NET 3.5.1 - for WEFFLES functionality

## Topology
I made a simple, small lab setup with a domain of *i.got.worms* and these machines:

* *igw-dc01.i.got.worms* - domain controller
* *igw-srv01.i.got.worms* - the server I'll use for [PowerBI Desktop](https://powerbi.microsoft.com/en-us/desktop/)
* *igw-desktop01* - Windows 10 workstation
* *igw-desktop02* - Windows 10 workstation

## GPO config
In my domain of *i.got.worms* I created a workstation computer group called *IGW-Workstations* and a server computer group called *IGW-Servers*.

### Windows Event Forwarding GPO
I created this new GPO and linked it to *IGW-Workstations*, *IGW-Servers* and *Domain Controllers*.  The settings are as follows:

* **Computer Configuration > Policies > Administrative Templates: Policy Definition > Windows Components > Event Forwarding > Configure target Subscription Manager**
 * Enable this setting and then set *Value* to **Server=http://name.of.your.bi.server:5985/wsman/SubscriptionManager/WEC,Refresh=60**.  The *Refresh* can be something higher if you feel 60 seconds is too often

* **Computer Configuration > Policies > Administrative Templates: Policy Definition > Windows Components > Event Log Service > Security > Configure log access**
 * Enable this setting, and then to figure out what values to set, run **wevtutil gl security** at a command prompt from a workstation joined to your domain.  In my environment, this settings started with *O:BAG:SYD:(A...* and then ended with *S-1-5-32-573)*.  Copy and paste that value into the GPO setting, but then also add *(A;;0x1;;;NS)* to the end.  

* **Computer Configuration > Preferences > Control Panel Settings > Services**
 * Choose to do a *New Service* with the following settings:
   * **Startup: Automatic**
   * **Service Name: WinRM** (The *Display Name* is *Windows Remote Management (WS-Management)*
   * **Service action: Start service**
   * **Wait timeout if service is locked: 30 seconds**
   * **Recovery Tab > First Failure: Restart the Service**
   * **Recovery Tab > Second Failure: Restart the Service**
   * **Recovery Tab > Subsequent Failures: No Change**
   * **Recovery Tab > Restart fail count after 0 days**
   * **Recovery Tab > Restart service after 1 minutes**

* **Computer Configuration > Policies > Windows Settings > Security Settings > System Services > Windows Remote Management**
 * Choose **Define this policy setting** and set startup mode to **Automatic**

## Setup event collector
1. On your event collector machine (again, for me that's *igw-srv01.i.got.worms* box), download the zip of the WEFFLES [GitHub repo](https://github.com/jepayneMSFT/WEFFLES) to the desktop.

2. Execute the `wefsetup.ps1` script.

3. Reboot the collector server.

4.  Wait about 10-15 minutes for the events to start "cooking."

5.  Open *Event Viewer* and under *Subscriptions*, right-click on **CoreEvents** and click **Runtime Status**.  A box will pop up with a *Subscription Status* and then below that a *Source computers* list of machines that *should* start checking in to report events.  If they don't, check the GPO settings above and make sure that your *Configure target Subscription Manager* begins with **Server=** because I missed that the first time.  Also, make sure your clients in your AD environment are all time-synch'd properly.  Mine *weren't* and it took me *way* too long to figure that out.  Check time sync articles like [this](https://kb.vmware.com/s/article/1035833) for help on the VMWare side, and [this](https://www.altaro.com/hyper-v/configuring-time-synchronization-for-all-computers-in-windows-domain/) on the Windows side.  

6.  In *Event Viewer*, also open **Windows Logs > Forwarded Events** to verify the events are pulling in from machines in the domain.

7. Check `C:\WEFFLES` directory and ensure that you've got a `weffles.xls` and `bookmarks.stream` file.  If you *don't*, double-check that you have .NET 3.5 installed.  I didn't, and that ended up being my issue!

## Review collected data
On the collector machine:

* Install [PowerBI Desktop](https://powerbi.microsoft.com/en-us/desktop/)
* Run PowerBI
* Open `C:\weffles\weffles.pbix`
  * Note!  On my machine when I opened the .pbix file, it complained about `C:\sta\weffles\weffles.csv` not existing.  I'm not sure if I somehow jacked up that file path with the *sta* in there, but anyway, within the little grey "window icon" drop-down menu in the upper left of Power BI, I chose **Options and Settings > Data Source Settings** and changed the path to `C:\weffles\weffles.csv`.  

* Refresh the data with the big **Refresh** button and you should be good to go!
