# We want to make sure Rojo is not Live-Syncing because it will cause an error
$port = 34872 # Default Rojo port
$listener = Get-NetTCPConnection -LocalPort $port -ErrorAction SilentlyContinue

if ($listener -and $listener.State -eq "Listen") {
    Write-Warning "Stop your Rojo Live-Sync server before running this script."
}
else {
    wally install

    rojo sourcemap --output sourcemap.json default.project.json

    wally-package-types --sourcemap sourcemap.json Packages DevPackages
    
    $testezPath = "Packages\_Index\roblox_testez@0.4.1"
    if (Test-Path $testezPath) {
        Remove-Item -Recurse -Force $testezPath
        Write-Host "Removed roblox_testez@0.4.1 from Packages/__Index."
    }
    else {
        Write-Host "roblox_testez@0.4.1 not found in Packages/__Index."
    }
}