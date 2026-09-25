param(
    [string]$GameDir,
    [string]$StateDir
)

$ErrorActionPreference = 'Stop'
$appId = '2977260'
$baseName = 'Guild1_TraditionalChinese_DeutschSlot_P'
$extensions = @('pak', 'utoc', 'ucas')

function Test-GameDir([string]$path) {
    if (-not $path) { return $false }
    return (Test-Path -LiteralPath (Join-Path $path 'Europa1410.exe') -PathType Leaf) -and
           (Test-Path -LiteralPath (Join-Path $path 'Europa1410\Content\Paks\Europa1410-Windows.pak') -PathType Leaf)
}

function Find-GameDir {
    if (Test-GameDir $PSScriptRoot) { return $PSScriptRoot }
    if (Test-GameDir (Split-Path $PSScriptRoot -Parent)) { return (Split-Path $PSScriptRoot -Parent) }
    foreach ($key in @(
        "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App $appId",
        "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Steam App $appId"
    )) {
        $item = Get-ItemProperty -Path $key -ErrorAction SilentlyContinue
        if ($item -and (Test-GameDir $item.InstallLocation)) { return $item.InstallLocation }
    }
    $steamRoots = @()
    foreach ($key in @('HKCU:\Software\Valve\Steam', 'HKLM:\SOFTWARE\WOW6432Node\Valve\Steam')) {
        $item = Get-ItemProperty -Path $key -ErrorAction SilentlyContinue
        if ($item) {
            if ($item.SteamPath) { $steamRoots += $item.SteamPath }
            if ($item.InstallPath) { $steamRoots += $item.InstallPath }
        }
    }
    foreach ($root in ($steamRoots | Select-Object -Unique)) {
        $libraries = @($root)
        $vdf = Join-Path $root 'steamapps\libraryfolders.vdf'
        if (Test-Path -LiteralPath $vdf) {
            foreach ($line in [IO.File]::ReadAllLines($vdf)) {
                if ($line -match '"path"\s+"([^"]+)"') {
                    $doubleSlash = [string][char]92 + [string][char]92
                    $libraries += $matches[1].Replace($doubleSlash, [string][char]92)
                }
            }
        }
        foreach ($library in ($libraries | Select-Object -Unique)) {
            $apps = Join-Path $library 'steamapps'
            $manifest = Join-Path $apps "appmanifest_$appId.acf"
            if (Test-Path -LiteralPath $manifest) {
                $content = [IO.File]::ReadAllText($manifest)
                if ($content -match '"installdir"\s+"([^"]+)"') {
                    $candidate = Join-Path (Join-Path $apps 'common') $matches[1]
                    if (Test-GameDir $candidate) { return $candidate }
                }
            }
            $candidate = Join-Path (Join-Path $apps 'common') 'The Guild - Europa 1410'
            if (Test-GameDir $candidate) { return $candidate }
        }
    }
    return $null
}

function Get-Hash([string]$path) {
    return (Get-FileHash -LiteralPath $path -Algorithm SHA256).Hash.ToUpperInvariant()
}

$transaction = @()
$changesStarted = $false
try {
    if (-not $GameDir) { $GameDir = Find-GameDir }
    if (-not $GameDir) { $GameDir = Read-Host 'Enter the game directory containing Europa1410.exe' }
    if (-not (Test-GameDir $GameDir)) { throw "Invalid game directory: $GameDir" }
    $GameDir = (Resolve-Path -LiteralPath $GameDir).Path
    if (Get-Process -Name 'Europa1410-Win64-Shipping' -ErrorAction SilentlyContinue) { throw 'Close the game before installing' }
    $paks = Join-Path $GameDir 'Europa1410\Content\Paks'
    if (-not $StateDir) { $StateDir = Join-Path (Join-Path $env:LOCALAPPDATA 'Europa1410\Saved\LocAI') 'Guild1_DeutschSlot' }
    $StateDir = [IO.Path]::GetFullPath($StateDir)
    $receiptPath = Join-Path $StateDir 'install_receipt.json'
    $old = $null
    if (Test-Path -LiteralPath $receiptPath) {
        $old = Get-Content -LiteralPath $receiptPath -Raw -Encoding UTF8 | ConvertFrom-Json
        if ($old.Schema -ne 1 -or $old.GameDir -ne $GameDir) { throw 'Existing receipt belongs to another installation or schema' }
    }
    $manifest = @{}
    foreach ($line in (Get-Content -LiteralPath (Join-Path $PSScriptRoot 'payload.sha256') -Encoding ASCII)) {
        if ($line -match '^([^=]+)=([A-Fa-f0-9]{64})$') { $manifest[$matches[1]] = $matches[2].ToUpperInvariant() }
    }
    $items = @()
    $backupDir = Join-Path $StateDir 'backup'
    foreach ($extension in $extensions) {
        $name = "$baseName.$extension"
        if (-not $manifest.ContainsKey($name)) { throw "Missing manifest hash: $name" }
        $src = Join-Path $PSScriptRoot $name
        if (-not (Test-Path -LiteralPath $src) -or (Get-Hash $src) -ne $manifest[$name]) { throw "Payload hash mismatch: $name" }
        $dst = Join-Path $paks $name
        $backup = Join-Path $backupDir $name
        if ($old) {
            $prior = @($old.Items | Where-Object { $_.Name -eq $name })[0]
            if (-not $prior -or -not (Test-Path -LiteralPath $dst) -or (Get-Hash $dst) -ne $prior.InstalledHash) { throw "Previously installed file changed: $name" }
            if ($prior.HadOriginal -and -not (Test-Path -LiteralPath $backup)) { throw "Original backup missing: $name" }
            $hadOriginal = [bool]$prior.HadOriginal
        } else {
            $hadOriginal = Test-Path -LiteralPath $dst
        }
        $items += [pscustomobject]@{ Name = $name; Destination = $dst; Backup = $backup; HadOriginal = $hadOriginal; InstalledHash = $manifest[$name] }
    }
    if (-not (Test-Path -LiteralPath $backupDir)) { New-Item -ItemType Directory -Path $backupDir -Force | Out-Null }
    if (-not $old) {
        foreach ($item in $items) {
            if ($item.HadOriginal) { Copy-Item -LiteralPath $item.Destination -Destination $item.Backup -Force }
        }
    }
    foreach ($item in $items) {
        $snapshot = Join-Path $backupDir ("transaction_$($item.Name)")
        $exists = Test-Path -LiteralPath $item.Destination
        if ($exists) { Copy-Item -LiteralPath $item.Destination -Destination $snapshot -Force }
        $transaction += [pscustomobject]@{ Destination = $item.Destination; Snapshot = $snapshot; Existed = $exists }
    }
    $changesStarted = $true
    foreach ($item in $items) {
        $temp = "$($item.Destination).locai-tmp"
        Copy-Item -LiteralPath (Join-Path $PSScriptRoot $item.Name) -Destination $temp -Force
        if ((Get-Hash $temp) -ne $item.InstalledHash) { throw "Temporary copy hash mismatch: $($item.Name)" }
        Move-Item -LiteralPath $temp -Destination $item.Destination -Force
        if ((Get-Hash $item.Destination) -ne $item.InstalledHash) { throw "Installed copy hash mismatch: $($item.Name)" }
    }
    $receipt = [pscustomobject]@{ Schema = 1; GameDir = $GameDir; Items = $items; InstalledAt = [DateTime]::UtcNow.ToString('o') }
    [IO.File]::WriteAllText("$receiptPath.tmp", ($receipt | ConvertTo-Json -Depth 5), (New-Object System.Text.UTF8Encoding($false)))
    Move-Item -LiteralPath "$receiptPath.tmp" -Destination $receiptPath -Force
    foreach ($entry in $transaction) { if ($entry.Existed) { Remove-Item -LiteralPath $entry.Snapshot -Force -ErrorAction SilentlyContinue } }
    Write-Host 'Traditional Chinese pack installed. Select Traditional Chinese under Text Language and restart the game.' -ForegroundColor Green
    Write-Host "Receipt: $receiptPath"
    exit 0
} catch {
    if ($changesStarted) {
        foreach ($entry in $transaction) {
            if ($entry.Existed -and (Test-Path -LiteralPath $entry.Snapshot)) {
                Copy-Item -LiteralPath $entry.Snapshot -Destination $entry.Destination -Force -ErrorAction SilentlyContinue
            } elseif (-not $entry.Existed -and (Test-Path -LiteralPath $entry.Destination)) {
                Remove-Item -LiteralPath $entry.Destination -Force -ErrorAction SilentlyContinue
            }
        }
    }
    Write-Error $_
    exit 1
}
