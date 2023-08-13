<#
.SYNOPSIS
	Closes the Windows Terminal app
.DESCRIPTION
	This PowerShell script closes the Windows Terminal application gracefully.
.EXAMPLE
	PS> ./close-windows-terminal
.LINK
	https://github.com/gabrielvanca/PowerShell_Library
.NOTES
	Author: Gabriel Vanca
#>

Write-Host "Terminating Terminal"

# & "$PSScriptRoot/close-program.ps1" "Windows Terminal" "WindowsTerminal" "WindowsTerminal"

try{
	$scriptPath = "https://raw.githubusercontent.com/gabriel-vanca/PowerShell_Library/main/Scripts/Windows/Software/close_program.ps1"
	$WebClient = New-Object Net.WebClient
	$close_program = $WebClient.DownloadString($scriptPath)
	$close_program_sb = [Scriptblock]::Create($close_program)
	$param1 = "Windows Terminal"
	$param2 = "WindowsTerminal"
	$param3 = "WindowsTerminal"
	Invoke-Command -ScriptBlock $close_program_sb -ArgumentList [$param1, $param2, $param3] -NoNewScope
	Write-Host "Terminal successfully terminated"
} catch {
	"Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}