function Get-vSCGCompliance {
    <#
        .SYNOPSIS
            Gets the compliance status the specified guidelines from a set of objects.

        .DESCRIPTION
            Gets the compliance status the specified guidelines from a set of objects.

        .PARAMETER InputObject
            The object(s) to check for compliance.

        .PARAMETER Guideline
            The guideline(s) to check compliance against.

        .PARAMETER Plugin
            The plugin(s) to retrieve compliance guidelines from.

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
        $Invocation = (Get-Variable MyInvocation -Scope 1).Value
        $path = "$(Split-Path $Invocation.MyCommand.Path)\SCG_6.5\SCG_6.5.xml"
        $xml = [xml](Get-Content $path)

        $result = @()
    }
    
    PROCESS {
        foreach ($object in $InputObject) {
            foreach ($guideline in $xml.vSCG.Guideline) {
                if ($guideline.FunctionGet -ne "unsupported") {
                    # Call $guideline.FunctionGet
                    $getResult = Invoke-Expression ('$object | ' + $guideline.FunctionGet)

                    $result += [PSCustomObject]@{
                        Entity = $getResult.Entity
                        Compliant = $getResult.Compliant
                        GuidelineName = $guideline.Name
                        GuidelineDescription = $guideline.Description
                    }
                } else {
                    Write-Warning "Guideline '$($guideline.Name)' cannot be retrieved with this function!"
                }
            }
        }
    }

    END {
        return $result
    }    
}