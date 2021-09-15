# CiscoTacFirstResponder-Anyconnect

Cisco TAC First Responder script for Anyconnect.

The hosted scripts streamline generation and transmission of diagnostic (DART) bundles from a user's computer to Cisco TAC.

For Windows have the end user open PowerShell on their computer and paste the in following (with the `$CxdUsername` and `$CxdPassword` replaced with the value provided by your Cisco TAC Engineer.)

```powershell
$CxdToken = 'mkDOLk2YO9SyuEkz'
$CxdUsername = '611111111'
Invoke-Expression -Command ((Invoke-WebRequest -uri "https://raw.githubusercontent.com/CiscoCX/CiscoTacFirstResponder-Anyconnect/main/anyconnect-windows.ps1" -UseBasicParsing).Content)
```

Example output:

```
Put here the example output

```
