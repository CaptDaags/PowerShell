
### .NAME
Write-Host "`n---------------------------------"
Write-Host "CPU_TempZoneLogger.ps1 Ver:1.0"
Write-Host "---------------------------------"
Write-Host ""

### .SYNOPSIS

###       Script to gather CPU tempreture zone and log it.

### .DESCRIPTION

###       Measuring the effectivness of the fan kit for the VTC

### .NOTES

###       This must be run as an administrator

### .LINK

### Author
###       CaptDaags

### .EXAMPLE

### .VARIABLES

$logfile = "c:\temp\CPU_TempZoneLogger_Data.log"

### FUNCTIONS ###

function Get-Temperature {
    $t = Get-WmiObject MSAcpi_ThermalZoneTemperature -Namespace "root/wmi" | Select-Object -Property InstanceName,CurrentTemperature | where InstanceName -eq "ACPI\ThermalZone\CPUZ_0"
    $returntemp = @()

    foreach ($temp in $t.CurrentTemperature)
    {

    $currentTempKelvin = $temp / 10
    $currentTempCelsius = $currentTempKelvin - 273.15

    $currentTempFahrenheit = (9/5) * $currentTempCelsius + 32

    $returntemp += $currentTempCelsius.ToString() + " C " 
    
	}
    $date_time = (Get-Date -Format "yyyy-MM-dd HH:mm:ss")
    return $date_time + " " + $returntemp
}

#################
### .MAINLINE ###
#################

#infinite loop for calling connect function  

while(1)
{

   Get-Temperature | Add-Content $logfile

   start-sleep -seconds 10

}







