# BackyStuffyUppy - v0.1
# Updated: 8/21/19
#
# Purpose: This script is designed to quickly compress a date/time-stamped folder of your choice and send it to a destination of your choice.
#
# Resources/inspirations:
# - https://social.technet.microsoft.com/Forums/ie/en-US/9575a139-54cc-46b7-9cb2-a0764e2b3708/powershell-script-to-zip-a-folder-and-use-current-date-as-filename?forum=winserverpowershell
# - https://blog.netwrix.com/2018/11/06/using-powershell-to-create-zip-archives-and-unzip-files/

# Change 'C:\SOME-SOURCE' and "C:\SOME-DESTINATION" to the folder you actually wanna back up
Compress-Archive -Path C:\SOME-SOURCE -DestinationPath ('C:\SOME-DESTINATION-' + (get-date -Format yyyy-MM-dd-HH-mm) + '.zip')