<#
.SYNOPSIS
    This PowerShell script ensures that the Security event log size must be configured to 1024000 KB or greater.

.NOTES
    Author          : Keerthana Peddi
    LinkedIn        : linkedin.com/in/keerthana-peddi/
    GitHub          : github.com/keerthana-peddi
    Date Created    : 2024-07-16
    Last Modified   : 2024-07-16
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000505

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-AU-000505.ps1 
#>

# Registry configuration
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Security"
$valueName = "MaxSize"
$desiredSizeKB = 1024000  # 1024000 KB = 1 GB (minimum)

# Create key if not exists
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set MaxSize if not set or if less than desired
$current = Get-ItemProperty -Path $regPath -Name $valueName -ErrorAction SilentlyContinue

if ($null -eq $current -or $current.$valueName -lt $desiredSizeKB) {
    Set-ItemProperty -Path $regPath -Name $valueName -Value $desiredSizeKB -Type DWord
    Write-Host "✅ MaxSize set to $desiredSizeKB KB under Security event log (STIG WN10-AU-000505)." -ForegroundColor Green
} else {
    Write-Host "ℹ️ MaxSize is already set to $($current.$valueName) KB (compliant)." -ForegroundColor Yellow
}

 
