# Opens Claude Code in the extracted starter-kit folder on Windows PowerShell.
$ErrorActionPreference = 'Stop'
Set-Location -LiteralPath $PSScriptRoot
if (-not (Get-Command claude -ErrorAction SilentlyContinue)) {
    Write-Error 'Claude Code CLI is not installed or not in PATH. Install it, sign in, and rerun from this folder.'
    exit 1
}
Write-Host "Opening Claude Code in: $(Get-Location)"
Write-Host 'Write your own prompt: the agent has project context, not preset missions.'
& claude @args
exit $LASTEXITCODE
