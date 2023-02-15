#This script is useful for adding users to a group based off of a attribute in AD

# Set the name of the AD attribute to check and the value it should be
$attributeName = "ATTIBUTENAME"
$attributeValue = "VALUE"

# Set the name of the group to add the users to
$groupName = "GROUP_NAME"

#Comment or uncomment which option you'd like to use or make your own!
# Get all users with the specified attribute value
$users = Get-ADUser -Filter '$attributeName -eq $attributeValue'

# Get all users within a specific OU and with a specific Attribute
#$users = Get-ADUser -SearchBase "OU=Subs,OU=Users,OU=NISD,DC=nisdtx,DC=org" -Filter '$attributeName -eq $attributeValue'



# Add each user to the specified group
foreach ($user in $users) {
    Add-ADGroupMember -Identity $groupName -Members $user

}
