# Sync_AuthorityLedger.ps1
# Wipes the destination folder, then copies source contents exactly.

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$SRC = "C:\Users\jason\OneDrive\Documents\GitHub\EU5_KB\Authority Ledger"
$DST = "C:\Users\jason\OneDrive\Documents\Paradox Interactive\Europa Universalis V\mod\Authority Ledger"

function Ensure-Dir([string]$p) {
  if (-not (Test-Path -LiteralPath $p)) {
    New-Item -ItemType Directory -Path $p -Force | Out-Null
  }
}

if (-not (Test-Path -LiteralPath $SRC)) {
  throw "SOURCE not found: $SRC"
}

# Make sure destination exists
Ensure-Dir $DST

# Empty destination safely (remove everything inside, not the folder itself)
Get-ChildItem -LiteralPath $DST -Force -ErrorAction SilentlyContinue |
  Remove-Item -Force -Recurse -ErrorAction Stop

# Copy source -> destination (all contents)
Copy-Item -LiteralPath (Join-Path $SRC "*") -Destination $DST -Recurse -Force -ErrorAction Stop

Write-Host "OK: Synced '$SRC' -> '$DST' (destination was emptied first)."
