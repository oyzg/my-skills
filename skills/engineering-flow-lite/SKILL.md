---
name: engineering-flow-lite
description: Use when starting engineering work, deciding whether work needs docs, or routing feature, bug, architecture, review, verification, branch finish, or concise communication requests
---

# Engineering Flow Lite

## Overview

Route engineering work to the smallest useful workflow while preserving hard
gates for documentation, diagnosis, TDD, review rigor, and verification.

## Routing

| Request | Use |
| --- | --- |
| Repository setup for docs/context | `setup-project-context` |
| Domain language, naming, or context confusion | `domain-context` |
| Functional feature or behavior change | `design-grill-docs` |
| Bug, failure, regression, unexpected behavior | `diagnose-feedback-loop` |
| Approved artifact needs sequencing or a plan | `write-implementation-plan` |
| Approved plan/spec needs tasks or issues | `slice-to-issues` |
| User asks for subagents, delegation, or parallel agents | `subagent-coordination` |
| Implementation after approved artifact and plan, if needed | `tdd-behavior-slices` |
| Architecture concern or poor test seam | `architecture-deepening` |
| Code review feedback | `review-feedback-rigor` |
| Completion claim | `verify-before-done` |
| Merge, PR, keep, discard | `branch-finish-lite` |
| "caveman", "less tokens", "be brief" | `caveman` |

If more than one row applies, use the process skill first. Diagnosis beats TDD
when the behavior is broken and not understood. Documentation beats
implementation when functional behavior is being created or changed. Planning
beats implementation when approved work has multiple steps or coordination
risk. Subagent coordination only applies after documentation/planning and
explicit user approval for delegation. Domain language beats design when core
terms are unclear.

## Documentation Gate

Functional work needs a written artifact before implementation. Functional work
includes changes to behavior, data, APIs, state, permissions, error handling,
architecture, or tests.

No document is required for pure visual micro-tweaks, typos, formatting-only
changes, or narrow non-behavioral config cleanup.

## Hard Gates

- No functional implementation before an approved artifact.
- No bug fix before a feedback loop and root-cause hypothesis.
- No behavior implementation before a failing behavior test unless the user explicitly opts out.
- No completion claim without fresh verification evidence.
- No subagent delegation without independent ownership and explicit user approval.
- Caveman mode compresses communication only; it never removes gates.

## Red Flags

Stop and route instead if you are thinking:

- "This is simple, so docs are overkill."
- "The fix is obvious, so diagnosis can wait."
- "I'll write tests after the implementation."
- "This is large, so I should spawn agents without splitting ownership."
- "I can say done because the edit looks right."
- "Caveman mode means I can skip details."

## Output

State the chosen route briefly, then follow the downstream skill. If no
functional gate applies, explain that the work is a micro-change and proceed
with targeted verification.
