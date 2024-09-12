# Load Windows Forms assembly to use for the pop-up alert box
Add-Type -AssemblyName System.Windows.Forms

function Set-Alarm {
    # Create a form for user input
    $form = New-Object System.Windows.Forms.Form
    $form.Text = "Set Alarm Time"
    $form.Size = New-Object System.Drawing.Size(300, 200)
    $form.StartPosition = "CenterScreen"

    # Create labels and textboxes for hours, minutes, and seconds input
    $labelHours = New-Object System.Windows.Forms.Label
    $labelHours.Text = "Hours:"
    $labelHours.Location = New-Object System.Drawing.Point(10, 20)
    $form.Controls.Add($labelHours)

    $textboxHours = New-Object System.Windows.Forms.TextBox
    $textboxHours.Location = New-Object System.Drawing.Point(100, 20)
    $form.Controls.Add($textboxHours)

    $labelMinutes = New-Object System.Windows.Forms.Label
    $labelMinutes.Text = "Minutes:"
    $labelMinutes.Location = New-Object System.Drawing.Point(10, 60)
    $form.Controls.Add($labelMinutes)

    $textboxMinutes = New-Object System.Windows.Forms.TextBox
    $textboxMinutes.Location = New-Object System.Drawing.Point(100, 60)
    $form.Controls.Add($textboxMinutes)

    $labelSeconds = New-Object System.Windows.Forms.Label
    $labelSeconds.Text = "Seconds:"
    $labelSeconds.Location = New-Object System.Drawing.Point(10, 100)
    $form.Controls.Add($labelSeconds)

    $textboxSeconds = New-Object System.Windows.Forms.TextBox
    $textboxSeconds.Location = New-Object System.Drawing.Point(100, 100)
    $form.Controls.Add($textboxSeconds)

    # Create OK and Cancel buttons
    $buttonOK = New-Object System.Windows.Forms.Button
    $buttonOK.Text = "OK"
    $buttonOK.Location = New-Object System.Drawing.Point(50, 140)
    $buttonOK.Add_Click({ $form.Close() })
    $form.Controls.Add($buttonOK)

    $buttonCancel = New-Object System.Windows.Forms.Button
    $buttonCancel.Text = "Cancel"
    $buttonCancel.Location = New-Object System.Drawing.Point(150, 140)
    $buttonCancel.Add_Click({ $form.Close() })
    $form.Controls.Add($buttonCancel)

    # Show the form
    $form.ShowDialog()

    # Get the user input values
    $Hours = [int]$textboxHours.Text
    $Minutes = [int]$textboxMinutes.Text
    $Seconds = [int]$textboxSeconds.Text

    # Calculate total time in seconds
    $totalSeconds = ($Hours * 3600) + ($Minutes * 60) + $Seconds

    Write-Host "Alarm set for $Hours hours, $Minutes minutes, and $Seconds seconds from now." -ForegroundColor Blue -BackgroundColor Yellow

    $Check = $true

    while ($Check) {
        Start-Sleep -Seconds $totalSeconds

        # Pop-up alert box to notify the user
        $result = [System.Windows.Forms.MessageBox]::Show("Wake up! Time's up!", "Alarm", 
        [System.Windows.Forms.MessageBoxButtons]::OKCancel, 
        [System.Windows.Forms.MessageBoxIcon]::Information)

        # If the user clicks OK, restart the timer
        if ($result -eq 'OK') {
            Write-Host "Restarting the alarm..." -ForegroundColor Green
        } else {
            Write-Host "Alarm dismissed." -ForegroundColor Red
            $Check = $false
        }
    }
}

# Call the function
Set-Alarm
