# CredDefense
CredDefense is a super-cool [tool kit](https://github.com/CredDefense/CredDefense) from [Black Hills Information Security](https://www.blackhillsinfosec.com/the-creddefense-toolkit/) that is "a free way to detect and prevent credential abuse attacks."

Currently, I'm most interested in the password filter functionality, which allows you to prevent users from resetting their passwords to contain words like `Winter`, `Spring`, `2017`, etc.  

## Password Filter
Unfortunately, at the time of writing this article, I can't get the CredDefense GUI to install the password filter correctly.  I'm having [this issue](https://github.com/CredDefense/CredDefense/issues/5).  However, a kind user in this thread has detailed some steps for getting the password filter installed manually, and here they are:

1. Download the .zip file from the [GitHub repository](https://github.com/CredDefense/CredDefense/)

2. Copy `CredDefense-master\Build\x64\EasyPasswordFilter.dll` to `C:\Windows\System32`

3. Copy `CredDefense-master\Build\epf` to `C:\Windows\System32` (such that the `epf` subfolder gets created.

4. Open `C:\Windows\System32\epf\epfdict.txt` - you may find that it uses a Linux-style linebreak, so if necessary, clear the file and copy/paste the raw version of the file [from GitHub](https://github.com/CredDefense/CredDefense/blob/caf676ff17177be9ec868d118116da707c1ce580/Build/epf/epfdict.txt).  Also feel free to add your own words to the list - one per line.

5. Open **regedit** and in `HKLM\System\CurrentControlSet\Control\Lsa\`, open `Notifications Packages` and add in `EasyPasswordFilter` (I've got a screenshot in the [GitHub issue I posted](https://github.com/CredDefense/CredDefense/issues/5) if that doesn't make sense).

6. Reboot the DC.

7. Log into a workstation with a general user account.  

8. Hit **Ctrl+Alt+Del** and try to change the password to one containing a "banned" word from `epfdict.txt`.  When you do, you should get a message saying the new password does not meet complexity requirements.
