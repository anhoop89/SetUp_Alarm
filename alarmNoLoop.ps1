# PowerShell Alarm Script

param(
    [int]$Hours = 0,
    [int]$Minutes = 0,
    [int]$Seconds = 0
)

$totalSeconds = ($Hours * 3600) + ($Minutes * 60) + $Seconds

Write-Host "Alarm set for $Hours hours, $Minutes minutes, and $Seconds seconds from now."  -ForegroundColor Blue -BackgroundColor Yellow
Start-Sleep -Seconds $totalSeconds

# Play a sound (adjust the path to an existing .wav file on your system)
[System.Console]::Beep(432, 2000)  # Beep at 1000 Hz for 1 second

Write-Host "Wake up! Alarm is ringing!" -ForegroundColor DarkRed

