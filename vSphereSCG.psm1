# Load Functions
$ScriptPath = Split-Path $MyInvocation.MyCommand.Path
$functions = @()
Try {
    # Load module functions
    Get-ChildItem "$ScriptPath\Functions\*.ps1" | Select-Object -Expand FullName | ForEach {
        $function = Split-Path $_ -Leaf
        $functions += $function.Split(".")[0]
        . $_
    }

    # Load plugin functions
    foreach ($folder in (Get-ChildItem $ScriptPath -Directory)) {
        Get-ChildItem "$($folder.FullName)\*.ps1" | Select-Object -Expand FullName | ForEach {
            $function = Split-Path $_ -Leaf
            $functions += $function.Split(".")[0]
            . $_
        }
    }
} Catch {
    Write-Warning ("{0}: {1}" -f $function, $_.Exception.Message)
    Continue
}