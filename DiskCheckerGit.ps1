# REQUIRES -Version 2.0 or later

<#
.SYNOPSIS

Chron job to report back disk usage and status of critical services.

.DESCRIPTION

This script is designed to be run as a chron job on a regular basis
and report back disk space available on the device on which is was
run.

The script will have to be signed with a local user certificate to
be able to be run. To do this, run the following at a powershell
prompt:

get-help about_signing


.NOTES

	File Name	: DiskspaceCheckerGit.ps1
	Author		: CaptDaags
	Prereqs		: Windows Power Shell, local certificate
	Version		: 0.91

.LINK

    Ver 0.91

.EXAMPLE

#>


# Now this is for spooling to output
#
#
start-transcript -path c:\Temp\DiskChecker_OutPut.log -append


# Lets kick off with a ping check of the Servers
#
Write-Host "--- Now Checking Connectivity To Servers (Only Errors Will Be Reported"

$servers = "192.168.1.1", "192.168.1.2", "192.168.1.3"
Foreach($s in $servers)
{
	if (!(Test-Connection -Cn $s -BufferSize 16 -Count 1 -ea 0 -quiet))
		{
			"Problem connecting to $s"
		}
}

Write-Host "--- Now Checking To See If Important Services Are Running"
write-host "--- If nothing returned then service not installed"
# ToDo Make this return an error if service not installed

# Hyper V Virtual Machine Management Service Check
Write-Host "--- Checking The Hyper-V VM Mgmt Service"
Get-WMIObject -Query "Select * from win32_service where name='vmms'"

Write-Host "--- Now Checking The Host Physical & Logical Drive Space"
Get-WMIObject Win32_LogicalDisk -ComputerName 127.0.0.1 | Select SystemName, DeviceID, VolumeName, @{Name="Total Size (GB)"; Expression={"{0:N1}" -F ($_.Size/1GB)}}, @{Name="Free Space (GB)"; Expression={"{0:N1}" -F ($_.Freespace/1GB)}}, @{Name="Free Space %"; Expression={"{0:N1}" -F (($_.Freespace/$_.Size)*100)}}

# This is the line to stop the recording of the output of the script
#
#
stop-transcript

# --EOF--
