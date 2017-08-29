<# 6.5  #>

$Import = Import-Excel -Path ($env:USERPROFILE + "\Downloads\vmware-6.5-security-configuration-guide-ga-13-apr-17.xlsx")


$tempImport = $Import | Select-Object -Property "Guideline ID", "DISA STIG ID", "Default Value",
"Desired Value", "PowerCLI Command Assessment", "PowerCLI Command Remediation", "Able to set using Host Profile",
"Reference", "Hardening", "Site Specific Setting", "Audit Setting"

$temp2 = foreach($item in $tempImport)
{
    $output = [PSCustomObject][ordered]@{
        "GuidelineID" = ($item)."Guideline ID"
        "DISA_STIG_ID" = ($item)."DISA STIG ID"
        "DefaultValue" = ($item)."Default Value"
        "DesiredValue" = ($item)."Desired Value"
        "AssessmentCommand" = $null
        "RemediationCommand" = $null
        "HostProfile" = ($item)."Able to set using Host Profile"
        "Reference" = ($item).Reference
        "Hardening" = ($item).Hardening
        "SiteSpecificSetting" = ($item)."Site Specific Setting"
        "AuditSetting" = ($item)."Audit Setting"
    }

    If($item.'PowerCLI Command Assessment')
    {
        $output.AssessmentCommand = (($item)."PowerCLI Command Assessment")
    }
    If($item.'PowerCLI Command Remediation')
    {
        $output.RemediationCommand = (($item)."PowerCLI Command Remediation")
    }
    Write-Output $output
    Clear-Variable -Name output
}

$JSONImport2 = (ConvertTo-Json -InputObject $temp2)
#Export to JSON file to be included in module/tool as most users likely do not have the ImportExcel module.
$JSONImport2 | Out-File -FilePath .\vSphereSCG_65.json


#Load JSON
$vSCG65 = Get-Content -Path ".\vSphereSCG_65.json" | ConvertFrom-Json

#Display all of the VM type settings available in the JSON file
$Type = "VM"
$vSCG65 | Where-Object{$_.GuidelineID -cmatch ("^" + $Type)}

#Example using command from JSON via Invoke-Expression
$info = Invoke-Expression -Command ($vSCG65 | Where-Object{$_.GuidelineID -eq 'ESXi.Audit-SSH-Disable'}).AssessmentCommand






#vSphere 6.0 Guide Import & Convert to JSON
$Import6 = Import-Excel -Path "C:\Users\ITPR12377\Downloads\vSphere_6_0_Hardening_Guide_GA_15_Jun_2015.xlsx"

$temp3 = foreach($item in $Import6)
{
    $output = [PSCustomObject][ordered]@{
        "GuidelineID" = ($item)."Guideline ID"
        "DISA_STIG_ID" = ($item)."DISA STIG ID"
        "DefaultValue" = ($item)."Default Value"
        "DesiredValue" = ($item)."Desired Value"
        "AssessmentCommand" = $null
        "RemediationCommand" = $null
        "HostProfile" = ($item)."Able to set using Host Profile"
        "Reference" = ($item).Reference
        "Hardening" = ($item).Hardening
        "SiteSpecificSetting" = ($item)."Site Specific Setting"
        "AuditSetting" = ($item)."Audit Setting"
    }

    If($item.'PowerCLI Command Assessment')
    {
        $output.AssessmentCommand = (($item)."PowerCLI Command Assessment")
    }
    If($item.'PowerCLI Command Remediation')
    {
        $output.RemediationCommand = (($item)."PowerCLI Command Remediation")
    }
    Write-Output $output
    Clear-Variable -Name output
}

$temp3 | ConvertTo-Json | Out-File -FilePath .\vmware_60.json

$JSON3Import = Get-Content -Path .\vmware_60.json | ConvertFrom-Json

$JSON3Import


foreach($JSONItem in ($JSON3Import | Where-Object{$_.GuidelineID -like "ESXi*"}))
{
    Write-Host ("GuidelineID: " + $JSONItem.GuidelineID) -ForegroundColor Green
    Write-Host ("Command: " + $JSONItem.AssessmentCommand) -ForegroundColor Blue
    Invoke-Expression -Command $JSONItem.AssessmentCommand -WarningAction SilentlyContinue -InformationAction Continue
}

Invoke-Expression -Command ($JSON3Import | Where-Object{$_.GuidelineID -eq "ESXi.set-shell-interactive-timeout"}).AssessmentCommand


Get-VMHost | ForEach-Object{$_ | Select-Object Name, @{N='Config.HostAgent.plugins.solo.enableMob';E={$_ | Get-AdvancedSetting -Name Config.HostAgent.plugins.solo.enableMob | Select-Object -ExpandProperty Value}}}


Get-VMHost -Name espr1vmw01* | Select-Object Name, @{N='entireMobstuff';E={$_ | Get-AdvancedSetting -Name 'Config.HostAgent.plugins.solo.enableMob' | Select-Object -ExpandProperty Value}}

Get-VMHost -Name espr1vmw01* | Get-AdvancedSetting -Name 'Config.HostAgent.plugins.solo.enableMob' | Select-Object Value

Get-VMHost | Get-AdvancedSetting -Name Config.HostAgent.plugins.solo.enableMob |Set-AdvancedSetting -value "false"
# End vSphere 6.0


