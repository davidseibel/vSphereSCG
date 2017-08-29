function Get-vSCGGuidelineTemplate {
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
    }

    PROCESS {
        foreach ($object in $InputObject) {
            if ($object -is [inserttypehere]) {
                # Commands to get the compliance here, store in variable $compliant
                $compliant = 

                # Write-Verbose "More info about why this object is not compliant"
                $result += [PSCustomObject]@{
                    Entity = $object
                    Compliant = $compliant
                }
            } else {
                throw "Unsupported object type!"
            }
        }
    }

    END {
        return $result
    }
}



# Standard input
  InputObject (an array of any object type, accept pipeline input)

# Standard output
  Entity (VM/Host)
  Compliant (true/false)
  Verbose output for detailed non-compliance info
