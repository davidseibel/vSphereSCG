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
            Date Modified  : 08/25/2017
    #>
}



# Standard input
  InputObject (an array of any object type, accept pipeline input)

# Standard output
  Entity (VM/Host)
  Compliant (true/false)
  Verbose output for detailed non-compliance info
