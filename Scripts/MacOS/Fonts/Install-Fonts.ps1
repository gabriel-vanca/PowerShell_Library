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

$ValidExts = @('.otf', '.ttf')
$FontFiles = @(Get-ChildItem -Path FontsSourcePath  -ErrorAction Stop | Where-Object Extension -In $ValidExts)

#  https://apple.stackexchange.com/questions/367616/trying-to-install-fonts-to-font-book-mac-using-the-terminal
$FontInstallPath = "/Library/Fonts"

if(!(Test-Path -path $FontInstallPath)) {
    New-Item -ItemType directory -Path $FontInstallPath
}

foreach ($fontFile in $FontFiles) {
    Copy-Item $fontFile -Destination $FontInstallPath
}

# Clear font cache
# will remove fontd System or User databases along with any cache files.
# New databases will be regenerated from fonts
# installed the standard font directories after the user logs out,
# restarts, or the fontd server is restarted.
# https://osxdaily.com/2015/01/08/clear-font-caches-databases-mac-os-x/
# https://gist.github.com/jaredhowland/2da83f0cc0fbb1ac523f
sudo atsutil databases -remove
atsutil server -shutdown
atsutil server -ping
