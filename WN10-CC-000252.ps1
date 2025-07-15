<#
.SYNOPSIS
    This PowerShell script ensures that Windows 10 must be configured to disable Windows Game Recording and Broadcasting.

.NOTES
    Author          : Keerthana Peddi
    LinkedIn        : linkedin.com/in/keerthana-peddi/
    GitHub          : github.com/keerthana-peddi
    Date Created    : 2024-07-16
    Last Modified   : 2024-07-16
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000252

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-CC-000252.ps1 
#>

# Define registry key and value
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR"
$valueName = "AllowGameDVR"
$desiredValue = 0  # Disable GameDVR

# Create registry key if it doesn't exist
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set the registry value
Set-ItemProperty -Path $regPath -Name $valueName -Value $desiredValue -Type DWord

# Confirm the setting
$currentValue = Get-ItemProperty -Path $regPath -Name $valueName
Write-Host "✅ GameDVR is disabled (AllowGameDVR = $($currentValue.AllowGameDVR)) per STIG WN10-CC-000252." -ForegroundColor Green
