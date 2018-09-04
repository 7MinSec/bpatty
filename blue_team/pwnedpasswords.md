# Pwned Passwords - how to integrate with Active Directory

## Introduction
In February of 2018, Troy Hunt launched a [Pwned Passwords](https://www.troyhunt.com/ive-just-launched-pwned-passwords-version-2/) project which made half a billion passwords (hashed with SHA-1) available for download.  These passwords were culled from [the Anti Public and Exploit.in combo lists](https://www.troyhunt.com/password-reuse-credential-stuffing-and-another-1-billion-records-in-have-i-been-pwned/) and two other large dumps, including:

* The [711 million record Onliner Spambot dump](https://www.troyhunt.com/inside-the-massive-711-million-record-onliner-spambot-dump/).

* The [1.4B clear text credentials from the "dark web"](https://www.troyhunt.com/making-light-of-the-dark-web-and-debunking-the-fud/).

Troy and Cloudflare have teamed up to build an [API](https://haveibeenpwned.com/API/v2#PwnedPasswords) so that enterprises can integrate a [k-Anonymity](https://blog.cloudflare.com/validating-leaked-passwords-with-k-anonymity/) check with their applications and services.  For instance, if you wanted to see if the password *P@ssw0rd* (which has a SHA-1 hash of *21BD12DC183F740EE76F27B78EB39C8AD972A757*) exists in Troy's data set, you could make an API call to:

> Request URL: https://api.pwnedpasswords.com/range/21DB1

This request will return any hashes with *21DB1* as a prefix, such as:

> * (21BD1) 0018A45C4D1DEF81644B54AB7F969B88D65:1 (password "lauragpe")
* (21BD1) 00D4F6E8FA6EECAD2A3AA415EEC418D38EC:2 (password "alexguo029")
* (21BD1) 011053FD0102E94D6AE2F8B83D76FAF94F6:1 (password "BDnd9102")
* (21BD1) 012A7CA357541F0AC487871FEEC1891C49C:2 (password "melobie")
* (21BD1) 0136E006E24E7D152139815FB0FC6A50B15:2 (password "quvekyny")
* ...
* ...

With the results that come back from the API, the enterprise can determine whether or not the full password is present in the results without ever actually having sent the entire password to Troy's API.

## Integrating "Pwned Passwords" check into Active Directory password resets

Since the launch of Troy's project there has been a lot of interest in bringing the Pwned Passwords check into the enterprise - particularly with Active Directory.  Additionally, a good number of companies want to keep the password checks - even partial SHA-1 hash comparisons - completely within the LAN.  At this point in time, there seems to be two primary solutions to accomplish this:

* [PwnedPasswordsDLL](https://github.com/JacksonVD/PwnedPasswordsDLL) - open source
* [SafePass.me](https://safepass.me/) - commercial solution for ~$700

Below is a breakdown of installation instructions and impressions/thoughts on each solution:

### Option 1: PwnedPasswordsDLL
Troy [tweeted](https://twitter.com/troyhunt/status/967854347613716480?lang=en) about this solution in late February, and the tweet points to user JacksonVD's [blog article](https://jacksonvd.com/checking-for-breached-passwords-in-active-directory/) which discusses the finer points of compiling his [open source DLL](https://github.com/JacksonVD/PwnedPasswordsDLL).  JacksonVD's blog and project page assume the end user has some Visual Studio experience, so I created the following instructions which do *not* make that assumption.

1. Download Visual Studio Community 2017 from [here](https://www.visualstudio.com/downloads/). You'll want to install **Desktop development with C++**, **Windows 8.1 SDK** as well as **Windows Universal CRT SDK**.

2. Download JacksonVD's [GitHub project](https://github.com/JacksonVD/PwnedPasswordsDLL) by visiting the project page and clicking **Clone or Download -> Download Zip** and saving the .zip file to your computer.  Unzip it to a folder on your machine, such as `C:\pwnedpasswords`.

3.  Download [Crypto++](https://www.cryptopp.com/#download) to your machine as well (for this test I used version [6.1.0](https://www.cryptopp.com/cryptopp610.zip)).  Unzip it to a folder on your machine, such as `C:\crypto`.

4. Open Visual Studio, and open `C:\crypto\cryptest.sln`.  You may be prompted to install some missing features.  Click **Install**.  At the top of the Visual Studio window, ensure **Debug** and **Win32** are selected.

5. From the **Build** menu, choose **Batch Build**.  From the selections in the next pop-up box, choose:

 * **cryptlib / Debug / x64**
 * **cryptlib / Release / x64**

 Then click **Build**.

6. Now open `C:\pwnedpasswords\PwnedPasswordsDLL.sln`.  At the top of the Visual Studio window, ensure **Release** and **x64** are selected.

7. Download Troy Hunts 500M Pwned Passwords from [here](https://haveibeenpwned.com/Passwords).  Extract the .7z file to a central location, such as `\\yourdomain.local\passwords`.

8. Open `C:\pwnedpasswords\PwnedPasswordsDLL\dllmain.cpp` and search for a section that looks like this:

 ````
 // String array of the file names + locations - you may customise if you wish
string str1[3] = { "C:\\pwned-passwords-1.0.txt", "C:\\pwned-passwords-update-1.txt", "C:\\pwned-passwords-update-2.txt" };
 ````

 You can edit these three paths to be various password files of your choosing.  For example, you can change `C:\\pwned-passwords-1.0.txt` to be the UNC path you established in step 7.  Remember that in the code, you need to use double slashes for each slash, so using the example in step 7, you'd want the path to look like `\\\\yourdomain.local\passwords`.  

 Then you can leave the other two paths as is, or create a file of SHA-1 hashes of your choosing to help verify the password checks are working.  For example, I created a file called `C:\brianspasswords.txt` and then used an [online SHA-1 generator](https://passwordsgenerator.net/sha1-hash-generator/) to make a hash of a verify specific password, such as *IsPwnedPasswordsW0rking?*, which results in a string of *0C83240100274C96976E4C62AE67C959531048F7*.  So to test this specific password out, I put the SHA-1 hash into `C:\brianspasswords.txt` and then changed the `C:\\pwned-passwords-update-1.txt` path to point to `brianspasswords.txt`

9. In Visual Studio click **Project -> PwnedPasswordsDLL Properties...** and make these changes:

 * **Configuration Properties -> VC++ Directories -> Include Directories** - do a **right-click** on the path and click **Edit**, then add `C:\crypto` and click **OK**.
 * **Configuration Properties -> VC++ Directories -> Library Directories** - do a **right-click** on the path and click **Edit** and then insert the path `C:\crypto\x64\Output\Debug\` and click **OK**.
  * **Configuration Properties -> Linker -> Input -> Additional Dependencies** - do a **right-click** on the path and click **Edit** and then insert the path `C:\crypto\x64\Output\Debug\cryptlib.lib` and click **OK.**
  * **Configuration Properties -> C/C++ -> Code Generation -> Runtime Library** - change to **Multi-threaded Debug (/MTd)

10. In Visual Studio click **Build - > Build Solution**

11.  Take the compiled DLL from `C:\pwnedpasswords\PwnedPasswordsDLL\x64\release\PwnedPasswordsDLL.dll` and copy it to the `C:\windows\system32` directory of your domain controllers.

12. In the registry for each DC, open up `HKLM\System\CurrentControlSet\Control\Lsa\Notification packages`.

13. There will likely be an existing entry that looks like:

 ````
 scecli
 rassfm
 ````

 Add `PwnedPasswordsDLL` (just the DLL name *without* the extension) so that the finished entry looks like this:

 ````
 scecli
 rassfm
 PwnedPasswordsDLL
 ````

14. Reboot all domain controllers.

15. From a test client machine, reboot the machine and log back in.

16.  Hit **Ctrl+Alt+Del** and choose to change your password.

17. Attempt to change the password to the specific test password you selected in step 8.  You should receive a message that the password does not meet the complexity requirements established by the domain policy.

#### Troubleshooting

**No matter what password I pick, Windows says it doesn't meet the requirements for the domain password policy**
Check your password policy for the *Minimum password age* setting.  If this is set to 1 and you've recently been resetting test users in AD, they may not have the ability to change their own password at all (until 24 hours pass).  You can change this setting to **0** to allow immediate password changes.

----

### Option 2: SafePass.me
[SafePass.me](https://safepass.me) is a commercial solution (~$700) that integrates Troy Hunt's Pwned Passwords project via a Microsoft MSI file.

1. Download the SafePass trial evaluation [here](https://safepass.me/pages/download-an-evaluation-version-of-safepass-me)

2. Run the .MSI file as administrator.  You'll be prompted to reboot to make the config changes take place.

3. Reboot the domain controller, and the password check is now active (you can verify this in `HKLM\System\CurrentControlSet\Control\Lsa\Notification packages` - there will be a *SafePassMe* entry).  

4.  On the DC, you can open `c:\windows\system32\safepassme\wordlist.txt` and add any custom words you don't want users to use.  This can be things like your company name, domain name, etc.  

5. On a client machine, attempt to change a user passwords to one in the Pwned Passwords list or in the *wordlist.txt*.  You should get the message saying that the password does not meet complexity requirements.

6. On the DC, open Event Viewer and look in the Security log - you should see events from source *SafePassMe* that indicate whether the password was successfully allowed or not.

7.  Should you need to disable SafePassMe, open `HKLM\System\CurrentControlSet\Control\Lsa\Notification packages`, remove the *SafePassMe* entry and reboot the DC(s).

---

# Feature comparison table

|      | PwnedPasswordsDLL     | SafePass.Me
| :------------- | :------------- | :-------------
| Price       | Free       | ~$700
| Install difficulty       | Moderate (requires you to build a DLL)      | Easy (.MSI installer)
| Supports custom wordlists | Yes (SHA1 format) | Yes (plain text)
| Open source | Yes | No
| Support included | No - just through GitHub/blog posts | Yes
| All password checks done offline | Yes | Yes
| Disk space requirements | ~30GB for PwnedPassword database | ~500MB as SafePass claims to have a super-set of Troy's database, but claims it will "prevent *all* the passwords present in the dataset"
