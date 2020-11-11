### .DESCRIPTION
###     This disables the HYper-V Windows feature
###

# List features all
# (Get-WindowsOptionalFeature -Online -FeatureName '*') | Format-Table -Autosize
# (Get-WindowsOptionalFeature -Online -FeatureName '*').Count


Write-Host "`n---------------------------------"
Write-Host "Determine What Hyper-V is Enabled"
Write-Host "---------------------------------"
Write-Host ""


$features = Get-WindowsOptionalFeature -Online
Write-Host ('There are ' + $features.Count + ' Windows features available') -ForegroundColor Green
foreach($feature in $features)
{
    if($feature.FeatureName -like "Microsoft-Hyper*") # wildcard search
    {
        $feature
    }
}

Write-Host "`n---------------"
Write-Host "Disable Hyper-V"
Write-Host "----------------"
Write-Host ""

Disable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Hyper-V-All" 

(Get-WindowsOptionalFeature -Online -FeatureName 'Microsoft-Hyper-V-All').State

Write-Host "`n--------------------------------------"
Write-Host "Deleting Hyper-V Virtual Disk Directory"
Write-Host "---------------------------------------"
Write-Host ""

Remove-Item 'c:\MyVM_VHD' -Recurse

Write-Host "`n----"
Write-Host "ENDS"
Write-Host "----"
Write-Host ""


