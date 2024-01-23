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
    https://github.com/gabriel-vanca/PowerShell_Library/blob/main/Scripts/Linux/Fonts/Install-Fonts.ps1
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory = $True)] [ValidateNotNullOrEmpty()] [String]$FontsSourcePath
)

#Requires -RunAsAdministrator

$ValidExts = @('.otf', '.ttf')
$FontFiles = @(Get-ChildItem -Path FontsSourcePath  -ErrorAction Stop | Where-Object Extension -In $ValidExts)

#  https://linuxreviews.org/HOWTO_Install_Fonts
$FontInstallPath = "/usr/local/share/fonts/custom"

if(!(Test-Path -path $FontInstallPath)) {
    New-Item -ItemType directory -Path $FontInstallPath
}
# Make sure that folder is world readable
sudo chmod -R a+rX $FontInstallPath
# Make X aware of that folder by making a symbolic link in /etc/X11/fontpath.d
sudo ln -s $FontInstallPath "/etc/X11/fontpath.d/custom-systemwide-fonts"

foreach ($fontFile in $FontFiles) {
    Copy-Item $fontFile -Destination $FontInstallPath
}

# Make sure that folder is world readable
sudo chmod -R a+rX $FontInstallPath

try {
    Write-Host "Installing fontconfig via Homebrew" -ForegroundColor DarkYellow
    brew install fontconfig
    brew update && brew upgrade fontconfig
} catch {
    Write-Error "Installing via Homebrew failed"
    Write-Host "Installing manually" -ForegroundColor DarkYellow
    sudo apt install fontconfig
}

# Make newly installed fonts available in an existing session
sudo fc-cache -v -f
