---
name: plan
description: Use when approved work needs sequencing into implementation steps, milestones, vertical slices, or issue breakdown. 实现计划, 任务拆分, 怎么拆
---

# Plan

Turn approved work into ordered steps and independently grabbable slices.

## Process

1. Read the approved artifact and relevant code.
2. Restate the implementation goal and non-goals.
3. Split into ordered behavior slices — each independently testable.
4. Name files, modules, or interfaces likely to change.
5. Attach a test or verification command to each slice.
6. Call out dependencies, risks, and rollback points.
7. Write `docs/agents/plans/YYYY-MM-DD-topic.md`.
8. For large work, also write issues under `docs/agents/issues/`.
9. Ask the user to approve before implementation.

## Slice Quality

Good slices have one behavior, a clear test, and limited file ownership.
Avoid layer-only tickets ("database part") when a vertical slice is possible.

## Guardrails

- Plans sequence approved work; they do not invent requirements.
- Keep steps independently verifiable.
- Update status and evidence as steps complete.
- If the source artifact is missing, route back to `grill`.
