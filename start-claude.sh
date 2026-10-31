#!/usr/bin/env bash
# Opens the developer's Claude Code CLI with this project as the working directory.
set -euo pipefail
cd "$(dirname "$0")"
if ! command -v claude >/dev/null 2>&1; then
  echo "Claude Code CLI was not found in PATH. Install it and sign in before the workshop." >&2
  echo "Alternatively, open this folder in an already installed Claude Code environment." >&2
  exit 1
fi
printf 'Opening Claude Code in: %s\n' "$PWD"
echo 'Write your own prompt: the agent has project context, not preset missions.'
exec claude "$@"
