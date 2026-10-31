# CampusAid V2 — Final Red-Team Report (participant template)

Copy this file to `workshop/MY_REPORT.md` and fill in the blanks. You may ask your coding assistant to **format** the report, but the claims and evidence must be your own. Do not present an untested idea as a successful exploit.

## Participant / team

- Name or team ID:
- Date:
- Coding assistant used (optional):
- Lab version and machine environment:

## 1. Target and threat model

- Intended normal behavior:
- Assets and authorized actors:
- Attacker-controlled entry points:
- What should never happen:
- Authorized scope: local fictional CampusAid only.

## 2. Attack results (before defenses)

For each mission, describe the attack objective, the exact input or test name, what safe behavior you expected, what actually happened, which component you observed, and whether the result was **successful, unsuccessful, or inconclusive**.

| Mission | Expected safe behavior | Input / test reference | Actual result | Classification |
|---|---|---|---|---|
| 1. Direct override | | | | |
| 2. Poisoned document | | | | |
| 3. Restricted records | | | | |
| 4. Unauthorized tools | | | | |
| 5. Role escalation | | | | |

## 3. Prompt-only hardening

- Changes made to `project/system_prompt.txt` (brief summary):
- Comparison against baseline (include filenames of saved logs):
- Which properties were **not** enforceable via prompts alone and why:

## 4. Code-level defenses

- Defense layer 1 and trust boundary it protects:
- Defense layer 2 and trust boundary it protects:
- Optional extra controls:
- Files modified:
- Why the changes preserve legitimate functionality:

## 5. Validation evidence

- Offline tests before: __ passed / __ total (attach command output or screenshot)
- Offline tests after: __ passed / __ total
- Model-dependent suite before: __ passed / __ total (not a complete security score)
- Model-dependent suite after: __ passed / __ total
- Original new test 1: goal, expected, observed:
- Original new test 2: goal, expected, observed:
- Normal student action tested and result:
- Normal instructor action tested and result:
- Saved log paths:

## 6. Primary security finding (or unsuccessful attempt)

- Title:
- Status: validated vulnerability / observed unsafe output / unsuccessful attempt / inconclusive
- Root cause and trust boundary:
- Minimal reproduction steps **inside this lab only**:
- Evidence (log excerpt / test name, never fabricated):
- Impact **within the simulated training scenario**:
- Mitigation:
- Retest outcome:
- One remaining limitation or bypass possibility (hypothesis if not tested):

## 7. Reflection

- What I asked my coding assistant to do, and how I evaluated its work:
- What I would investigate next:
- Confirmation that I did not target external systems or real data:
