# START HERE — CampusAid AI Security Lab

**You are the security lead. Claude Code (or another coding assistant) can help with analysis and code, but YOU decide what to investigate, what to ask it to do, and whether its work is correct.** There are no automatic missions, copy-and-paste agent prompts, or prebuilt fixes.

**What you will do:** launch a deliberately vulnerable fictional AI agent, test five security objectives, harden the target's system prompt, use your coding assistant to add real guardrails, retest, and submit evidence. The goal is a working, safer assistant—not merely a passing score.

## 0. Check requirements before class

- Docker Desktop (Windows/macOS) or Docker Engine + Docker Compose v2 (Linux).
- A terminal; Python programming experience is **not required**.
- Claude Code installed and signed in, **or** another coding assistant able to work in a local project folder. A coding assistant is optional if your instructor supplies an alternative. Claude Code may require an account/network access and is **not installed by this kit**.
- Enough free disk space for Docker and an approximately 1 GB local model download, ideally 8 GB or more host RAM. CPU-only operation can be slow.
- Internet access during initial setup (Docker images/model); the **CampusAid target itself** runs locally in an isolated Docker network afterwards. Coding assistants running on the host may separately use the Internet—check your club's rules.

## 1. Get the project onto your laptop

If the instructor gives you a ZIP, **extract it**. If the instructor publishes a Git repository, **clone it**. In either case open a terminal in the `campusaid-agent-v2` folder (the folder containing `compose.yml`, `CLAUDE.md`, and this file).

Windows PowerShell:

```powershell
.\setup.ps1
```

macOS / Linux:

```bash
./setup.sh
```

The setup downloads and caches the `qwen2.5:1.5b` model, stops the network-enabled preparation stack, and launches the isolated exercise stack.

Check it:

```bash
docker compose ps
```

You should see the `lab` and `ollama` services. If setup fails, see **Troubleshooting** below; don't skip straight to attacks.

## 2. Open TWO terminals in the project folder

**Terminal A — Claude Code: your security engineering assistant**

```bash
claude
```

Or run `./start-claude.sh` (macOS/Linux) / `.\start-claude.ps1` (PowerShell). The root `CLAUDE.md` and `AGENTS.md` give the assistant technical project context and boundaries. **It does not run anything just because you opened it.** You write your own requests. You can ask for code explanations, local tests, or code changes, but review the proposed actions.

**Terminal B — CampusAid: the intentionally vulnerable attack target**

```bash
docker compose exec lab python -m project.chat
```

Chat commands: `:doc policies`, `:doc poisoned`, `:doc tool_output`, `:mode baseline`, `:mode hardened`, `:quit`. Every message is a fresh simulation; the chat does **not** remember previous messages. Tool actions are fake and affect no real account.

**Remember:** Claude Code is **not** the target. CampusAid is the target. Only CampusAid and this local lab are authorized for attacks.

## 3. Read your actual assignment

Open **[CHALLENGES.md](CHALLENGES.md)** before testing. It contains the five missions, what counts as evidence, constraints for a successful defense, and a clear three-stage flow:

1. **Baseline:** investigate and preserve the initial results before changing any files.
2. **Prompt-only:** modify `project/system_prompt.txt`, then retest. Observe what prompts can and cannot protect.
3. **Application hardening:** direct your coding assistant to implement defenses, then test both malicious and legitimate actions.

Do not change the provided security tests or delete features just to make a test pass. Do not paste a complete mission into Claude and ask it to finish everything without your involvement.

## 4. Essential commands (run from the project folder)

| Action | Command |
|---|---|
| Chat with the target | `docker compose exec lab python -m project.chat` |
| Run initial five local probes | `docker compose exec lab python -m tests.run_suite --mode baseline` |
| Run the same five probes using defenses | `docker compose exec lab python -m tests.run_suite --mode hardened` |
| Run 12 repeatable code-security checks | `docker compose exec lab python -m unittest tests.test_guardrails_offline -v` |
| Run your own test file | `docker compose exec lab python -m tests.student_tests` |
| Stop the lab | `docker compose down` |

**Important:** Some offline tests are supposed to **FAIL initially**. That's intentional. A local model can also refuse an attack even when the underlying code is insecure; do not invent successful exploits.

**Preserve the baseline log:** The suite saves `logs/baseline.jsonl` or `logs/hardened.jsonl` and overwrites the corresponding file each run. After your first baseline run, rename/copy the log before running a new version. You can ask your coding assistant to do this without altering the test suite.

## 5. What you must submit

Use **[workshop/participant_worksheet.md](workshop/participant_worksheet.md)** while working and **[workshop/REPORT_TEMPLATE.md](workshop/REPORT_TEMPLATE.md)** at the end. Hand in:

- A short threat model explaining what CampusAid must protect.
- Evidence for the five challenge goals (successful **or unsuccessful** attempts, clearly labeled).
- Your initial results, prompt-only observations, and final hardened results.
- At least **two original tests** you designed or asked your coding assistant to create.
- At least **two different defense layers**, one of which must enforce permissions in application code; preserve normal user/admin actions.
- One concise finding or failure analysis with reproduction steps, fix, and limitations.

Your instructor may ask you to share the updated project folder or a Git commit, and explain your decisions aloud. See [CHALLENGES.md](CHALLENGES.md) for acceptance criteria.

## Troubleshooting

- `docker: command not found` / Compose error: install and start Docker; reopen your terminal and rerun setup.
- `Cannot connect to Docker daemon`: start Docker Desktop or the Docker service.
- `claude: command not found`: install/sign into Claude Code separately, or use the coding assistant approved by your instructor. You can still run the local target without Claude.
- `Local Ollama unavailable`: check `docker compose ps` and `docker compose logs ollama`; repeat the pre-workshop setup if the model is missing.
- Very slow responses: a 1.5B model on CPU can take time; demonstrate behavior using offline tests if inference is unavailable.
- `:mode hardened` still shows weaknesses: expected until code guardrails are correctly implemented.
- The model refuses a seeded attack: record that actual outcome, then use the offline tests to verify whether application permissions were enforced.
- Need to restart cleanly: `docker compose down`, then `docker compose up -d --build`. Do **not** run `docker compose down -v` unless you intend to delete cached model weights.

## Safety

Only fictional data and mock tools are in scope. No scanning or attacking public models, real services, other students' machines, external networks or private files. Do not connect CampusAid to actual accounts, databases, network access, or host-shell tools. Review coding-agent file edits and command permissions before approval. Keep instructor solutions out of this participant folder.
