#Read me#
#This script is used to repopulate groups based off of set criteria


import pyad.adquery
import pyad.aduser
import pyad.adgroup
import pyad

#Set the name of the AD attribute to check and the value it should be
attribute_name = "employeeType"
attribute_value = "Padawan"

# Set the name of the group to add the users to
group_name = "all.Padawans"

 # Create an AD query to retrieve all users with the specified attribute value
query = pyad.adquery.ADQuery()
query.execute_query(
    attributes=["sAMAccountName", "userPrincipalName"],
    where_clause=f"{attribute_name}='{attribute_value}'"
)

# Add each user to the specified group
for result in query.get_results():
    user = pyad.aduser.ADUser.from_cn(result["cn"])
    group = pyad.adgroup.ADGroup.from_cn(group_name)
    group.add_members(user)
