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
$close_program = Invoke-RestMethod https://raw.githubusercontent.com/gabriel-vanca/ `
									PowerShell_Library/main/Scripts/Windows/ `
									Software/close_program.ps1
Invoke-Expression $close_program "Windows Terminal" "WindowsTerminal" "WindowsTerminal"





