# Skill Trigger Visibility

## Context

The skills are installed and exposed to Codex, but they can still feel unused
when ordinary engineering requests do not clearly match a downstream skill or
when the agent silently follows a workflow without saying which skill was used.

Observed weak spots:

- The original router was too easy to miss because it depended on the model
  naturally selecting a downstream workflow from descriptions.
- The router relies too much on keyword-like rows. Keyword routing misses
  equivalent user intent, especially across English and Chinese phrasing.
- `branch-finish-lite` covers merge, PR, keep, discard, and cleanup, but not
  explicit commit/push requests.
- The router says to state the chosen route, but downstream skills do not share
  one visible "announce the skill" rule.
- Users cannot reliably distinguish "skill was not used" from "skill was used
  silently."

## Decision

Strengthen trigger coverage and visible usage without making every request
heavyweight. Follow the Superpowers pattern: a mandatory bootstrap skill routes
first, and downstream skills handle specialized behavior.

Update the skills so:

- `using-my-skills` is the mandatory bootstrap router for normal coding-session
  work, including docs edits, commits, pushes, cleanup, and repo maintenance.
- project agent instructions require `using-my-skills` at the start of
  coding-session work
- `using-my-skills` uses an intent decision tree before keyword examples:
  broken existing behavior routes to diagnosis, behavior changes route to
  design docs, approved implementation routes to TDD, completion claims route
  to verification, and integration requests route to branch finish.
- `using-my-skills` always emits a short visible route statement before
  following or delegating to another skill.
- `branch-finish-lite` explicitly covers commit and push requests.
- All skills share a short visibility rule: when used, state the skill name and
  reason in one concise line.

The visible line should be short enough not to waste tokens, for example:

```text
Using using-my-skills: routing this docs change as non-functional.
```

or:

```text
Using branch-finish-lite: commit/push request after verification.
```

## Scope

This change updates skill instructions and public descriptions. It does not
change the required documentation, diagnosis, TDD, or verification gates.

## Acceptance

- Ordinary repo work is more likely to start through `using-my-skills`.
- Repositories set up with My Skills get AGENTS/CLAUDE-style instructions that
  require `using-my-skills` before coding-session work.
- Routing is intent-first; keywords are examples, not the primary mechanism.
- Commit and push requests can route through `branch-finish-lite`.
- A user can see which skill is being applied.
- The announcement rule remains concise and does not replace the actual work.
