<#
.SYNOPSIS
    This PowerShell script ensures that the password history must be configured to 24 passwords remembered.

.NOTES
    Author          : Keerthana Peddi
    LinkedIn        : linkedin.com/in/keerthana-peddi/
    GitHub          : github.com/keerthana-peddi
    Date Created    : 2024-07-16
    Last Modified   : 2024-07-16
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AC-000020

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-AC-000020.ps1 
#>


# Desired STIG-compliant value
$passwordHistorySize = 24

# Temporary file paths
$tempInf = "$env:TEMP\secpol_password.inf"
$tempLog = "$env:TEMP\secpol_password.log"

# Export current security policy to temp INF
secedit /export /cfg $tempInf /quiet

# Read INF file contents
$config = Get-Content $tempInf

# Check and update or add PasswordHistorySize
if ($config -match "^PasswordHistorySize") {
    $config = $config -replace "^PasswordHistorySize\s*=\s*\d+", "PasswordHistorySize = $passwordHistorySize"
} else {
    $config += "PasswordHistorySize = $passwordHistorySize"
}

# Write updated config back to file
$config | Set-Content $tempInf -Encoding ASCII

# Apply changes
secedit /configure /db secedit.sdb /cfg $tempInf /log $tempLog /quiet

# Clean up
Remove-Item $tempInf, $tempLog -ErrorAction SilentlyContinue

Write-Host "✅ Password history set to $passwordHistorySize passwords remembered (STIG WN10-AC-000020)." -ForegroundColor Green
