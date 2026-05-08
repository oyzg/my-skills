# Skill Trigger Visibility

## Context

The skills are installed and exposed to Codex, but they can still feel unused
when ordinary engineering requests do not clearly match a downstream skill or
when the agent silently follows a workflow without saying which skill was used.

Observed weak spots:

- `engineering-flow-lite` is the router, but its description does not strongly
  cover routine repository work such as docs edits, commits, pushes, and cleanup.
- `branch-finish-lite` covers merge, PR, keep, discard, and cleanup, but not
  explicit commit/push requests.
- The router says to state the chosen route, but downstream skills do not share
  one visible "announce the skill" rule.
- Users cannot reliably distinguish "skill was not used" from "skill was used
  silently."

## Decision

Strengthen trigger coverage and visible usage without making every request
heavyweight.

Update the skills so:

- `engineering-flow-lite` triggers for normal coding-session work, including
  docs edits, commits, pushes, cleanup, and repo maintenance.
- `engineering-flow-lite` always emits a short visible route statement before
  following or delegating to another skill.
- `branch-finish-lite` explicitly covers commit and push requests.
- All skills share a short visibility rule: when used, state the skill name and
  reason in one concise line.

The visible line should be short enough not to waste tokens, for example:

```text
Using engineering-flow-lite: routing this docs change as non-functional.
```

or:

```text
Using branch-finish-lite: commit/push request after verification.
```

## Scope

This change updates skill instructions and public descriptions. It does not
change the required documentation, diagnosis, TDD, or verification gates.

## Acceptance

- Ordinary repo work is more likely to start through `engineering-flow-lite`.
- Commit and push requests can route through `branch-finish-lite`.
- A user can see which skill is being applied.
- The announcement rule remains concise and does not replace the actual work.
