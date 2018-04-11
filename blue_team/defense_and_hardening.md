# Defense/Hardening

I thought I'd start a page with resources focused on *defending* against the common weaknesses we find during penetration testing.  My hope is this page could be something we send to customers after (or even before!) a pentest to help them take actionable steps in boosting their network defenses.

## Linux
* [Lynis](https://cisofy.com/download/lynis/) is "a security auditing tool for UNIX derivatives like Linux, macOS, BSD, Solaris, AIX, and others. It performs an in-depth security scan."

* [20 Linux Server Hardening Tips](https://www.cyberciti.biz/tips/linux-security.html) offers exactly what it advertises! :-)

## Network

### Auditing and restricting NTLM usage

* [Auditing and restricting NTLM usage guide](https://technet.microsoft.com/en-us/library/jj865674(v=ws.10).aspx)


### Blocking local hijacking attacks
* [Blocking local networking hijacking attacks](https://www.root9b.com/newsroom/blocking-local-network-hijacking-attacks) such as WPAD, Netbios, LLMNR, etc.

### Egress filtering ideasHere are some general egress filtering ideas you can implement to at least start moving from a position of "we let all traffic go anywhere" to "we're a bit more controlled with our outbound traffic."####Block outbound* MS RPC – TCP & UDP port 135
* NetBIOS/IP – TCP & UDP ports 137-139
* SMB/IP – TCP port 445
* Trivial File Transfer Protocol (TFTP) – UDP port 69
* Syslog – UDP port 514
* Simple Network Management Protocol (SNMP) – UDP ports 161-162
* Internet Relay Chat (IRC) – TCP ports 6660-6669

#### Allow to/from only specific hosts
* SMTP – allowed outbound from only the mail server/smarthost
* DNS – allowed outbound only from specific hosts to specific upstream providers
* NTP – allow internal hosts sync with domain controllers, and then allow only the domain controllers to sync to specific upstream hosts*Many of these findings were recommendations culled from [this SANS article](https://www.sans.org/reading-room/whitepapers/firewalls/egress-filtering-faq-1059).*

#### Test egress filtering
Services like [AllPorts.exposed](http://allports.exposed/) allows you to quickly test network egress filtering.  For more details read [this great post](https://www.blackhillsinfosec.com/poking-holes-in-the-firewall-egress-testing-with-allports-exposed/) from Black Hills Information Security, but here's the basic Powershell commands to test egress filtering:

```
1..1024 | % {$test= new-object system.Net.Socke
ts.TcpClient; $wait = $test.beginConnect("allports.exposed",$_,$null,$null); ($wait.asyncwaithandle.waitone(250,$false))
; if($test.Connected){echo "$_ open"}else{echo "$_ closed"}} | select-string " "
```

## Windows

### Active Directory
* [Active Directory Control List - Attacks and Defense](https://blogs.technet.microsoft.com/enterprisemobility/2017/09/18/active-directory-access-control-list-attacks-and-defense/) looks to be, in part, a response to "the use of Discretionary Access Control List (DACL) for privilege escalation in a Domain environment."  Articles like [this one](https://wald0.com/?p=112) will give you good insight to the DACL issue.


* [Anti-Reconnaissance Tool: SAMRi10](https://www.bleepingcomputer.com/news/security/microsoft-researchers-release-anti-reconnaissance-tool-named-samri10/) is something Microsoft announced in December, 2016 and is used to limit who can perform SAMR queries for information on users within the same domain.

* [Creating strong passwords](http://www.blackhillsinfosec.com/?p=5460) is relatively easy (if not painful for the end user) by following this guide from BHIS.

* [IISCrypto](https://www.nartac.com/Products/IISCrypto) is not really a defense tool per se, but is a slick GUI tool that gives "administrators the ability to enable or disable protocols, ciphers, hashes and key exchange algorithms on Windows Server 2008, 2012 and 2016. It also lets you reorder SSL/TLS cipher suites offered by IIS, implement best practices with a single click, create custom templates and test your website."

* [Local Administrator Password Solution](Local_Administrator_Password_Solution_LAPS.md) will help you randomize and strengthen the local admin passwords across your AD environment!

* [Microsoft's Advanced Threat Analytics](https://gallery.technet.microsoft.com/ATA-Playbook-ef0a8e38) playbook "turns Active Directory into a powerful post-infiltration detection tool leveraging both signature and user-and-entity-behavioral analytic techniques..."

* [Securing domain controllers](https://adsecurity.org/?p=3377) is a great first step in slowing down AD-focused attacks.

### Event logging
The [WEF](https://github.com/palantir/windows-event-forwarding) project is aimed to provide "the necessary building blocks for organizations to rapidly evaluate and deploy WEF to a production environment, and centralize public efforts to improve WEF subscriptions and encourage adoption."  This [blog entry](https://medium.com/@palantir/windows-event-forwarding-for-network-defense-cb208d5ff86f) provides some more insight as well.

### SMB
So yeah...SMB1 should be disabled whenever/wherever possible.  Here are some resources that dig into the risk and mitigation a bit more:

* [SMB1 product clearinghouse](https://blogs.technet.microsoft.com/filecab/2017/06/01/smb1-product-clearinghouse/) is a Microsoft article "all products requiring SMB1, where the vendor explicitly states this in their own documentation or communications, or where a customer has reported it and shown some degree of proof without vendor refutation."
