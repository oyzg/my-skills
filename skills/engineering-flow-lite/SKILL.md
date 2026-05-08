---
name: engineering-flow-lite
description: Use when starting coding-session work, including feature work, bug fixes, refactors, docs changes, repo cleanup, commits, pushes, branch finishing, verification, reviews, architecture, or deciding whether a task needs docs
---

# Engineering Flow Lite

## Overview

Route engineering work to the smallest useful workflow while preserving hard
gates for documentation, diagnosis, TDD, review rigor, and verification.

## Visibility

Start with one concise line naming the route and why, then continue with the
chosen workflow. Keep this visible even for micro-changes and git requests.

Example:

```text
Using engineering-flow-lite: routing this README edit as a docs-only change.
```

## Routing

| Request | Use |
| --- | --- |
| Repository setup for docs/context | `setup-project-context` |
| Documentation, README, metadata, or repo cleanup | `engineering-flow-lite`, then proceed if no functional gate applies |
| Domain language, naming, or context confusion | `domain-context` |
| Functional feature or behavior change | `design-grill-docs` |
| Bug, failure, regression, unexpected behavior | `diagnose-feedback-loop` |
| Performance target, benchmark regression, or optimization | `diagnose-feedback-loop` (benchmark harness variant) |
| Approved artifact needs sequencing or a plan | `write-implementation-plan` |
| Approved plan/spec needs tasks or issues | `slice-to-issues` |
| User asks for subagents, delegation, or parallel agents | `subagent-coordination` |
| Implementation after approved artifact and plan, if needed | `tdd-behavior-slices` |
| Architecture concern or poor test seam | `architecture-deepening` |
| Code review feedback | `review-feedback-rigor` |
| Completion claim | `verify-before-done` |
| Commit, push, merge, PR, keep, discard | `branch-finish-lite` |
| "caveman", "less tokens", "be brief" | `caveman` |

## Conflict Priority

When multiple rows match, choose the first applicable priority:

1. `caveman` modifies communication only; it never changes the workflow route.
2. `verify-before-done` handles any done/fixed/passing/ready claim before final response.
3. `branch-finish-lite` handles commit, merge, PR, push, keep, or discard only after verification.
4. `review-feedback-rigor` handles external review comments before edits.
5. `diagnose-feedback-loop` beats TDD when behavior is broken or unexplained.
6. `setup-project-context` beats feature work when repo docs/context conventions are missing.
7. `domain-context` beats design when core terms or boundaries are unclear.
8. `design-grill-docs` beats implementation for functional behavior changes.
9. `write-implementation-plan` beats issue slicing, subagents, and implementation when approved work needs sequencing.
10. `slice-to-issues` beats subagents when the plan has not been split into independently reviewable slices.
11. `subagent-coordination` applies only after documentation/planning and explicit user approval for delegation.
12. `tdd-behavior-slices` handles implementation after required artifacts and plans exist.
13. `architecture-deepening` applies when current boundaries block the task; feed functional changes back to docs.

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
functional gate applies, explain that the work is docs-only, cleanup-only, or a
micro-change and proceed with targeted verification.
