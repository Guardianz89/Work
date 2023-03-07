# Set variables for user account creation
$firstName = "First"
$lastName = "Last"
$groupNames = @("Group1", "Group2", "Group3")
$increment = 001
$description = "This is a description of a user."
$OU = "OU=Users,DC=example,DC=com"

# Loop through and create 40 user accounts
for ($i = 1; $i -le 200; $i++) {
    $userName = "$firstName.$lastName$increment"
    $password = ConvertTo-SecureString -String "Password123" -AsPlainText -Force
    $userParams = @{
        "Name" = $userName
        "AccountPassword" = $password
        "Enabled" = $true
        "PasswordNeverExpires" = $true
        "Description" = $description
        "Path" = $OU

    }
    New-ADUser @userParams
    
    # Add user to specified groups, Comment section out if not adding to groups
    foreach ($groupName in $groupNames) {
        Add-ADGroupMember -Identity $groupName -Members $userName
    }
    
    $increment++
}
