<#
    .SYNOPSIS
    Installs all fonts from a directory

    .DESCRIPTION
    Installs all fonts from a directory

    .PARAMETER FontsSourcePath
    The path to an individual font to install, or a directory containing fonts to install.

    .EXAMPLE
    Install-Fonts -Path "$env:Temp\Fonts_to_install"

    Installs all fonts from the "$env:Temp\Fonts_to_install" directory. Fonts will be installed system-wide.

    .LINK
    TODO
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory = $True)] [ValidateNotNullOrEmpty()] [String]$FontsSourcePath
)

#Requires -RunAsAdministrator

# ($NULL -eq $IsWindows) checks for Windows Sandbox enviroment
if($IsWindows -or ($NULL -eq $IsWindows)) {
    Write-Host "Windows deployment detected."
    $scriptPath = "https://raw.githubusercontent.com/gabriel-vanca/PowerShell_Library/main/Scripts/Windows/Fonts/Install-Fonts.ps1"
} else {
    if($IsLinux) {
        Write-Host "Linux deployment detected."
        $scriptPath = "https://raw.githubusercontent.com/gabriel-vanca/PowerShell_Library/main/Scripts/Linux/Fonts/Install-Fonts.ps1"
    }  else {
        if($IsMacOS) {
            Write-Host "MacOS deployment detected."
            $scriptPath = "https://raw.githubusercontent.com/gabriel-vanca/PowerShell_Library/main/Scripts/MacOS/Fonts/Install-Fonts.ps1"
        }
    }
}

$WebClient = New-Object Net.WebClient
$deploymentScript = $WebClient.DownloadString($scriptPath)
$deploymentScript = [Scriptblock]::Create($deploymentScript)
Invoke-Command -ScriptBlock $deploymentScript -ArgumentList ($FontsSourcePath) -NoNewScope
