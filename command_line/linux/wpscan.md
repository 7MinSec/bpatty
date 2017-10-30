# WPScan
[WPScan](https://wpscan.org/) is "a black box WordPress vulnerability scanner."  Here's a down n' dirty usage guide:

## Basic commands

`wpscan --update` - run this first!  It updates the database!

`wpscan --help` - gets help!

`wpscan --url www.somesite.com` - does the basic, "gentle" checks

`wpscan --url www.somesite.com -e ap,at,u,tt` - this is a *very* intrusive check and uses *all* the enumeration options in the next section!  Careful!  And you might want to use some of the flags in the *Extra helpful flags* section to make the scan a little less intense for your target.  For example, something like this might be more appropriate:

`wpscan --url https://www.somesite.com -e ap,at,u,tt --throttle 1000 --threads 1 --request-timeout 60 --connect-timeout 60`

## Brute forcing
`wpscan --url www.somesite.com --wordlist ~/rockyou.txt --username administrator` does a brute-force of the *administrator* username using the *rockyou.txt* word list

## Enumerate stuff
`wpscan --url www.somesite.com --enumerate` runs all enumeration tools

`-p` - enumerates plugins (**watch this setting carefully because you need to use `-ap` to enumerate *all* plugins!**)

`-t` enumerates installed themes (**watch this setting carefully because you need to use `-at` to enumerate *all* themes!**)

`-vt` enumerate vulnerable themes

`-u` enumerates users

`-tt` enumerates installed timthumbs

## Extra helpful flags

`--throttle <milliseconds>` - for example, I've been using `--throttle 1000` in order to be a bit less intense on my target site.  If this is used, you should also set `--threads 1`

`--request-timeout` and `--connect-timeout` help your scan recover smoothly from site errors/timeouts

`--random-agent` - scans with a random user agent string