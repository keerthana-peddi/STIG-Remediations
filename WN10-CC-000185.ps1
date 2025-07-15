<#
.SYNOPSIS
    This PowerShell script ensures that the default autorun behavior is configured to prevent autorun commands.

.NOTES
    Author          : Keerthana Peddi
    LinkedIn        : linkedin.com/in/keerthana-peddi/
    GitHub          : github.com/keerthana-peddi
    Date Created    : 2024-09-09
    Last Modified   : 2024-09-09
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000185

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-CC-000185.ps1 
#>

# Define registry path and value
$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer"
$valueName = "NoAutorun"
$desiredValue = 1  # Block autorun commands

# Create the registry key if it doesn't exist
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set the NoAutorun value
Set-ItemProperty -Path $regPath -Name $valueName -Value $desiredValue -Type DWord

# Confirm the setting
$currentValue = Get-ItemProperty -Path $regPath -Name $valueName
Write-Output "NoAutorun is set to $($currentValue.NoAutorun) (Expected: 1)"
