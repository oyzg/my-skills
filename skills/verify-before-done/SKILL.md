---
name: verify-before-done
description: Use when about to claim work is done, fixed, passing, complete, ready, merged, reviewed, or safe
---

# Verify Before Done

## Overview

Completion claims need a quality gate: inspect the diff, align it with the
approved artifact, then produce fresh evidence.

## Gate

Before any success claim:

1. Inspect the current worktree and relevant diff.
2. Check that changes match the task, approved artifact, plan, and domain terms.
3. Look for unrelated edits, hidden scope creep, missing docs, missing tests, or
   subagent integration issues.
4. Identify what command or evidence proves the claim.
5. Run fresh verification when possible.
6. Read output and exit status.
7. State the actual result.
8. If blocked, state the blocker and strongest evidence available.

## Required Evidence

| Claim | Evidence |
| --- | --- |
| Tests pass | Fresh test command output |
| Build succeeds | Fresh build command output |
| Bug fixed | Original repro no longer reproduces |
| UI works | Browser interaction, screenshot, or DOM evidence |
| Requirements met | Checklist against the approved artifact |
| Diff is clean | Inspected status/diff and no unrelated changes |
| Subagent work integrated | Reviewed delegated patches and ran combined checks |

See `REFERENCE.md` for diff review, evidence matrix, and completion wording.

## Red Flags

- "Should pass."
- "Looks fixed."
- "I already ran it earlier."
- "The agent said it worked."
- "Small change, no need to verify."
- "Tests passed, so I do not need to inspect the diff."
- "Subagent output can be trusted as-is."

If verification is blocked by missing tools, sandboxing, network restrictions,
or user denial, say that directly. A blocked check is not a pass.
