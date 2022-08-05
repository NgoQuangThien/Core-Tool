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
    return 1
    }
    else {
        return 0
    }
}

function stopService {
    .\nssm.exe stop repair_file_windows > $NULL 2>&1
}

function removeService {
    .\nssm.exe remove repair_file_windows > $NULL 2>&1
}

if (checkService -eq 1) {
    echo 'Removed the service.'
}
else {
    echo 'Service does not exist.'
}
