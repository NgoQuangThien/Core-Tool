#___Author___ = 'ThienNQ'

function checkService {
    if (Get-Service repair_file_windows -ErrorAction SilentlyContinue) {
        if (Get-Service repair_file_windows | Where-Object {$_.Status -eq 'Running'}) {
            stopService
            sleep 3
            removeService
        }
        else {
            removeService
        }
    }
}

function createService {
    .\nssm.exe install repair_file_windows `
    $workdir\python\python.exe `
    $workdir\repair_file_windows.py 
}

function setProperties {
    .\nssm.exe set repair_file_windows DisplayName Repair File Windows
    .\nssm.exe set repair_file_windows Description Fix EOF error on Windows for Filebeat
    .\nssm.exe set repair_file_windows AppPriority REALTIME_PRIORITY_CLASS
    .\nssm.exe set repair_file_windows AppExit 2 Exit
}

function startService {
    .\nssm.exe start repair_file_windows > $NULL 2>&1
}

function stopService {
    .\nssm.exe stop repair_file_windows > $NULL 2>&1
}

function removeService {
    .\nssm.exe remove repair_file_windows > $NULL 2>&1
}

function main {
    checkService
    createService
    setProperties
    echo 'Starting the service...'
    startService
    echo 'Please check the service.'
}

$workdir = Split-Path $MyInvocation.MyCommand.Path
main