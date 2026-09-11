#!/usr/bin/env pwsh
<#
Task 17 final acceptance driver (run from Windows against the RK3588 board).

Sequence (each stage prints PASS/FAIL and the script exits non-zero on the first failure):
  1. board release SHA equals the pushed linux-adaptation SHA
  2. DoD: /health/live + /health/ready over HTTPS with CA verification (no -k)
  3. DoD: TCP/8000 still listened to by the existing FunASR pids
  4. DoD: deployed dist contains the new frontend code markers
  5. on-board corpus acceptance of the speaker-turn splitter (must-pass + no over-split)
  6. real-browser regression 17A (no false failure, re-record reachable)
  7. real-browser regression 17B-1 (effective mode + registration metrics surfaced)

Usage:  pwsh -File run_final_acceptance.ps1 [-SkipPush] [-Only 5]
Env:    BOARD_HOST/BOARD_PORT/BOARD_USER/BOARD_PASS may override the defaults.
#>
param(
  [switch]$SkipPush,
  [int[]]$Only = @(1, 2, 3, 4, 5, 6, 7)
)

$ErrorActionPreference = 'Stop'
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$Repo        = "D:\police Android\task17"
$BrowserDir  = "D:\police Android\task15\browser"
$BoardHost   = if ($env:BOARD_HOST) { $env:BOARD_HOST } else { "124.223.176.99" }
$BoardPort   = if ($env:BOARD_PORT) { $env:BOARD_PORT } else { "600" }
$BoardUser   = if ($env:BOARD_USER) { $env:BOARD_USER } else { "youyeetoo" }
$BoardPass   = if ($env:BOARD_PASS) { $env:BOARD_PASS } else { "123456" }
$CA          = "/etc/suspect-interrogation/tls/ca.crt"
$PythonBoard = "/opt/suspect-interrogation/runtime/funasr-env/bin/python"

$script:Failures = @()
function Stage([int]$n, [string]$name) {
  Write-Host ""
  Write-Host "=== stage $n : $name ===" -ForegroundColor Cyan
}
function Verdict([string]$name, [bool]$ok, [string]$detail = "") {
  $tag = if ($ok) { "PASS" } else { "FAIL" }
  $color = if ($ok) { "Green" } else { "Red" }
  Write-Host ("  {0}  {1}{2}" -f $tag, $name, ($(if ($detail) { "  | $detail" } else { "" }))) -ForegroundColor $color
  if (-not $ok) { $script:Failures += $name }
}

function Invoke-Board([string]$cmd) {
  $py = @"
import sys, paramiko
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
c = paramiko.SSHClient(); c.set_missing_host_key_policy(paramiko.AutoAddPolicy())
c.connect('$BoardHost', port=$BoardPort, username='$BoardUser', password='$BoardPass', timeout=20)
si, so, se = c.exec_command(sys.argv[1], timeout=1800)
out = so.read().decode('utf-8','replace'); err = se.read().decode('utf-8','replace')
c.close()
sys.stdout.write(out)
if err.strip(): sys.stderr.write(err)
"@
  $tmp = Join-Path $env:TEMP ("t17acc_{0}.py" -f ([guid]::NewGuid().ToString('N').Substring(0,8)))
  Set-Content -Path $tmp -Value $py -Encoding UTF8
  try { & python $tmp $cmd 2>&1 } finally { Remove-Item $tmp -Force -ErrorAction SilentlyContinue }
}

$localSha = (& git -C $Repo rev-parse HEAD).Trim()
Write-Host "local HEAD: $localSha"

if (-not $SkipPush -and ($Only -contains 1)) {
  Stage 1 "push and confirm the board runs the pushed commit"
  $remote = (& git -C $Repo rev-parse origin/linux-adaptation).Trim()
  if ($remote -ne $localSha) {
    Write-Host "  pushing linux-adaptation..."
    & git -C $Repo push origin linux-adaptation | Out-Null
  }
  $deadline = (Get-Date).AddMinutes(12)
  $boardSha = ""
  while ((Get-Date) -lt $deadline) {
    $boardSha = (Invoke-Board "cat /opt/suspect-interrogation/current/.suspect-source-sha" | Out-String).Trim()
    if ($boardSha -eq $localSha) { break }
    Write-Host "  board SHA $boardSha - waiting for CI deploy..."
    Start-Sleep -Seconds 20
  }
  Verdict "board SHA equals pushed SHA" ($boardSha -eq $localSha) "board=$boardSha local=$localSha"
}

if ($Only -contains 2) {
  Stage 2 "health endpoints with CA verification (no -k)"
  $live = Invoke-Board "echo $BoardPass | sudo -S curl -s --cacert $CA -o /dev/null -w 'HTTP %{http_code} verify=%{ssl_verify_result}' https://192.168.0.9:18080/health/live" | Out-String
  Verdict "/health/live HTTP 200 with verified certificate" ($live -match "HTTP 200" -and $live -match "verify=0") $live.Trim()
  $ready = Invoke-Board "echo $BoardPass | sudo -S curl -s --cacert $CA https://192.168.0.9:18080/health/ready" | Out-String
  Verdict "/health/ready reports ready with available capabilities" ($ready -match '"status"\s*:\s*"ready"' -and $ready -notmatch '"state"\s*:\s*"(UN)?AVAILABLE\s*".*ERROR')
}

if ($Only -contains 3) {
  Stage 3 "TCP/8000 untouched (existing FunASR service)"
  $sock = Invoke-Board "sudo -n ss -ltnp 'sport = :8000' | tail -2" | Out-String
  Verdict "TCP/8000 is still listening" ($sock -match ":8000") ($sock -replace "\s+", " ").Trim()
}

if ($Only -contains 4) {
  Stage 4 "deployed frontend carries the new code"
  $dist = Invoke-Board "grep -l 'beginFinalize' /opt/suspect-interrogation/current/webapp/dist/assets/*.js | head -2; grep -o 'effectiveRecognitionMode' /opt/suspect-interrogation/current/webapp/dist/assets/*.js | head -1" | Out-String
  Verdict "dist contains beginFinalize and effectiveRecognitionMode" ($dist -match "beginFinalize" -and $dist -match "effectiveRecognitionMode")
}

if ($Only -contains 5) {
  Stage 5 "on-board corpus acceptance (speaker-turn splitter)"
  $cmd = "test -f /tmp/run_splitter_corpus_check.py || echo MISSING_HARNESS; " +
         "cd /tmp && SUSPECT_ERES2NET_MODEL_DIR=/opt/suspect-interrogation/models/funasr/eres2net-large " +
         "$PythonBoard /tmp/run_splitter_corpus_check.py " +
         "--wav /tmp/t17-21.wav --timeline /tmp/timeline.json --db /tmp/interrogation.db " +
         "--case CASE-20260911-EBD4BF --out /tmp/t17-final-check.json 2>&1 | tail -14"
  $res = Invoke-Board $cmd | Out-String
  Write-Host $res
  Verdict "must-pass satisfied" ($res -match "satisfied: True")
  Verdict "no clean segment over-split" ($res -match "wrongly split: 0")
}

if ($Only -contains 6) {
  Stage 6 "real browser regression: 17A"
  Push-Location $BrowserDir
  try {
    & node regression-17a.mjs "https://${BoardHost}:18080" | Write-Host
    Verdict "17A regression passed" ($LASTEXITCODE -eq 0)
  } finally { Pop-Location }
}

if ($Only -contains 7) {
  Stage 7 "real browser regression: 17B-1"
  Push-Location $BrowserDir
  try {
    & node regression-17b1.mjs "https://${BoardHost}:18080" | Write-Host
    Verdict "17B-1 regression passed" ($LASTEXITCODE -eq 0)
  } finally { Pop-Location }
}

Write-Host ""
if ($script:Failures.Count -eq 0) {
  Write-Host "ALL STAGES PASSED" -ForegroundColor Green
  exit 0
}
Write-Host ("FAILED STAGES: " + ($script:Failures -join "; ")) -ForegroundColor Red
exit 1
