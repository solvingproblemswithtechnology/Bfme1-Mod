Get-Content .env | ForEach-Object {
    $Name, $Value = $_.Split('=')
    Set-Content env:\$Name $Value
}

./build.ps1

$BuildedModPath = (Get-ChildItem ".\dist\Mod.big").FullName
& "$($env:BFME1_LOCATION)\lotrbfme.exe" -mod $BuildedModPath