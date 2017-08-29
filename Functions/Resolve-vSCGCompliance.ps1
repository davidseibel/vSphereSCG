function Resolve-vSCGCompliance {
    <#
        .SYNOPSIS
            Resolves the compliance for the specified guidelines from a set of objects.

        .DESCRIPTION
            Resolves the compliance for the specified guidelines from a set of objects.

        .PARAMETER InputObject
            Output from Get-vSCGCompliance.

        .PARAMETER Plugin
            The plugin(s) to use when remediate compliance guidelines.

        .NOTES
            Author(s):     : 2017 VMworld US Hackathon Team 1
            Date Created   : 08/25/2017
            Date Modified  : 08/25/2017
    #>

    $Invocation = (Get-Variable MyInvocation -Scope 1).Value
    $path = "$(Split-Path $Invocation.MyCommand.Path)\SCG_6.5\SCG_6.5.xml"
    $xml = [xml](Get-Content $path)
    
    foreach ($guideline in $xml.vSCG.Guideline) {
        if ($guideline.FunctionSet -ne "unsupported") {
            # Call $guideline.FunctionGet
        } else {
            Write-Warning "Guideline '$($guideline.Name)' cannot be retrieved with this function!"
        }
    }

    # Loop through compliance objects

      # if not compliant
        # Read XML file for Set function

        # if Set function exists
          # Call set function
        # else (if set function does not exist)
          # Throw warning that guideline cannot be remediated
        # end if

      # end if

    # end loop
    PROCESS {
        foreach ($object in $InputObject) {
            foreach ($guideline in $xml.vSCG.Guideline) {
                if ($guideline.FunctionSet -ne "unsupported") {
                    # Call $guideline.FunctionSet
                    Invoke-Expression ('$object | ' + $guideline.FunctionSet)

                } else {
                    Write-Warning "Guideline '$($guideline.Name)' cannot be retrieved with this function!"
                }
            }
        }
    }
}
