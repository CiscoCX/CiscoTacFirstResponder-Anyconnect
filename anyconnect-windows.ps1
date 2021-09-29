# This script will call Cisco Anyconnect DART Program on the user computer
# to generate a DART Bundle.  Then using the CxdUsername and CsxToken values
# provided by a Cisco TAC engineer it will upload the file to Cisco TAC

function Send-CiscoTacFile {
    # Sends the file via https to Cisco TAC using the 
    # username and password provided by the TAC Engineer
    param (
        [string] $CxdUsername,
        [string] $CxdToken,
        [string] $FilePath
    )
    $credBytes = [System.Text.Encoding]::UTF8.GetBytes(
        ('{0}:{1}' -f $CxdUsername, $CxdToken)
    )
    $cred = [Convert]::ToBase64String($credBytes)
    $Authorization = 'Basic {0}' -f $cred
    $Headers = @{ Authorization = $Authorization }
    $Filename = Split-Path $FilePath -Leaf 
    $Uri = 'https://cxd.cisco.com/home/{0}' -f $Filename
    Invoke-WebRequest -Uri $Uri -InFile $FilePath -Headers $Headers -Method Put -useBasicParsing
}

function New-DartBundle {
    # Generates the DART bundle with the current datetime in the filename
    # and puts it on the user's desktop
    $DesktopPath = [Environment]::GetFolderPath("Desktop")
    $DartLocation = '{0}\DARTBundle_{1}.zip' -f $DesktopPath, (Get-Date -Format FileDateTimeUniversal)
    $AnyconnectDartCliLocation = 'C:\Program Files (x86)\Cisco\Cisco AnyConnect Secure Mobility Client\DART\dartcli.exe'
    $SecureClientDartCliLocation = 'C:\Program Files (x86)\Cisco\Cisco Secure Client\DART\dartcli.exe'
    if (Test-Path -Path $AnyconnectDartCliLocation -PathType Leaf) {
        $DartCliLocation = $AnyconnectDartCliLocation
    }
    if (Test-Path -Path $SecureClientDartCliLocation -PathType Leaf) {
        $DartCliLocation = $SecureClientDartCliLocation
    }
    if (-not($DartCliLocation)) {
        throw "Unable to find DART Program.  Is DART installed?"
    }
    Start-Process -FilePath $DartCliLocation -ArgumentList "-dst `"$DartLocation`"" -Wait -NoNewWindow
    return $DartLocation
}

Write-Output "+-------------------------------------------------------------------------+"
Write-Output "| Welcome to the PowerShell Based Cisco AnyConnect DART Collection Script |"
Write-Output "|                                                                         |"
Write-Output "|  For issues with the collection script/process please file an issue at  |"
Write-Output "|   https://github.com/CiscoCX/CiscoTacFirstResponder-Anyconnect/issues   |"
Write-Output "|                                                                         |"
Write-Output "+-------------------------------------------------------------------------+"
Write-Output ""
Write-Output "This script will initiate a collection of the Cisco AnyConnect DART Bundle and then upload it directly to Cisco TAC"

if (!$CxdUsername -or !$CxdToken) {
    Write-Output ""
    Write-Output "Error: Both the `$CxdUsername and `$CxdToken Variable must be set before executing this script.  Please contact your Cisco TAC Engineer to obtain the values".
    Return
}

Write-Output "Attempting to collect the DART Bundle"
$CollectedFilePath = New-DartBundle
Write-Output "File collected at $CollectedFilePath"
Write-Output "Attempting to transmit to DART Bundle to Cisco TAC for SR $cxdUsername"
Send-CiscoTacFile -CxdUsername $CxdUsername -CxdToken $CxdToken -FilePath $CollectedFilePath
Write-Output "Collection Complete!"
