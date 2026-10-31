# One-command PRE-WORKSHOP setup from PowerShell (requires Docker Compose v2).
$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot

docker compose -f compose.prepare.yml up -d
if ($LASTEXITCODE -ne 0) { throw "Preparation stack failed" }
try {
    docker compose -f compose.prepare.yml exec -T ollama ollama pull qwen2.5:1.5b
    if ($LASTEXITCODE -ne 0) { throw "Model download failed" }
} finally {
    docker compose -f compose.prepare.yml down
}
docker compose -f compose.yml up -d --build
if ($LASTEXITCODE -ne 0) { throw "Isolated lab startup failed" }
Write-Host "Local sandbox ready. To work with Claude Code, run: ./start-claude.ps1"
Write-Host "Inside Claude, write your own prompt to investigate or harden the lab"
Write-Host "For direct target chat: docker compose exec lab python -m project.chat"
