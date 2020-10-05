
# This gets the actual current CPU clock speed rather than just the base speed.
# This is handy to see if the CPU is being throttled from the base speed.
# Source: Senor-Rico

$MaxClockSpeed = (Get-CimInstance CIM_Processor).MaxClockSpeed
$ProcessorPerformance = (Get-Counter -Counter "\Processor Information(_Total)\% Processor Performance").CounterSamples.CookedValue
$CurrentClockSpeed = $MaxClockSpeed*($ProcessorPerformance/100)
Write-Host "Current Processor Speed: " -ForegroundColor Yellow -NoNewLine
Write-Host $CurrentClockSpeed
