function Set-vSCG_ESXi_Audit_SSH_Disable_65 {
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
    } #END

    PROCESS {
        foreach ($VMhost in $InputObject) {
            $ServiceList = Get-VMHostService -VMhost $VMhost
            $SSHservice = $ServiceList | Where-Object {$_.Key -eq "TSM-SSH"}
            If ($SSHservice.Running -eq $true) {
                # Commands to get the compliance here, store in variable $compliant
                $SSHservice | Stop-VMHostService -Confirm:$false | Out-Null
            } #END if
        } #END foreach
    } #END process

    END {
    } #END
}