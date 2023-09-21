     
     
     $Firstname  = "Anakin"
     $Lastname   = "Skywalker"    
     #$Lastname2="Skywalker2"  #incremental name (optional--comment below for username)
     $EmployeeID = "999999"   #Digits only
     $IDAutoID   = [GUID]::NewGuid()

     $Password   = "TotallyNot@S!th1"
     $Title = "Jedi Knight" 
     $Department = "$Title"    

     #$Department = "Jedi"
     #$Password   = "0"

     #default variables
     $Username   = "$Firstname.$Lastname".ToLower()
     #$Username   = "$Firstname.$Lastname2"
     # $Username = "Expo"
     $EID        = "C$EmployeeID"
     $OU         = "OU=Knights,OU=Jedi,DC=jedi,DC=org"


       #Check if the user account already exists in AD
       if (Get-ADUser -F {SamAccountName -eq $Username})
       {
               #If user does exist, output a warning message
               Write-Warning "A user account $Username has already exist in Active Directory."
       }elseif (Get-ADUser -F {EmployeeID -eq $EmployeeID})
       {
               #If user does exist, output a warning message
               Write-Warning "Employee ID $EmployeeID already exists in Active Directory."
       }
       else
       {  
              #If a user does not exist then create a new user account$Firstname.$Lastname
          
        #Account will be created in the OU listed in the $OU variable in the CSV file; don’t forget to change the domain name in the"-UserPrincipalName" variable
            New-ADUser `
            -SamAccountName $Username `
            -UserPrincipalName "$Username@jedi.org" `
            -EmailAddress "$Username@jedi.org" `
            -Name "$Username" `
            -GivenName $Firstname `
            -Surname $Lastname `
            -Enabled $True `
            -Title $Title `
            -ChangePasswordAtLogon $true `
            -DisplayName "$Username" `
            -Department $Department `
            -Description $Department `
            -Path $OU `
            -EmployeeID $EmployeeID `
            -EmployeeNumber $EID `
            -AccountPassword (convertto-securestring $Password -AsPlainText -Force) `
           
           
            
        
            start-sleep -s 5

           Set-ADUser -Identity "$Username" -Add @{
                   'proxyAddresses'="SMTP:$Username@jedi.org"
                  }

        

        write-host Adding user to groups
          start-sleep -s 1


     #     Add-ADGroupMember -Identity "all.jedi" -Members $Username
            start-sleep -s 1
          Add-ADGroupMember -Identity "Force_Users" -Members $Username
            start-sleep -s 1
      #    Add-ADGroupMember -Identity "SG_O365_A1Jedi" -Members $Username
            start-sleep -s 1
          Add-ADGroupMember -Identity "Knight_Jedi" -Members $Username
            start-sleep -s 1

          write-host all done $Username
        }

