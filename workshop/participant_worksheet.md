# CampusAid V2 — Working notes (participant)

**Read [../CHALLENGES.md](../CHALLENGES.md) before starting.** This file is your scratchpad, not a secret answer key. You choose your own attacks and prompts to your coding assistant; no manual Python authoring is required.

## Quick checkpoints

- [ ] Setup completed; Docker `lab` and `ollama` running; CampusAid chat works.
- [ ] Claude Code (or another coding assistant) opened from project root.
- [ ] Threat model written before making changes.
- [ ] Original baseline suite run and `logs/baseline.jsonl` preserved.
- [ ] Initial offline check results preserved (some FAIL expected).
- [ ] Only the target system prompt edited for the prompt-only experiment; separate log saved.
- [ ] Two application defense layers implemented and reviewed.
- [ ] Hardened suite and offline tests rerun; allowed functionality verified.
- [ ] Two original test cases created and executed.
- [ ] Final report completed using [REPORT_TEMPLATE.md](REPORT_TEMPLATE.md).

## My threat model

- **Valuable things to protect:**
- **What students may legitimately do:**
- **What instructors/admins may legitimately do:**
- **What an attacker controls:**
- **What would count as an actual failure:**

## Five mission observations

| Mission | My hypothesis | My test / input | Expected safe behavior | Actual behavior + proof | What I concluded |
|---|---|---|---|---|---|
| 1. Direct override | | | | | |
| 2. Poisoned document | | | | | |
| 3. Restricted record | | | | | |
| 4. Administrative tool | | | | | |
| 5. Role escalation | | | | | |

## Three-stage comparison

| Stage | Files changed | Model-suite outcome | Offline-test outcome | What did I learn? |
|---|---|---|---|---|
| A. Baseline (before any fix) | None | | | |
| B. Prompt-only | `project/system_prompt.txt` only | | | |
| C. Hardened | Participant-directed code changes | | | |

**Saved logs / evidence paths:**

- Baseline:
- Prompt-only:
- Hardened:
- Test-run outputs:

## New tests I designed

1. **Test name / goal:**
   - Expected safe result:
   - Actual result:
   - Why it matters:
2. **Test name / goal:**
   - Expected safe result:
   - Actual result:
   - Why it matters:

## Defenses and legitimate-functionality checks

- First independent defense layer:
- Second independent defense layer:
- Student can still read their own record? Evidence:
- Admin can still issue the approved simulated badge? Evidence:
- Which failures or uncertainties remain?

## Questions for the debrief

1. Did I see an actual model-level exploit, a code-level security flaw, both, or neither?
2. What couldn't a stronger system prompt guarantee?
3. What did my coding assistant implement, and why do I believe those changes are sound?
4. What is one test I did **not** use to develop my defense?
