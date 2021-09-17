#!/bin/zsh

echo "+-------------------------------------------------------------------------+"
echo "| Welcome to the PowerShell Based Cisco AnyConnect DART Collection Script |"
echo "|                                                                         |"
echo "|  For issues with the collection script/process please file an issue at  |"
echo "|   https://github.com/CiscoCX/CiscoTacFirstResponder-Anyconnect/issues   |"
echo "|                                                                         |"
echo "+-------------------------------------------------------------------------+"
echo ""
echo "This script will initiate a collection of the Cisco AnyConnect DART Bundle and then upload it directly to Cisco TAC"
echo ""
echo ""

function UploadFileToCisco() {
    # A function to upload the file to Cisco TAC using the username, token and filename passed in as arguments
    cxdUsername=$1
    cxdToken=$2
    dartFilename=$3
    echo "-------------------------------------------------------------------------------" >&2
    echo "Attempting to upload the file '$dartFilename' to the Cisco TAC case number '$cxdUsername'" >&2
    echo "This might take some time depending on the file size and transfer speed" >&2
    echo "-------------------------------------------------------------------------------" >&2
    curl --progress-bar --upload-file "$dartFilename" "https://$cxdUsername:$cxdToken@cxd.cisco.com/home/"
    echo "-------------------------------------------------------------------------------" >&2
    echo "Upload complete!"
    echo "-------------------------------------------------------------------------------" >&2
}


function CreateDartBundle() {
    # Execute the DART CLI executable and store the DART file on the User's Desktop
    dartcli='/Applications/Cisco/Cisco AnyConnect DART.app/Contents/Resources/dartcli'
    # Compute a unique file name and destination
    dartfilename=$HOME/Desktop/DARTBundle_`date "+%Y%m%d_%H%M"`.zip
    if [ -f $dartcli ];
    then
        echo "-------------------------------------------------------------------------------" >&2
        echo "Found the dartcli program at $dartcli starting collection" >&2
        echo "-------------------------------------------------------------------------------" >&2
        $dartcli -dst $dartfilename >&2
        echo "-------------------------------------------------------------------------------" >&2
        echo "Finished collection!" >&2
        echo "-------------------------------------------------------------------------------" >&2

    else
        echo "Error Unknown location of Cisco Anyconnect DART" >&2
        return 1
    fi
    echo $dartfilename
}


# Validate that the username was passed into the script as a variable
if [[ ! $cxdUsername =~ 6[[:digit:]]{8} ]]
then
    echo "+-------------------------------------------------------------------------+"
    echo "| ERROR:                                                                  |"
    echo "| The variable cxdUsername needs to be set prior to running this script.  |"
    echo "| The username should be something like '611111111'.                      |"
    echo "| The username should be provided by the Cisco TAC Engineer               |"
    echo "+-------------------------------------------------------------------------+"
    exit 1
fi

# Validate that the token was passed into the script as a variable
if [[ ! $cxdToken =~ [a-zA-Z0-9]{10,} ]]
then
    echo "+-------------------------------------------------------------------------+"
    echo "| ERROR:                                                                  |"
    echo "| The variable cxdToken needs to be set prior to running this script.     |"
    echo "| The username should be something like 'mkDOLk2YO9SyuEkz'.               |"
    echo "| The username should be provided by the Cisco TAC Engineer               |"
    echo "+-------------------------------------------------------------------------+"
    exit 1
fi

# Create the DART bundle and get the filename/path of the generated file
dartFilename=`CreateDartBundle`
# Upload the file to Cisco TAC.
UploadFileToCisco $cxdUsername $cxdToken $dartFilename >&2

echo "+-------------------------------------------------------------------------+"
echo "| Collection complete.  Thank you for uploading the DART Bundle           |"
echo "| The TAC Engineer for case $cxdUsername should now have the file            |"
echo "+-------------------------------------------------------------------------+"

# Success. Exit cleanly
exit 0