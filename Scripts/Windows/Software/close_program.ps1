<#
.SYNOPSIS
	Closes a program's processes 
.DESCRIPTION
	This PowerShell script closes a program's processes gracefully.
.PARAMETER FullProgramName
	Specifies the full program name
.PARAMETER ProgramName
	Specifies the program name
.PARAMETER ProgramAliasName
	Specifies the program alias name
.EXAMPLE
	PS> ./close-program "Google Chrome" "chrome.exe"
.LINK
	https://github.com/gabriel-vanca/PowerShell_Library/blob/main/Scripts/Windows/Software/close_program.ps1
	https://github.com/fleschutz/PowerShell/blob/master/Scripts/close-program.ps1
.NOTES
	Author: Gabriel Vanca, Markus Fleschutz
#>

param([string]$FullProgramName = "", [string]$ProgramName = "", [string]$ProgramAliasName = "")

try {
	if ($ProgramName -eq "") {
		get-process | where-object {$_.mainWindowTitle} | format-table Id, Name, mainWindowtitle -AutoSize
		$ProgramName = read-host "Enter program name"
	}
	if ($FullProgramName -eq "") {
		$FullProgramName = $ProgramName
	}

	$Processes = get-process -name $ProgramName -errorAction 'silentlycontinue'
	if ($Processes.Count -ne 0) {
		foreach ($Process in $Processes) {
			$Process.CloseMainWindow() | Out-Null
		} 
		Start-Sleep -milliseconds 100
		stop-process -name $ProgramName -force -errorAction 'silentlycontinue'
	} else {
		$Processes = get-process -name $ProgramAliasName -errorAction 'silentlycontinue'
		if ($Processes.Count -eq 0) {
			Write-Warning "$FullProgramName isn't running"
		} else {
			foreach ($Process in $Processes) {
				$_.CloseMainWindow() | Out-Null
			} 
			Start-Sleep -milliseconds 100
			stop-process -name $ProgramName -force -errorAction 'silentlycontinue'
		}
	}
	if ($($Processes.Count) -eq 1) {
		Write-Host "$FullProgramName closed, 1 process stopped"
	} else {
		Write-Host "$FullProgramName closed, $($Processes.Count) processes stopped"
	}
} catch {
	Write-Host "Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])" -ForegroundColor DarkRed
}
