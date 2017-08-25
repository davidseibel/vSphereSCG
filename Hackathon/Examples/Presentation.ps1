Connect-VIServer <hostname>

# Working with guidelines
Get-vSCGGuideline
Get-vSCGGuideline -Plugin Test | Disable-vSCGGuideline

# Reviewing the status of compliance
Get-VMHost | Get-vSCGCompliance
Get-VMHost | Get-vSCGCompliance -Plugin SCG  # Optionally specify which plugins to use
Get-VM | Get-vSCGCompliance

# Remediate an entity for compliance
Get-VMHost | Resolve-vSCGCompliance
Get-VMHost | Get-vSCGCompliance | Out-GridView -Passthru | Resolve-vSCGCompliance  # Select guidelines individually to resolve

Disconnect-VIServer * -Confirm:$false
