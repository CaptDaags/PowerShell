### .NAME
Write-Host "`n---------------------------------"
Write-Host "GetWiFiCertDetails.ps1 Ver:1.0"
Write-Host "---------------------------------"
Write-Host ""

### .SYNOPSIS

###       Script to gather details of installed certificates and WLAN profiles

### .DESCRIPTION

###       The certificate details of Local computer - Personal
###       Also show details of configure WLAN profiles

### .NOTES

###       

### .LINK

### Author
###       Capt Daags

### Ver 1.0
### 	  30/05/2020 - Initial creation.

### Ver 1.1
### 	  

### .EXAMPLE

### .VARIABLES

## $PysicalMemory = 

### .MAINLINE


Write-Host "`n---------------------------"
Write-Host "Getting certificate details"
Write-Host "---------------------------"
Write-Host ""

Get-ChildItem -Path Cert:\LocalMachine\My -Recurse | Where-Object {$_.PSISContainer -eq $false} | Format-Table Subject, FriendlyName, Thumbprint -AutoSize

Write-Host "`n---------------------------"
Write-Host "   Now Show WiFi Profiles"
Write-Host "---------------------------"
Write-Host ""


netsh.exe wlan show profiles

Write-Host "`n---------------------------"
Write-Host "     The Goodness Ends"
Write-Host "---------------------------"
Write-Host ""




