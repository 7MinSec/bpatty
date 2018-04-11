# This script will import the list of users in "lusers.csv" found in the same folder.
# This script assumes you've made an OU called "BULKUSERS" - adjust as necessary
# This script also uses a domain called "i.got.worms" - you'll want to change that as well
Import-Csv .\big-lusers.csv | foreach-object {
New-ADUser -Name $_.DisplayName -UserPrincipalName $_.UserPrincipalName -SamAccountName $_.Username -GivenName $_.GivenName -DisplayName $_.DisplayName -SurName $_.Surname -Path "OU=BULKUSERS,DC=i,DC=got,DC=worms" -AccountPassword (ConvertTo-SecureString $_.Password -AsPlainText -force) -Enabled $True -PasswordNeverExpires $True -PassThru }
