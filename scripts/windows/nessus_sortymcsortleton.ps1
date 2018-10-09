# Nessus Sorty McSortleton v1.0
#
# This script was designed to take the default .csv export from a Nessus scan, remove
# duplicates, and then create a final .csv with these columns:
#
# Plugin name, severity, plugin pub date, exploitability ease, synopsis, description,
# solution, see also, hosts, CVSS base score, CVSS temporal score, number of affected hosts,
# vulnerability age in days (does nothing), plugin ID
#
# Sources of awesomeness, help and mercy that helped me get this thing created:
# - SANS blog: https://isc.sans.edu/forums/diary/Nessus+and+Powershell+is+like+Chocolate+and+Peanut+Butter/20431/
# - hackernovice on Slack (thank you kind sir!)
# - Google (lots of it)
# - StackOverflow thread I started:
# https://stackoverflow.com/questions/46596513/powershell-extracting-a-comma-separated-list-of-ips
#
#

# First lets import the unfiltered .csv that we exported right out of Nessus
$all = import-csv UNFILTERED.csv

# Next, filter out everything but medium and higher vulns
$filter1 = $all | select 'Plugin name','Severity','Plugin Publication Date','Exploitability Ease','Synopsis','Description','Solution','See Also','Host IP','CVSS Base Score','CVSS Temporal Score','Vulnerability Age in Days','Plugin ID' | Where-Object {$_.Severity -notmatch "None"} | Where-Object {$_.Severity -notmatch "Informational"} | Where-Object {$_.Severity -notmatch "Low"} | Sort-Object -Descending Count

# Filter1 is what I'm calling the initial CSV export, and I'm saving it to a file called round1.csv
$filter1 | Export-Csv ./round1.csv

# Now I'm importing it again for further filtering - taking JUST the unique rows
$importedCSV = import-csv round1.csv | Sort-Object * -Unique

#Here's the variable for the eventual exported finished product in CSV format:
$exportedCSV = 'round2.csv'

$groups = $importedCSV | group -Property 'Plugin ID' | sort 'Plugin ID'

#Create an empty array of objects to hold the records for the final result
$results = @()

#Loop through each Plugin ID group.
Foreach ($group in $groups) {
# Setting some variables that we'll need later...I'm sure I could do this more easily but I'm a codenewb!
    $cleanips = ($group.Group | Select -ExpandProperty 'Host IP' | Sort) -join ', '
	$pluginname = ($group.Group | Select -ExpandProperty 'Plugin Name' | Sort | select -uniq)
	$sev = ($group.Group | Select -ExpandProperty 'Severity' | Sort | select -uniq)
	$ppd = ($group.Group | Select -ExpandProperty 'Plugin Publication Date' | Sort | select -uniq)
	$ee = ($group.Group | Select -ExpandProperty 'Exploitability Ease' | Sort | select -uniq)
	$syn = ($group.Group | Select -ExpandProperty 'Synopsis' | Sort | select -uniq)
	$desc = ($group.Group | Select -ExpandProperty 'Description' | Sort | select -uniq)
	$solut = ($group.Group | Select -ExpandProperty 'Solution' | Sort | select -uniq)
	$seealso = ($group.Group | Select -ExpandProperty 'See Also' | Sort | select -uniq)
	$cvssbase = ($group.Group | Select -ExpandProperty 'CVSS Base Score' | Sort | select -uniq)
	$cvsstemp = ($group.Group | Select -ExpandProperty 'CVSS Temporal Score' | Sort | select -uniq)
	$vulnage = ($group.Group | Select -ExpandProperty 'Vulnerability Age in Days' | Sort | select -uniq)

# Add columns to the new CSV export:

    #Create a new empty object
    $object = New-Object -TypeName PSObject

    #Give the new object properties and values
   	$object | Add-Member -Name 'Plugin Name' -MemberType NoteProperty -Value $pluginname
	$object | Add-Member -Name 'Severity' -MemberType NoteProperty -Value $sev
	$object | Add-Member -Name 'Plugin Publication Date' -MemberType NoteProperty -Value $ppd
	$object | Add-Member -Name 'Exploitability Ease' -MemberType NoteProperty -Value $ee
	$object | Add-Member -Name 'Synopsis' -MemberType NoteProperty -Value $syn
	$object | Add-Member -Name 'Description' -MemberType NoteProperty -Value $desc
	$object | Add-Member -Name 'Solution' -MemberType NoteProperty -Value $solut
	$object | Add-Member -Name 'See Also' -MemberType NoteProperty -Value $seealso
	$object | Add-Member -Name 'Hosts' -MemberType NoteProperty -Value $cleanips
	$object | Add-Member -Name 'CVSS Base Score' -MemberType NoteProperty -Value $cvssbase
	$object | Add-Member -Name 'CVSS Temporal Score' -MemberType NoteProperty -Value $cvsstemp
	$object | Add-Member -Name 'Number of affected hosts' -MemberType NoteProperty -Value (([regex]::matches($cleanips,",").count) + 1)
	$object | Add-Member -Name 'Vulnerability Age in Days' -MemberType NoteProperty -Value $vulnage
	$object | Add-Member -Name 'Plugin ID' -MemberType NoteProperty -Value $group.Name

	#Add the new object which now contains all of the relevant data to the array of objects.  This will be one record in the final results.
    $results += $object
}

# Export the final product!
$results | Export-Csv -Path $exportedCSV
