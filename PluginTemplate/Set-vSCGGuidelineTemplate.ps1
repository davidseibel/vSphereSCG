function Set-vSCGGuidelineTemplate {
    <#
        .SYNOPSIS
            Sets a guideline on a set of objects.

        .DESCRIPTION
            Sets a guideline on a set of objects.

        .PARAMETER InputObject
            The object(s) to remediate.

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

    }

    PROCESS {
        foreach ($object in $InputObject) {
            if ($object -is [inserttypehere]) {
                # Commands to modify the object here
            } else {
                throw "Unsupported object type!"
            }
        }
    }

    END {

    }
}
