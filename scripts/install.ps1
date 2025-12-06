param(
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$PesdeArgs
)

# We want to make sure Rojo is not Live-Syncing because it will cause an error
$port = 34872 # Default Rojo port
$listener = Get-NetTCPConnection -LocalPort $port -ErrorAction SilentlyContinue

if ($listener -and $listener.State -eq "Listen") {
    Write-Warning "Stop your Rojo Live-Sync server before running this script."
}
else {
    pesde install @PesdeArgs
    
    $testezPath = "roblox_packages\.pesde\roblox_testez@0.4.1"
    if (Test-Path $testezPath) {
        Remove-Item -Recurse -Force $testezPath
        Write-Host "Removed roblox_testez@0.4.1 from Packages/__Index."
    }
    else {
        Write-Host "roblox_testez@0.4.1 not found in Packages/__Index."
    }

    
    $reactContents = "-- selene: allow(global_usage)`n_G.__DEV__ = game:GetService('RunService'):IsStudio()`n"
    $reactContents = $reactContents + (Get-Content -Path .\Packages\React.lua -Encoding ASCII -Raw)

    Set-Content -Path .\roblox_packages\React.lua -Value $reactContents -Encoding ASCII

    rojo sourcemap --output sourcemap.json default.project.json
}