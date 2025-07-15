<#
.SYNOPSIS
    This PowerShell script ensures that the maximum size of the Windows Application event log is at least 32768 KB (32 MB).

.NOTES
    Author          : Keerthana Peddi
    LinkedIn        : linkedin.com/in/keerthana-peddi/
    GitHub          : github.com/keerthana-peddi
    Date Created    : 2025-07-15
    Last Modified   : 2025-07-15
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000150

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-CC-000150.ps1 
#>

# Define registry path and values
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Power\PowerSettings\0e796bdb-100d-47d6-a2d5-f7d2daa51f51"
$valueName = "ACSettingIndex"
$desiredValue = 1  # Require password on wake (plugged in)

# Create registry key if it doesn't exist
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set the registry value
Set-ItemProperty -Path $regPath -Name $valueName -Value $desiredValue -Type DWord

# Confirm the setting
$currentValue = Get-ItemProperty -Path $regPath -Name $valueName
Write-Output "ACSettingIndex is set to $($currentValue.ACSettingIndex) (Expected: 1)"
