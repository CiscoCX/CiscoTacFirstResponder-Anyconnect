# CiscoTacFirstResponder-Anyconnect

Cisco TAC First Responder script for Anyconnect.

The hosted scripts streamline generation and transmission of diagnostic (DART) bundles from a user's computer to Cisco TAC.

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
