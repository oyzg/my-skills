---
name: tdd-behavior-slices
description: Use when implementing observable functional behavior, bug fixes, behavior-changing refactors, or behavior tests after a design artifact is approved
---

# TDD Behavior Slices

## Overview

Implement one observable behavior at a time through public interfaces.

## Cycle

1. Choose one behavior from the approved artifact.
2. Write one test through a public interface.
3. Run it and confirm it fails for the expected reason.
4. Write the smallest implementation that passes.
5. Run the focused test.
6. Run the relevant broader test command.
7. Refactor only while green.

## Rules

- One behavior per cycle.
- Tests describe what the system does, not how internals are shaped.
- Tests should survive internal refactors when behavior stays the same.
- Do not write all tests first and all code later.
- Do not add speculative options for future tests.
- If production code was written before the failing test, stop and ask whether to restart the slice correctly.

## When Not To Use

Do not use this for visual-only micro-tweaks, copy changes, formatting-only
edits, or other non-behavioral cleanup. Those can proceed with targeted
verification instead of a behavior-slice TDD cycle.

## Good Test Shape

Prefer integration-style tests at the narrowest public seam that proves the
behavior. Mock only when the real collaborator is unavailable, unsafe, or too
expensive for the test level.

Good test names read like capabilities:

```text
user can export profile as json
expired token is rejected
archived projects are excluded by default
```

Bad test names describe implementation:

```text
calls exportProfile helper
sets isExpired flag
maps project row correctly
```

## Refactor

Refactor after green only. Improve names, remove duplication, deepen modules,
and simplify interfaces without adding behavior.
