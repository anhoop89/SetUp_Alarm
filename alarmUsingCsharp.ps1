# Load Windows Forms Assembly
Add-Type -AssemblyName System.Windows.Forms

# Embed the C# code into PowerShell using Add-Type
Add-Type -TypeDefinition @"
using System;
using System.Windows.Forms;
using System.Timers;

public class AlarmApp
{
    private System.Timers.Timer alarmTimer;
    private DateTime alarmTime;
    
    public void SetAlarm(int hours, int minutes, int seconds)
    {
        alarmTime = DateTime.Now.AddHours(hours).AddMinutes(minutes).AddSeconds(seconds);
        MessageBox.Show(String.Format("Alarm set for {0}", alarmTime.ToLongTimeString()), 
                        "Alarm Set", MessageBoxButtons.OK, MessageBoxIcon.Information);

        // Set up the timer
        alarmTimer = new System.Timers.Timer();
        alarmTimer.Interval = 1000; // Check every second
        alarmTimer.Elapsed += CheckAlarmTime;
        alarmTimer.Start();
    }

    private void CheckAlarmTime(object sender, ElapsedEventArgs e)
    {
        // Check if the current time has reached or passed the alarm time
        if (DateTime.Now >= alarmTime)
        {
            alarmTimer.Stop();
            // Display the alarm pop-up
            DialogResult result = MessageBox.Show("Time's up! Alarm is ringing!", 
                                                  "Alarm", MessageBoxButtons.OKCancel, 
                                                  MessageBoxIcon.Information);

            // If the user clicks OK, restart the alarm
            if (result == DialogResult.OK)
            {
                alarmTimer.Start(); // Restart the timer (example to restart the alarm)
            }
        }
    }

    public void CancelAlarm()
    {
        if (alarmTimer != null)
        {
            alarmTimer.Stop();
        }
        MessageBox.Show("Alarm canceled", "Cancel", MessageBoxButtons.OK, MessageBoxIcon.Information);
    }
}
"@ -Language CSharp

# Now use the C# class in PowerShell
$alarm = New-Object AlarmApp

# Set alarm for 0 hours, 0 minutes, and 10 seconds (example)
$alarm.SetAlarm(0, 0, 10)

# You can manually call the cancel alarm method using:
# $alarm.CancelAlarm()
