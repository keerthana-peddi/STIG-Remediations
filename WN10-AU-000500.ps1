<#
.SYNOPSIS
    This PowerShell script ensures that the maximum size of the Windows Application event log is at least 32768 KB (32 MB).

.NOTES
    Author          : Keerthana Peddi
    LinkedIn        : linkedin.com/in/keerthana-peddi
    GitHub          : github.com/keerthana-peddi
    Date Created    : 2024-07-15
    Last Modified   : 2024-07-15
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000500

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-AU-000500.ps1 
#>

# Define registry path and value
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Application"
$valueName = "MaxSize"
$valueData = 0x8000  # 32768 in decimal

# Create the registry key if it doesn't exist
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set the registry value and output success message
Set-ItemProperty -Path $regPath -Name $valueName -Value $valueData -Type DWord
Write-Output "Registry value 'MaxSize' set to 0x8000 (32768) under Application Event Log."
