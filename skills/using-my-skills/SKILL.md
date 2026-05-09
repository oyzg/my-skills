---
name: using-my-skills
description: Use when starting any coding-session task, before editing, debugging, planning, reviewing, committing, pushing, or answering status. Mandatory bootstrap router for My Skills; classify intent first, then load the right downstream skill.
---

# Using My Skills

## Overview

Bootstrap My Skills before acting. This skill exists so routing does not depend
on every downstream skill matching the user's wording.

## Visibility

Start with one concise line naming this skill and the chosen downstream route.

Example:

```text
Using using-my-skills: routing a broken existing behavior report to diagnose-feedback-loop.
```

## Rule

Use this skill at the start of any coding-session task. Do not start file edits,
debug commands, implementation, commits, pushes, reviews, or completion claims
before routing.

## Intent Router

Classify intent, not keywords:

1. Existing behavior is wrong, missing, broken, empty, slow, failing, throwing,
   not visible, not returned, not parsed, or different from expectation.
   - Use `diagnose-feedback-loop`.
2. User asks to finish, claim done, check whether it is fixed, say it passes,
   or decide whether work is ready.
   - Use `verify-before-done`.
3. User asks to commit, push, merge, open a PR, keep a branch, discard work, or
   finish a branch.
   - Use `branch-finish-lite`.
4. User relays review feedback, requested changes, reviewer comments, or a
   suggestion from someone else.
   - Use `review-feedback-rigor`.
5. User asks for new behavior or behavior change, including APIs, data, state,
   permissions, error handling, architecture, or tests.
   - Use `design-grill-docs`.
6. User asks to implement an already approved artifact.
   - Use `tdd-behavior-slices`, unless sequencing is still missing.
7. Approved work needs sequencing, multiple steps, delegation, risky edits, or
   multiple behavior slices.
   - Use `write-implementation-plan`.
8. Approved plan/spec needs independent tasks, issues, tickets, or vertical
   slices.
   - Use `slice-to-issues`.
9. User asks for subagents, delegation, parallel agents, or dividing work across
   agents.
   - Use `subagent-coordination` only after planning and ownership are clear.
10. User asks about terminology, domain concepts, naming, or unclear
    boundaries.
    - Use `domain-context`.
11. Code structure, coupling, boundary shape, or test seams are blocking the
    work.
    - Use `architecture-deepening`.
12. User is setting up a repository for this workflow.
    - Use `setup-project-context`.
13. User asks for terse communication, fewer tokens, or caveman mode.
    - Apply `caveman` as a communication modifier, then keep the same workflow.

If no downstream skill applies, say that `using-my-skills` routed the task as
docs-only, cleanup-only, informational, or a micro-change, then proceed with
targeted verification.

## Guardrails

- Keywords are examples only. Equivalent user intent in any language must route
  the same way.
- Apply the workflow gate summary before acting:
  functional change -> docs first; broken behavior -> diagnosis first;
  approved implementation -> TDD; completion -> fresh verification;
  commit/push/PR -> status, diff, and evidence first; subagents -> plan,
  ownership, and approval first.
- If the user says "fix", "修", "定位", "排查", "没看到", "没有显示", or gives a
  screenshot of unexpected output, treat it as existing behavior that needs
  diagnosis unless they clearly ask for a new feature.
- If a downstream skill is selected, load and follow it before acting.
- Caveman mode can reduce words but cannot skip this bootstrap router.
- For ambiguous gate decisions, read `WORKFLOW-GATES.md`.
