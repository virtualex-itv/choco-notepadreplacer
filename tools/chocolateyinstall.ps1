$ErrorActionPreference = 'Stop'
$toolsDir              = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageName           = 'notepadreplacer'
$fileType              = 'EXE'
$softwareName          = "Notepad Replacer*"
$url                   = 'https://binaryfortressdownloads.com/Download/BFSFiles/116/NotepadReplacerSetup-1.2.exe'
$checksum              = '5B5440240BF7FF23E28F1F8574B2C62FD5039E9FB8648E992392F1F27D1606E7'
$checksumType          = 'sha256'
$pp                    = Get-PackageParameters

if ( $pp.NOTEPAD ) {
        $notepadDir = $pp.NOTEPAD
        Write-Host "`nSetting $notepadDir as the default notepad application..." -ForegroundColor Yellow
        Write-Host ""

        $packageArgs = @{
          packageName    = $packageName
          fileType       = $fileType
          url            = $url
          validExitCodes = @(0, 3010)
          silentArgs     = '/NOTEPAD="' + $notepadDir + '" /VERYSILENT'
          softwareName   = $softwareName
          checksum       = $checksum 
          checksumType   = $checksumType
        }

        Install-ChocolateyPackage @packageArgs
} else {
        Set-PowerShellExitCode 1
        throw '/NOTEPAD parameter and application path required...
example: choco install notepadreplacer --params "/NOTEPAD:C:\Program Files\Notepad++\notepad++.exe"'
		exit
}
