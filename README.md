# CiscoTacFirstResponder-Anyconnect

Cisco TAC First Responder script for Anyconnect.

These hosted scripts streamline the generation and transmission of a diagnostic (DART) bundle from a user's computer directly to Cisco TAC.

## Collect a DART on Windows

Have the end user open PowerShell on their computer and paste the in following (with the `$CxdUsername` and `$CxdPassword` replaced with the value provided by your Cisco TAC Engineer.)

```powershell
$CxdToken = 'mkDOLk2YO9SyuEkz'
$CxdUsername = '611111111'
Invoke-Expression -Command ((Invoke-WebRequest -uri "https://raw.githubusercontent.com/CiscoCX/CiscoTacFirstResponder-Anyconnect/main/anyconnect-windows.ps1" -UseBasicParsing).Content)
```

Example output:

```
Windows PowerShell
Copyright (C) Microsoft Corporation. All rights reserved.
Try the new cross-platform PowerShell https://aka.ms/pscore6

PS C:\Users\jyoungta>
PS C:\Users\jyoungta> $CxdToken = 'mkDOLk2YO9SyuEkz'
>> $CxdUsername = '611111111'
>> Invoke-Expression -Command ((Invoke-WebRequest -uri "https://raw.githubusercontent.com/CiscoCX/CiscoTacFirstResponder-Anyconnect/main/anyconnect-windows.ps1" -UseBasicParsing).Content)
+-------------------------------------------------------------------------+
| Welcome to the PowerShell Based Cisco AnyConnect DART Collection Script |
|                                                                         |
|  For issues with the collection script/process please file an issue at  |
|   https://github.com/CiscoCX/CiscoTacFirstResponder-Anyconnect/issues   |
|                                                                         |
+-------------------------------------------------------------------------+

This script will initiate a collection of the Cisco AnyConnect DART Bundle and then upload it directly to Cisco TAC
Attempting to collect the DART Bundle

Cisco AnyConnect Diagnostic and Reporting Tool 4.9.04043 .

Copyright (c) 2008 - 2020 Cisco Systems, Inc.
All Rights Reserved.

Bundle option selected: custom
Bundle location: C:\\Users\jyoungta\OneDrive - Cisco\Desktop\DARTBundle_20210915T1630316565Z.zip

Processing System Information...                    24%
DART has finished...                               100%

File collected at C:\Users\jyoungta\OneDrive - Cisco\Desktop\DARTBundle_20210915T1630316565Z.zip
Attempting to transmit to DART Bundle to Cisco TAC for SR 638056481


StatusCode        : 201
StatusDescription : Created
Content           :
RawContent        : HTTP/1.1 201 Created
                    X-XSS-Protection: 1; mode=block
                    X-Content-Type-Options: nosniff
                    Content-Security-Policy: default-src 'none'; img-src 'self' data:; connect-src 'self'; script-src
                    'self'; style-...
Forms             :
Headers           : {[X-XSS-Protection, 1; mode=block], [X-Content-Type-Options, nosniff], [Content-Security-Policy,
                    default-src 'none'; img-src 'self' data:; connect-src 'self'; script-src 'self'; style-src 'self';
                    font-src 'self' data:], [Strict-Transport-Security, max-age=31536000; includeSubDomains]...}
Images            : {}
InputFields       : {}
Links             : {}
ParsedHtml        :
RawContentLength  : 0

Collection Complete!


PS C:\Users\jyoungta>

```

## Collect a DART on MAC (Catalina and above)

The script is written for zsh, the default shell for the `Terminal.app` (Since Mac OS Catalina). Have the user open the `Terminal.app` and then paste the following in (with the `cxdUsername` and `cxdToken` replaced with the values you received from the Cisco TAC Engineer)

```zsh
curl https://raw.githubusercontent.com/CiscoCX/CiscoTacFirstResponder-Anyconnect/main/anyconnect-mac.zsh | cxdUsername=611111111 cxdToken=mkDOLk2YO9SyuEkz zsh -s
```

Example Output:

```
➜  ~ curl https://raw.githubusercontent.com/CiscoCX/CiscoTacFirstResponder-Anyconnect/main/anyconnect-mac.zsh | cxdUsername=611111111 cxdToken=mkDOLk2YO9SyuEkz zsh -s
+-------------------------------------------------------------------------+
| Welcome to the PowerShell Based Cisco AnyConnect DART Collection Script |
|                                                                         |
|  For issues with the collection script/process please file an issue at  |
|   https://github.com/CiscoCX/CiscoTacFirstResponder-Anyconnect/issues   |
|                                                                         |
+-------------------------------------------------------------------------+

This script will initiate a collection of the Cisco AnyConnect DART Bundle and then upload it directly to Cisco TAC


-------------------------------------------------------------------------------
Found the dartcli program at /Applications/Cisco/Cisco AnyConnect DART.app/Contents/Resources/dartcli starting collection
-------------------------------------------------------------------------------

Cisco AnyConnect Diagnostic and Reporting Tool 4.10.01075 .

Copyright (c) 2008 - 2021 Cisco Systems, Inc.
All Rights Reserved.

Bundle option selected: custom
Bundle location: /Users/jyoungta/Desktop/DARTBundle_20210915_1705.zip

Processing Posture application logs...              33%
Processing Filter Configuration...                  40%
Processing System Information...                    43%
DART has finished...                               100%

-------------------------------------------------------------------------------
Finished collection!
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
Attempting to upload the file '/Users/jyoungta/Desktop/DARTBundle_20210915_1705.zip' to the Cisco TAC case number '611111111'
-------------------------------------------------------------------------------
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  8739  100  8739    0     0  10670      0 --:--:-- --:--:-- --:--:-- 10657
-------------------------------------------------------------------------------
Upload complete!
-------------------------------------------------------------------------------
➜  ~
```
