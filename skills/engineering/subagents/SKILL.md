---
name: subagents
description: Use when the user explicitly asks for subagents, parallel agents, or delegation for approved large feature work. 并行, 子代理, delegation
---

# Subagents

Use subagents only when they reduce coordination cost.

## Preconditions

- Approved artifact or implementation plan exists.
- User explicitly asks for parallel work or approves a split.
- Work splits into disjoint file/module ownership.
- Each subtask has its own verification.

If not met, use `plan` or `tdd` instead.

## Process

1. Identify the local critical path (stays in main session).
2. Select sidecar tasks that can run without blocking.
3. Write a delegation packet per subagent: goal, owned files, forbidden
   files, expected tests.
4. Review each returned patch before integration.
5. Run combined verification via `finish`.

## Guardrails

- No subagents just because a feature is "large".
- No overlapping write ownership between subagents.
- No accepting output without review and tests.
