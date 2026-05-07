---
name: diagnose-feedback-loop
description: Use when bugs, failing tests, build failures, performance regressions, or unexpected behavior need investigation before fixes
---

# Diagnose Feedback Loop

## Overview

Build a reliable pass/fail loop before fixing. Root cause first, patch second.

## Process

1. Build the fastest available feedback loop: focused test, curl script, CLI fixture, browser script, trace replay, throwaway harness, fuzz loop, or bisect harness.
2. Reproduce the user's actual symptom.
3. Write 3-5 ranked falsifiable hypotheses.
4. Instrument one hypothesis at a time.
5. Convert the minimized repro into a failing regression test when a correct seam exists.
6. State the confirmed root cause and proposed fix scope to the user. If the fix touches more than the minimum required code, pause and confirm scope before patching.
7. Fix the root cause.
8. Rerun the original loop and regression test.
9. Remove debug logs and throwaway harnesses.

## Feedback Loop Quality

A useful loop is fast enough to run repeatedly, deterministic enough to trust,
and specific enough to prove the reported symptom. If the bug is flaky, raise
the reproduction rate with repeated runs, stress, seeded inputs, or narrowed
timing windows before fixing.

See `REFERENCE.md` for feedback-loop examples and hypothesis shape.

## Hypotheses

Each hypothesis must predict an observable result:

```text
If <cause> is true, then <probe> will show <result>.
```

Test one prediction at a time. Do not stack multiple guesses into one change.

## Stop Conditions

- If no reliable loop can be built, state what was tried and ask for logs, traces, access, or permission to instrument.
- If no correct test seam exists, document that architecture finding and use `architecture-deepening`.
- If repeated fixes fail, stop adding patches and revisit the diagnosis.
