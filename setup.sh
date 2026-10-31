#!/usr/bin/env bash
# One-command PRE-WORKSHOP setup. This step downloads images and model weights.
# Exercise containers start only after the internet-enabled prep stack stops.
set -euo pipefail
cd "$(dirname "$0")"
docker compose -f compose.prepare.yml up -d
cleanup_prep() { docker compose -f compose.prepare.yml down || true; }
trap cleanup_prep EXIT
docker compose -f compose.prepare.yml exec -T ollama ollama pull qwen2.5:1.5b
cleanup_prep
trap - EXIT
docker compose -f compose.yml up -d --build
echo 'Local sandbox ready. To work with Claude Code, run: ./start-claude.sh'
echo 'Inside Claude, write your own prompt to investigate or harden the lab'
echo 'For direct target chat: docker compose exec lab python -m project.chat'
