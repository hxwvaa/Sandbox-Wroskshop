# CampusAid V2 — 120-minute participant-led workshop

**Before class (not counted in 120 minutes):** complete `START_HERE.md` setup, verify the local model works, and sign in to your approved coding assistant. Facilitator should test the Docker/Ollama setup on classroom hardware.

| Time | Participant activity | Checkpoint / evidence |
|---|---|---|
| 0–10 min | Understand target, permission rules, safety boundary | Threat model started |
| 10–25 min | Open Claude Code + CampusAid, investigate their own hypotheses | Can distinguish coding assistant from attack target |
| 25–45 min | Try five mission goals from `CHALLENGES.md`; run baseline suite | Preserve initial log and note what actually worked |
| 45–60 min | Edit ONLY target system prompt, retest | Separate prompt-only log and explanation of limits |
| 60–85 min | Prompt coding assistant to implement layered application guardrails | Review diff and preserve authorized operations |
| 85–105 min | Run hardened + offline suites; create two novel tests | Before/after comparison, allowed/denied tests |
| 105–120 min | Complete short report and explain one result | Finding or failure analysis with reproducible evidence |

**Facilitator approach:** provide objectives, time checks, and the challenge document. Do NOT give students prewritten Claude prompts, hidden fixes, or live targets. Coach them to explain their code and distinguish static findings from model behavior. If a small model refuses a seeded attack, deterministic tests can still illustrate authorization defects.

**After class:** participants keep the lab and their scripts. Only local fictional data and mock tools are in scope.
