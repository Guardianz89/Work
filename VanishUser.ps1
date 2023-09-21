$EIDCSV="C:\Scripts\Vanishing\UnVanishUsers.csv"
$EIDS=import-csv $EIDCSV

#Variable
#$EID="999999"
ForEach ($EID in $EIDS)
{
$EID=$EID.EID
$seek=""

$seek=$(try {Get-ADUser -Server padawans.jedi.org -filter 'employeeID -like $EID'} catch {$null})

#Get ObjectGUID
if($seek -ne $null){ 
  

$GUID=(Get-ADUser -Server padawans.jedi.org -filter 'employeeID -like $EID').ObjectGUID
$UPN=(Get-ADUser -Server padawans.jedi.org -filter 'employeeID -like $EID').UserPrincipalName
$SAM=(Get-ADUser -Server padawans.jedi.org -filter 'employeeID -like $EID').sAMAccountName

$SAM2=$SAM+"2"

$seek2=$(try {Get-ADUser -Server padawans.jedi.org -Identity $SAM2  } catch {$null})
if($see2k -ne $null){
  write-host $UPN has a 2 -ForegroundColor Yellow
}

 # Write-Host $EID is $UPN  purging $GUID

  #remove User
  # Remove-ADUser -Server padawans.jedi.org -Identity $GUID

  write-host Checking to restore $UPN
   #Deleting User from Google
   GAM UnDelete User $UPN

}
else{
 Write-Host $EID was not found

}




}
