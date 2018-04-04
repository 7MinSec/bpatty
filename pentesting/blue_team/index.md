# General Windows environment defenses

SMB
----
So yeah...SMB1 should be disabled whenever/wherever possible.  Here are some resources that dig into the risk and mitigation a bit more:

* [SMB1 product clearinghouse](https://blogs.technet.microsoft.com/filecab/2017/06/01/smb1-product-clearinghouse/) is a Microsoft article "all products requiring SMB1, where the vendor explicitly states this in their own documentation or communications, or where a customer has reported it and shown some degree of proof without vendor refutation."

Active Directory
----
* [Active Directory Control List - Attacks and Defense](https://blogs.technet.microsoft.com/enterprisemobility/2017/09/18/active-directory-access-control-list-attacks-and-defense/) looks to be, in part, a response to "the use of Discretionary Access Control List (DACL) for privilege escalation in a Domain environment."  Articles like [this one](https://wald0.com/?p=112) will give you good insight to the DACL issue.

* [Anti-Reconnaissance Tool: SAMRi10](https://www.bleepingcomputer.com/news/security/microsoft-researchers-release-anti-reconnaissance-tool-named-samri10/) is something Microsoft announced in December, 2016 and is used to limit who can perform SAMR queries for information on users within the same domain.

* [Creating strong passwords](http://www.blackhillsinfosec.com/?p=5460) is relatively easy (if not painful for the end user) by following this guide from BHIS.

* [IISCrypto](https://www.nartac.com/Products/IISCrypto) is not really a defense tool per se, but is a slick GUI tool that gives "administrators the ability to enable or disable protocols, ciphers, hashes and key exchange algorithms on Windows Server 2008, 2012 and 2016. It also lets you reorder SSL/TLS cipher suites offered by IIS, implement best practices with a single click, create custom templates and test your website."

* [Local Administrator Password Solution](/_individuals/Local_Administrator_Password_Solution_LAPS.md) will help you randomize and strengthen the local admin passwords across your AD environment!

* [Microsoft's Advanced Threat Analytics](https://gallery.technet.microsoft.com/ATA-Playbook-ef0a8e38) playbook "turns Active Directory into a powerful post-infiltration detection tool leveraging both signature and user-and-entity-behavioral analytic techniques..."

* [Securing domain controllers](https://adsecurity.org/?p=3377) is a great first step in slowing down AD-focused attacks.

Event logging
------
#### WEFFLES
The [https://blogs.technet.microsoft.com/jepayne/2017/12/08/weffles/](WEFFLES) project is a "fast, free and effective threat hunting" console.  I did a full write-up on WEFFLES [here](weffles.md).

#### Advanced Audit Policy Configuration
To get a little more detail out of your DC audit logs, start by reviewing this [ManageEngine article on advanced audit policy configuration](https://blogs.manageengine.com/active-directory/adauditplus/2014/06/10/%E2%80%8Badaudit-plus-auditing-with-advanced-audit-policy-configuration.html), which describes some important differences between how audit logs used to be configured, and how a Vista-and-newer AD environment can be audited a little more granularly (resulting in fewer events generated about crap you don't care about, thus less disk space used!).

What I'm currently tinkering with is setting up a GPO that's applied only to DCs and has settings like this:

<script src="https://gist.github.com/braimee/f64448111356ca1e9507e88b52ad4a0e.js"></script>


Network
--------
### Auditing and restricting NTLM usage

* [Auditing and restricting NTLM usage guide](https://technet.microsoft.com/en-us/library/jj865674(v=ws.10).aspx)

### Blocking local hijacking attacks
* [Blocking local networking hijacking attacks](https://www.root9b.com/newsroom/blocking-local-network-hijacking-attacks) such as WPAD, Netbios, LLMNR, etc.

### Egress filtering ideas
Here are some general egress filtering ideas you can implement to at least start moving from a position of "we let all traffic go anywhere" to "we're a bit more controlled with our outbound traffic."

#### Block outbound
* MS RPC – TCP & UDP port 135
* NetBIOS/IP – TCP & UDP ports 137-139
* SMB/IP – TCP port 445
* Trivial File Transfer Protocol (TFTP) – UDP port 69
* Syslog – UDP port 514
* Simple Network Management Protocol (SNMP) – UDP ports 161-162
* Internet Relay Chat (IRC) – TCP ports 6660-6669


#### Allow to/from only specific hosts
* SMTP – allowed outbound from only the mail server/smarthost
* DNS – allowed outbound only from specific hosts to specific upstream providers
* NTP – allow internal hosts sync with domain controllers, and then allow only the domain controllers to sync to specific upstream hosts

*Many of these findings were recommendations culled from [this SANS article](https://www.sans.org/reading-room/whitepapers/firewalls/egress-filtering-faq-1059).*

#### Test egress filtering
Services like [AllPorts.exposed](http://allports.exposed/) allows you to quickly test network egress filtering.  For more details read [this great post](https://www.blackhillsinfosec.com/poking-holes-in-the-firewall-egress-testing-with-allports-exposed/) from Black Hills Information Security, but here's the basic Powershell commands to test egress filtering:

```
1..1024 | % {$test= new-object system.Net.Socke
ts.TcpClient; $wait = $test.beginConnect("allports.exposed",$_,$null,$null); ($wait.asyncwaithandle.waitone(250,$false))
; if($test.Connected){echo "$_ open"}else{echo "$_ closed"}} | select-string " "
```
