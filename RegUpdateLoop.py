import winreg
import csv

#Set regkey path
key_path = r'SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management'
key_name = 'TestKey'
#Set key value, Dont forget to change from STR to INT depending on the key being eddited
value_data = "TestValue"

with open('computersreg.csv', 'r') as f:
    reader = csv.reader(f)
    for row in reader:
        remote_computer = r'\\' + row[0]

        # Connect to the remote registry
        remote_key = winreg.ConnectRegistry(remote_computer, winreg.HKEY_LOCAL_MACHINE)

        # Create the new key
        new_key = winreg.CreateKeyEx(remote_key, key_path, 0, winreg.KEY_WRITE)

        # Set a value for the new key and change winreg.REG_SZ to different registry key types
        winreg.SetValueEx(new_key, key_name, 0, winreg.REG_SZ, value_data)

        # Close the new key and remote registry
        winreg.CloseKey(new_key)
        winreg.CloseKey(remote_key)

#Reg_SZ keys use strings
#Reg_DWORD uses Integers
