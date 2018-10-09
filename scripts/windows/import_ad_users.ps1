# This script:
# * Will import the list of users in "lusers.csv" found in the same folder.
# * Assumes you've made an OU called "BULKUSERS" - adjust as necessary
# * Uses a domain called "i.got.worms" - you'll want to change that as well
Import-Csv .\lusers.csv | foreach-object {
New-ADUser -Name $_.DisplayName -UserPrincipalName $_.UserPrincipalName -SamAccountName $_.Username -GivenName $_.GivenName -DisplayName $_.DisplayName -SurName $_.Surname -Path "OU=BULKUSERS,DC=i,DC=got,DC=worms" -AccountPassword (ConvertTo-SecureString $_.Password -AsPlainText -force) -Enabled $True -PasswordNeverExpires $True -PassThru }
