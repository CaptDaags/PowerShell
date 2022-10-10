
# Mover.ps1
# This mimics user activity
# For $cycles send a numlock and another numlock key press
# every -Seconds. Note the number of cycles is effectively
# multiplied by -Seconds will tell how long it will run.

param($cycles = 2400)

$myshell = New-Object -com "Wscript.Shell"

for ($i = 0; $i -lt $cycles; $i++) {
  Start-Sleep -Seconds 15
  $myshell.sendkeys("{NUMLOCK}{NUMLOCK}")
}
