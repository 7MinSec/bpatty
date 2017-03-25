# sqlmap
The sqlmap [project](https://github.com/sqlmapproject/sqlmap) is an "automatic SQL injection and database takeover tool."

## Usage
* Check out the [wiki](https://github.com/sqlmapproject/sqlmap/wiki/Usage) for the down n' dirty command line Kung Fu
* OWASP has a nice [automated audit using SQLmap](https://www.owasp.org/index.php/Automated_Audit_using_SQLMap) page with this handy general syntax:

````
python sqlmap.py -v 2 --url=http://mysite.com/index --user-agent=SQLMAP --delay=1 --timeout=15 --retries=2 
--keep-alive --threads=5 --eta --batch --dbms=MySQL --os=Linux --level=5 --risk=4 --banner --is-dba --dbs --tables --technique=BEUST 
-s /tmp/scan_report.txt --flush-session -t /tmp/scan_trace.txt --fresh-queries > /tmp/scan_out.txt
````

*Note: double-check syntax before running as I had a conflict with some of these flags.  I believe the tool told me I couldn't use `-v 2` and `--eta` in the same command.*