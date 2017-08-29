function Set-vSCG_ESXi_Audit_MOB_Disable_65 {
    <#
        .SYNOPSIS
            Gets the compliance status of a guideline from a set of objects.

        .DESCRIPTION
            Gets the compliance status of a guideline from a set of objects.

        .PARAMETER InputObject
            The object(s) to check for compliance.

        .NOTES
            Author(s):     : 2017 VMworld US Hackathon Team 1
            Date Created   : 08/25/2017
            Date Modified  : 08/28/2017
    #>    
    [CmdletBinding()]
    param(
      [Parameter(Position = 0, ValueFromPipeline = $true)]
      $InputObject
    )

    BEGIN {
        $result = @()
    } #END

    PROCESS {
        foreach ($VMhost in $InputObject) {        
           $mob = $vmhost | Get-AdvancedSetting -Name Config.HostAgent.plugins.solo.enableMob

            if($mob.Value -eq "true") {
                $VMhost | Get-AdvancedSetting -Name Config.HostAgent.plugins.solo.enableMob | Set-AdvancedSetting -value "false"
            }
            $result += [PSCustomObject]@{
                Entity = $vmhost
                Compliant = $null
            }
        } #END foreach
    } #END process

    END {
        return $result
    } #END
}