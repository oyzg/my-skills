---
name: subagent-coordination
description: Use when the user explicitly asks for subagents, parallel agents, delegation, or when an approved large feature plan may benefit from optional independent agent work
---

# Subagent Coordination

## Overview

Use subagents for large work only when they reduce coordination cost. They are
best for independent slices with clear ownership, not for urgent blocking work.

## Preconditions

- A Level 2/3 artifact or approved implementation plan exists.
- The user explicitly asks for subagents, parallel agents, or delegation, or
  approves a proposed subagent split.
- Work can be split into disjoint file or module ownership.
- Each subtask has its own verification command or review checklist.

If these are not true, use `write-implementation-plan`, `slice-to-issues`, or
`tdd-behavior-slices` instead.

## Process

1. Read the approved artifact, plan, and relevant code boundaries.
2. Identify the local critical path that should stay in the main session.
3. Select only sidecar tasks that can run without blocking the next local step.
4. Write a short delegation packet for each subagent:
   - goal
   - owned files or modules
   - forbidden files or boundaries
   - tests or evidence expected
   - reminder that other agents may be editing the repo
5. Review each returned patch before integration.
6. Run the combined verification through `verify-before-done`.

Use `REFERENCE.md` for task selection and review checklists.

## Guardrails

- Do not spawn subagents just because a feature is "large".
- Do not delegate the immediate blocker on the main critical path.
- Do not give two subagents overlapping write ownership.
- Do not accept subagent output without review and tests.
- Do not let subagents skip documentation, diagnosis, TDD, or verification
  gates.
