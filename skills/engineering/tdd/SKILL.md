---
name: tdd
description: Use when implementing observable behavior, bug fixes, or behavior-changing refactors after a design artifact is approved. 写代码, 实现功能, 开始写
---

# TDD

Implement one observable behavior at a time through public interfaces.

## Cycle

1. Choose one behavior from the approved artifact.
2. Write one test through a public interface.
3. Run it — confirm it fails for the expected reason.
4. Write the smallest implementation that passes.
5. Run the focused test, then the broader test command.
6. Refactor only while green.
7. Update the plan step with status and evidence.

## Rules

- One behavior per cycle. No writing all tests first.
- Tests describe what the system does, not how internals are shaped.
- If production code was written before the failing test, stop and restart.
- Good test names read like capabilities: `user can export profile as json`.
- Bad test names describe implementation: `calls exportProfile helper`.
- Every acceptance criterion in the plan slice must map to at least one test.
  If a criterion has no test, the slice is not done.

## No Silent Downgrade

If during implementation you find a behavior cannot be built as planned:

- Do NOT `skip` / comment out / replace with TODO / mock the real behavior.
- Do NOT relax the test to make it pass.
- STOP and emit a `SCOPE CHANGE PROPOSAL` (see `plan` skill) and wait for the
  user's decision before continuing.

Skipped, xfailed, or stubbed tests count as ❌ unfinished, not ✅ done.

## When Not To Use

Visual-only tweaks, copy changes, formatting — skip TDD, use targeted verification.
