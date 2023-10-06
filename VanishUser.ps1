$EIDCSV="C:\Scripts\Vanishing\VanishUsers.csv"
$EIDS=import-csv $EIDCSV

#Variable
#$EID="7654321"
ForEach ($EID in $EIDS) {
    $user = get-aduser -server padawan.jedi.org  -Filter 'employeeID -like $EID'
    $UPN=(Get-ADUser -Server adawan.jedi.org -Filter 'employeeID -like $EID').UserPrincipalName
    Remove-ADUser -Server adawan.jedi.org -Identity $user

    #Deleting User from Google
GAM Delete User $UPN
}
