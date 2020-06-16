### .NAME
Write-Host "`n---------------------------------"
Write-Host "GetInfoUtil.ps1 Ver:1.2"
Write-Host "---------------------------------"
Write-Host ""

### .SYNOPSIS

###       Script to gather info about machine

### .DESCRIPTION

###       Gathers infor about RAM, HDD's etc

### .NOTES

###       
###       

### .LINK

### Author
###       Capt Daags
###       

### Ver 1.0
### 	  13/05/2020 - Initial creation.
					   
### Ver 1.1            
### 	  22/05/2020 - Cleaned up minor typos.
					   
### Ver 1.2            
### 	  16/06/2020 - Added IPv4 NIC details.

### .EXAMPLE

### .VARIABLES

## $PysicalMemory = 

### .MAINLINE


Write-Host "`n---------------------------"
Write-Host "Getting memory details"
Write-Host "---------------------------"
Write-Host ""

$PysicalMemory = Get-WmiObject -class "win32_physicalmemory" -namespace "root\CIMV2" -ComputerName "localhost" 
 
Write-Host "Memory Modules:" -ForegroundColor Green 
$PysicalMemory | Format-Table Tag,BankLabel,@{n="Capacity(GB)";e={$_.Capacity/1GB}},Manufacturer,PartNumber,Speed -AutoSize 
 
Write-Host "Total Memory:" -ForegroundColor Green 
Write-Host "$((($PysicalMemory).Capacity | Measure-Object -Sum).Sum/1GB)GB" 
 
$TotalSlots = ((Get-WmiObject -Class "win32_PhysicalMemoryArray" -namespace "root\CIMV2" -ComputerName localhost).MemoryDevices | Measure-Object -Sum).Sum 
Write-Host "`nTotal Memory Slots:" -ForegroundColor Green 
Write-Host $TotalSlots 
 
$UsedSlots = (($PysicalMemory) | Measure-Object).Count  
Write-Host "`nUsed Memory Slots:" -ForegroundColor Green 
Write-Host $UsedSlots 
 
If($UsedSlots -eq $TotalSlots) 
{ 
    Write-Host "All memory slots are filled up, none is empty!" -ForegroundColor Yellow 
} 


Write-Host "`n---------------------------"
Write-Host "Getting disk details"
Write-Host "---------------------------"
Write-Host ""
# We need to pipe to Out-Host per the formatting issude described in this post https://stackoverflow.com/questions/31441054/formatting-issues-missing-data-when-multiple-commands-use-select-object-within

Write-Host "Disk Details:" -ForegroundColor Green 

Get-WmiObject -Class win32_logicaldisk | select Name,FileSystem,VolumeName,@{n="Size / GB";e={[math]::truncate($_.freespace / 1GB)}} | Out-Host
# Get-WmiObject -Class win32_logicaldisk | select Name,FileSystem,VolumeName | Out-Host


Write-Host "`n---------------------------"
Write-Host "Getting MAC address details"
Write-Host "---------------------------"
Write-Host ""

Write-Host "MAC Address Details:" -ForegroundColor Green 

Get-WmiObject -Class win32_networkadapterconfiguration | select description, macaddress | Out-Host

Write-Host "`n---------------------------"
Write-Host "Getting IPv$ NIC details"
Write-Host "---------------------------"
Write-Host ""

Write-Host "IPv$ NIC Details:" -ForegroundColor Green 

Get-NetIPAddress -AddressFamily IPv4 | Out-Host


Write-Host "`n---------------------------"
Write-Host "     The Goodness Ends"
Write-Host "---------------------------"
Write-Host ""


