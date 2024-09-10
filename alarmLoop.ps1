# Load Windows Forms assembly to use for the pop-up alert box
Add-Type -AssemblyName System.Windows.Forms

function Set-Alarm {
    param(
        [int]$Hours = 0,
        [int]$Minutes = 0,
        [int]$Seconds = 0,
        [bool]$Check = $true
    )

    $currentTime = Get-Date
    $totalSeconds = ($Hours * 3600) + ($Minutes * 60) + $Seconds

    Write-Host "The current time is $currentTime"
    Write-Host "Alarm set for $Hours hours, $Minutes minutes, and $Seconds seconds from now." -ForegroundColor Blue -BackgroundColor Yellow

    while ($Check) {
        Start-Sleep -Seconds $totalSeconds

        # Pop-up alert box to notify the user
        [System.Windows.Forms.MessageBox]::Show("Wake up! Time's up!", "Alarm", 
        [System.Windows.Forms.MessageBoxButtons]::OK, 
        [System.Windows.Forms.MessageBoxIcon]::Information)

        Write-Host "Wake up! Alarm has triggered!" -ForegroundColor DarkRed

        # Sleep for 5 minutes (300 seconds) before the next alarm loop starts
        Start-Sleep -Seconds 10
    }
}


# Call the function (example: set an alarm for 1 minute)
Set-Alarm -Seconds 5
