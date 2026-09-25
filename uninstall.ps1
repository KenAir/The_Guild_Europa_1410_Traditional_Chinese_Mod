param(
    [string]$GameDir,
    [string]$StateDir
)

$ErrorActionPreference = 'Stop'
function Get-Hash([string]$path) {
    return (Get-FileHash -LiteralPath $path -Algorithm SHA256).Hash.ToUpperInvariant()
}

try {
    if (-not $StateDir) { $StateDir = Join-Path (Join-Path $env:LOCALAPPDATA 'Europa1410\Saved\LocAI') 'Guild1_DeutschSlot' }
    $StateDir = [IO.Path]::GetFullPath($StateDir)
    $receiptPath = Join-Path $StateDir 'install_receipt.json'
    if (-not (Test-Path -LiteralPath $receiptPath)) { throw "No install receipt: $receiptPath" }
    $receipt = Get-Content -LiteralPath $receiptPath -Raw -Encoding UTF8 | ConvertFrom-Json
    if ($receipt.Schema -ne 1) { throw 'Unsupported receipt schema' }
    if ($GameDir -and ([IO.Path]::GetFullPath($GameDir) -ne $receipt.GameDir)) { throw 'Game directory differs from receipt' }
    $GameDir = $receipt.GameDir
    if (-not (Test-Path -LiteralPath (Join-Path $GameDir 'Europa1410.exe'))) { throw 'Game directory no longer exists' }
    if (Get-Process -Name 'Europa1410-Win64-Shipping' -ErrorAction SilentlyContinue) { throw 'Close the game before uninstalling' }
    $allowed = [IO.Path]::GetFullPath((Join-Path $GameDir 'Europa1410\Content\Paks')).TrimEnd('\') + '\'
    $expectedNames = @('Guild1_TraditionalChinese_DeutschSlot_P.pak', 'Guild1_TraditionalChinese_DeutschSlot_P.utoc', 'Guild1_TraditionalChinese_DeutschSlot_P.ucas')
    if (@($receipt.Items).Count -ne $expectedNames.Count) { throw 'Receipt item count mismatch' }
    foreach ($item in $receipt.Items) {
        if ($expectedNames -notcontains $item.Name) { throw "Unsafe item name: $($item.Name)" }
        $target = [IO.Path]::GetFullPath($item.Destination)
        if (-not $target.StartsWith($allowed, [StringComparison]::OrdinalIgnoreCase)) { throw "Unsafe target in receipt: $target" }
        if (-not (Test-Path -LiteralPath $target)) { throw "Installed file missing: $target" }
        if ((Get-Hash $target) -ne $item.InstalledHash) { throw "Installed file changed; leaving untouched: $target" }
        if ($item.HadOriginal -and -not (Test-Path -LiteralPath $item.Backup)) { throw "Backup missing: $($item.Backup)" }
    }
    foreach ($item in $receipt.Items) {
        if ($item.HadOriginal) {
            Copy-Item -LiteralPath $item.Backup -Destination "$($item.Destination).locai-tmp" -Force
            Move-Item -LiteralPath "$($item.Destination).locai-tmp" -Destination $item.Destination -Force
        } else {
            Remove-Item -LiteralPath $item.Destination -Force
        }
    }
    Remove-Item -LiteralPath $receiptPath -Force
    Write-Host 'Traditional Chinese Deutsch-slot pack removed. Other game settings were not changed.' -ForegroundColor Green
    exit 0
} catch {
    Write-Error $_
    exit 1
}
