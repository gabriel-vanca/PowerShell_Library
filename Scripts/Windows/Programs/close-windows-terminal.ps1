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

& "$PSScriptRoot/close-program.ps1" "Windows Terminal" "WindowsTerminal" "WindowsTerminal"





