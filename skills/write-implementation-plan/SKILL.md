---
name: write-implementation-plan
description: Use when an approved design note, spec, PRD, ADR, or requirements artifact needs sequencing into implementation tasks, milestones, file-level steps, test slices, or a docs/agents/plans plan before coding
---

# Write Implementation Plan

## Overview

Turn an approved artifact into a small executable plan.

## Visibility

Start with one concise line naming this skill and why.

## When To Use

Use after `design-grill-docs` when work needs sequencing, multiple steps,
coordination, risky edits, or more than one behavior slice. Do not use for a
single obvious edit that can move directly to `tdd-behavior-slices`.

## Process

1. Read the approved artifact and relevant code.
2. Restate the implementation goal and non-goals.
3. Split work into ordered behavior slices.
4. Name the files, modules, or interfaces likely to change.
5. Attach a test or verification command to each slice.
6. Call out dependencies, migration risks, and rollback points.
7. Include a status field for each step, initially `Pending`.
8. Write `docs/agents/plans/YYYY-MM-DD-topic.md`.
9. Ask the user to approve the plan before implementation.

## Plan Shape

Use `templates/implementation-plan.md`.

## Guardrails

- Plans sequence approved work; they do not invent new requirements.
- Keep steps independently verifiable.
- Treat plans as living progress documents: completed steps should later be
  marked with status and evidence instead of leaving the plan stale.
- Do not include speculative future work.
- If the source artifact is missing or unapproved, route back to
  `design-grill-docs`.
