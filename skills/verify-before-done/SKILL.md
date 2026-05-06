---
name: verify-before-done
description: Use when about to claim work is done, fixed, passing, complete, ready, merged, reviewed, or safe
---

# Verify Before Done

## Overview

Evidence before completion claims.

## Gate

Before any success claim:

1. Identify what proves the claim.
2. Run fresh verification when possible.
3. Read output and exit status.
4. State the actual result.
5. If blocked, state the blocker and strongest evidence available.

## Required Evidence

| Claim | Evidence |
| --- | --- |
| Tests pass | Fresh test command output |
| Build succeeds | Fresh build command output |
| Bug fixed | Original repro no longer reproduces |
| UI works | Browser interaction, screenshot, or DOM evidence |
| Requirements met | Checklist against the approved artifact |

## Red Flags

- "Should pass."
- "Looks fixed."
- "I already ran it earlier."
- "The agent said it worked."
- "Small change, no need to verify."

If verification is blocked by missing tools, sandboxing, network restrictions,
or user denial, say that directly. A blocked check is not a pass.
