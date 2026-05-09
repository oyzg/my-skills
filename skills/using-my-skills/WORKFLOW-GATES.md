# Workflow Gates

These gates apply after `using-my-skills` classifies intent and before acting.

## Hard Gates

- Functional changes require `design-grill-docs` before implementation.
- Broken existing behavior requires `diagnose-feedback-loop` before patching.
- Approved behavior implementation uses `tdd-behavior-slices` unless the user
  explicitly opts out.
- Completion claims require `verify-before-done` with fresh evidence.
- Commit, push, merge, or PR requests use `branch-finish-lite` after checking
  status, diff, and verification evidence.
- When working from an approved plan, completed slices must update the plan with
  status and evidence before moving to the next planned slice or claiming
  completion.
- Subagents require an approved artifact or plan, independent ownership, and
  explicit approval.
- Caveman mode changes wording only. It cannot skip the router or gates.

## Documentation Gate

Functional work includes changes to behavior, data, APIs, state, permissions,
error handling, architecture, or tests.

Functional work needs the smallest sufficient written artifact before code:

- Level 1 note for small single-module behavior.
- Level 2 spec for multi-module behavior, APIs, data flow, permissions, or
  error handling.
- ADR for hard-to-reverse or surprising trade-off decisions.

No document is required for pure visual micro-tweaks, typos, formatting-only
changes, or narrow non-behavioral cleanup.

## Diagnosis Gate

When existing behavior is wrong, do not patch first.

Build or identify a feedback loop, reproduce the user's symptom, state ranked
hypotheses, instrument one hypothesis at a time, then patch the confirmed root
cause. Add a regression test when a correct seam exists.

## Completion Gate

Before saying work is done, fixed, passing, ready, safe, committed, pushed, or
merged:

- inspect status and relevant diff
- compare against the request and any approved artifact
- update the active implementation plan for completed slices when one exists
- run fresh verification when possible
- state blocked checks honestly

## Micro-Change Gate

Micro-changes may proceed without a design artifact when they are strictly
visual-only, typo-only, formatting-only, or narrow non-behavioral cleanup.

Even then, use targeted verification: inspect the diff and run the smallest
reasonable check.
