<#
.SYNOPSIS
    This PowerShell script ensures that Windows 10 account lockout duration must be configured to 15 minutes or greater.

.NOTES
    Author          : Keerthana Peddi
    LinkedIn        : linkedin.com/in/keerthana-peddi/
    GitHub          : github.com/keerthana-peddi
    Date Created    : 2024-07-16
    Last Modified   : 2024-07-16
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AC-000005

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-AC-000005.ps1 
#>


# Desired STIG-compliant value
$lockoutDuration = 15  # 15 minutes; 0 is also acceptable per STIG

# Temp files
$tempInf = "$env:TEMP\secpol.inf"
$tempLog = "$env:TEMP\secpol.log"

# Export current security settings
secedit /export /cfg $tempInf /quiet

# Load content
$config = Get-Content $tempInf

# Update or add LockoutDuration
if ($config -match "^LockoutDuration") {
    $config = $config -replace "^LockoutDuration\s*=\s*\d+", "LockoutDuration = $lockoutDuration"
} else {
    $config += "LockoutDuration = $lockoutDuration"
}

# Save changes
$config | Set-Content $tempInf -Encoding ASCII

# Apply changes
secedit /configure /db secedit.sdb /cfg $tempInf /log $tempLog /quiet

# Clean up
Remove-Item $tempInf, $tempLog -ErrorAction SilentlyContinue

Write-Host "✅ Account lockout duration set to $lockoutDuration minutes as per STIG WN10-AC-000005." -ForegroundColor Green
