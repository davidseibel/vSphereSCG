function Get-vSCGGuideline {
    <#
        .SYNOPSIS
            Gets guidelines available in this module and its plugins.

        .DESCRIPTION
            Gets guidelines available in this module and its plugins.

        .PARAMETER Plugin
            The plugins to retrieve compliance guidelines from.

        .NOTES
            Author(s):     : 2017 VMworld US Hackathon Team 1
            Date Created   : 08/25/2017
            Date Modified  : 08/29/2017
    #>
    [CmdletBinding()]
    param ()

    $moduleBase = $MyInvocation.MyCommand.Module.ModuleBase
    $excludedSubFolders = "Functions","PluginTemplate"

    $result = @()

    foreach ($folder in (Get-ChildItem -Path $moduleBase -Directory | Where-Object {$_.Name -notin $excludedSubFolders})) {
        $thisPluginName = Split-Path -Path $folder.FullName -Leaf
        $thisPluginPath = Join-Path -Path $folder.FullName -ChildPath "$thisPluginName.xml"
        $xml = [xml](Get-Content $thisPluginPath)
        $result += $xml.vSCG.Guideline
    }

    return $result
}