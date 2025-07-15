<#
.SYNOPSIS
    This PowerShell script ensures that Passwords must, at a minimum, be 14 characters.

.NOTES
    Author          : Keerthana Peddi
    LinkedIn        : linkedin.com/in/keerthana-peddi/
    GitHub          : github.com/keerthana-peddi
    Date Created    : 2024-07-16
    Last Modified   : 2024-07-16
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AC-000035

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-AC-000035.ps1 
#>
# Desired value per STIG
$minPasswordLength = 14

# Temporary file paths
$tempInf = "$env:TEMP\secpol_minpw.inf"
$tempLog = "$env:TEMP\secpol_minpw.log"

# Export current local security settings
secedit /export /cfg $tempInf /quiet

# Load contents
$config = Get-Content $tempInf

# Update or add MinimumPasswordLength
if ($config -match "^MinimumPasswordLength") {
    $config = $config -replace "^MinimumPasswordLength\s*=\s*\d+", "MinimumPasswordLength = $minPasswordLength"
} else {
    $config += "MinimumPasswordLength = $minPasswordLength"
}

# Save the modified config
$config | Set-Content $tempInf -Encoding ASCII

# Apply the updated policy
secedit /configure /db secedit.sdb /cfg $tempInf /log $tempLog /quiet

# Clean up
Remove-Item $tempInf, $tempLog -ErrorAction SilentlyContinue

Write-Host "✅ Minimum password length set to $minPasswordLength characters (STIG WN10-AC-000035)." -ForegroundColor Green
