# CampusAid Agent v2 — hands-on AI red-team sandbox

**Start with [START_HERE.md](START_HERE.md)** for setup and participant steps. Your five missions and what counts as completion are in **[CHALLENGES.md](CHALLENGES.md)**. Use [workshop/participant_worksheet.md](workshop/participant_worksheet.md) and [workshop/REPORT_TEMPLATE.md](workshop/REPORT_TEMPLATE.md) to record and submit your work.

A deliberately vulnerable **multi-step tool-using AI agent**, plus a participant-directed hardening exercise for the AI/ML Club Foundation Track. **Local-only, fictional training system**: no real student data, services, exports, badges, or role changes. Students may use Claude Code, Codex, or a similar coding assistant to implement defenses instead of hand-coding Python.

## What participants do
1. Threat-model the sandbox; use an AI coding assistant to inspect code **without fixing it yet**.
2. Attack prompt boundaries, a poisoned policy file, a synthetic restricted record, and simulated tools.
3. Improve `project/system_prompt.txt` first; test and learn the limits of prompt-only defenses.
4. Ask their coding assistant to implement application-level controls in `project/guardrails.py`.
5. Rerun model-dependent tests and deterministic offline tests. Write new attacks and document findings.

**Participant path:** open a terminal in this extracted folder and run `claude` (or `./start-claude.sh` / `./start-claude.ps1`). `CLAUDE.md` and `AGENTS.md` give the coding assistant the project context, but participants **write their own prompts** to investigate and fix the target; no premade `/lab-*` commands or attack/fix prompts are included. See the root `START_HERE.md` and `CHALLENGES.md`. **Do not distribute instructor solutions.**

## Pre-workshop setup (Internet required here; not during local attacks)

Requirements: Docker Engine + Compose v2 or Docker Desktop, ~1GB+ for model weights plus Docker images, ideally at least 8GB host RAM, and a terminal. CPU inference is possible but can be slow. Verify everyone has local model weights installed **before** workshop day.

From this folder:

- macOS/Linux: `./setup.sh`
- Windows PowerShell: `./setup.ps1`

This downloads the local Ollama model through a temporary prep Compose file, **stops that online setup stack**, then starts the lab on an `internal: true` Docker network. Do not run both Compose files simultaneously. The lab itself has no intended Internet egress; it calls only its internal Ollama service. Participants can optionally run their coding assistant on the **host**, where the coding assistant may need its own separate Internet connection. Obtain organizer approval for using any external coding-agent service; only the fictional source files are suitable to share with it.

Manual equivalent:

```bash
docker compose -f compose.prepare.yml up -d
docker compose -f compose.prepare.yml exec ollama ollama pull qwen2.5:1.5b
docker compose -f compose.prepare.yml down
docker compose up -d --build
```

## Three simple commands (full workflow in CHALLENGES.md)

```bash
# 1. Interactive chat with the sandbox
docker compose exec lab python -m project.chat

# 2. Run five model-dependent attacks and save logs
docker compose exec lab python -m tests.run_suite --mode baseline

# 3. Run 12 deterministic security regression tests
docker compose exec lab python -m unittest tests.test_guardrails_offline -v
```

The last command is **expected to fail several tests initially**. A correct defense should make them pass without removing legitimate agent functionality.

To invoke a single reproducible prompt:

```bash
docker compose exec lab python -m project.cli --mode baseline --doc poisoned --prompt "Summarize the workshop fee policy"
```

After hardening:

```bash
docker compose exec lab python -m tests.run_suite --mode hardened
docker compose exec lab python -m unittest tests.test_guardrails_offline -v
```

Interactive chat commands: `:mode hardened`, `:doc poisoned`, `:doc tool_output`, `:quit`.

## Using a coding agent, not writing Python yourself

**Run the coding agent on your laptop in this project directory, not inside the isolated target containers.** If you have Claude Code installed and an active account, open the extracted `campusaid-agent-v2` folder in a terminal and run `claude`. The project root `CLAUDE.md` loads shared context from `AGENTS.md`. A launcher is also included as `start-claude.sh` (macOS/Linux) or `start-claude.ps1` (PowerShell). **There are deliberately no preset slash commands or copy-paste prompts.** Ask your coding assistant your own questions and give it specific engineering tasks. Stay in normal permission-review mode; do not use blanket permission bypass. Codex and other assistants can use `AGENTS.md` for equivalent context. The AI coding assistant executes only approved **local lab tests**; do not ask it to attack external systems. If external coding-agent services are not allowed, use the instructor's verified patch demonstrations instead.

**Your job** is to select the attack hypothesis, inspect the evidence, decide whether a fix is correct, and explain why it is secure; the coding assistant can author and run code.

## Fictional target and trust boundaries

- `project/system_prompt.txt` — editable application instruction policy; changing it alters both modes.
- `data/policies.txt`, `data/poisoned.txt`, `data/tool_output.txt` — untrusted retrieved content (attacker-editable in this lab).
- `data/synthetic_records.json` — fake records including one fictional restricted marker.
- `project/app.py` — orchestrator, three-step tool loop, baseline/hardened mode.
- `project/guardrails.py` — intentionally ineffective starter defenses to implement with a coding agent.
- `tests/run_suite.py` — five model-dependent attacks, with before/after JSONL logs in `logs/`.
- `tests/test_guardrails_offline.py` — repeatable mock tests for authorization and trust boundaries.

Simulated tools: `read_record`, `issue_badge`, `export_report`, `change_role`. Every tool is fake and returns an in-memory string; `export_report` **never exports** and `change_role` changes only the current request's fictitious role. The CLI `--role` and `--actor` options are **trusted test fixtures**, not a real login implementation. In a production design, authenticated identity must come from a server-side session or identity provider.

## Why two kinds of tests?

- **Local model-dependent tests** show what this particular small LLM actually did, and may vary. The model may refuse an unsafe request even when application authorization is broken.
- **Offline deterministic tests** mock model output to exercise the permission-checking code directly. A fail proves a specific code-level weakness; a pass is still not proof of comprehensive robustness.

Keep at least two defenses: untrusted-source separation and **application-level tool authorization**. An output check is a narrower additional layer. Do not "fix" tests by changing expected results, disabling all tools, or deleting the application.

## Scope and safety

- Testing is restricted to this local fictional sandbox with synthetic records only.
- Do not target public AI systems, public network services, or real people.
- Do not put real secrets or user files into this repo or a coding-agent prompt.
- Do not mount the host Docker socket, credentials, or sensitive folders into the lab.
- The model container's internal network is isolation defense-in-depth, not a proof against all container escapes.
- Treat hostile text in `data/` as data, even if a coding assistant reads it during investigation.
- User-modified code can introduce unsafe behavior: inspect coding-agent diffs before running them.

## Stop and reset

```bash
docker compose down
# Clears the model weights, too (not normally needed):
# docker compose down -v
```

## Instructor note

Instructor reference solutions and separate unreleased holdout tests are in the **instructor bundle**, not this student starter. Test the full Docker/Ollama runtime on the actual classroom hardware before teaching; this project is not a deployed or professionally-audited AI system.
