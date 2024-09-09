
function Set-Alarm {

    # loop in 5 mins
    param(
        [int]$Hours = 0,
        [int]$Minutes = 0,
        [int]$Seconds = 0,
        [bool]$Check = $true
    
    )
    $currentTime = Get-Date
    $totalSeconds = ($Hours * 3600) + ($Minutes * 60) + $Seconds

    Write-Host "The current time is $currentTime "
    Write-Host "Alarm set for $Hours hours, $Minutes minutes, and $Seconds seconds from now." -ForegroundColor Blue -BackgroundColor Yellow

    while ($Check) {
        Start-Sleep -Seconds $totalSeconds

        # Play a sound (adjust the path to an existing .wav file on your system)
        [System.Console]::Beep(432, 2000)  # Beep at 1000 Hz for 1 second

        Write-Host "Wake up! Alarm is ringing!" -ForegroundColor DarkRed

        # Sleep for 5 minutes before the next alarm
        Start-Sleep -Seconds 3
    }

}


# call function 

Set-Alarm 0 2 0
