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
5. For **each** slice, attach all of:
   - **Acceptance criteria** — concrete, testable judgments of "done".
   - **Out of scope** — what is explicitly NOT part of this slice.
   - **Demo step** — how to show this slice works (command, URL, fixture).
   - **Verification command** — the test or check that proves it.
   A slice missing any of these is not ready to execute.
6. Call out dependencies, risks, and rollback points.
7. Write `docs/agents/plans/YYYY-MM-DD-topic.md`.
8. For large work, also write issues under `docs/agents/issues/`.
9. Ask the user to approve before implementation.

## Definition of Done

A slice is `completed` ONLY when every acceptance criterion is satisfied with
evidence. "Code written" or "compiles" is not done. TodoWrite / task status
must reflect this definition — do not mark completed on partial work.

## No Silent Downgrade

During execution, if a slice cannot be implemented as planned, STOP and emit a
`SCOPE CHANGE PROPOSAL` (see below). Never quietly replace with a stub, mock,
TODO, simplified variant, or "we'll do it later". The plan is the contract.

```
SCOPE CHANGE PROPOSAL
- Slice: <id / name>
- Original acceptance criteria: ...
- Actual difficulty / finding: ...
- Options: (a) push through  (b) simplify to ...  (c) defer  (d) drop
- Recommended: ...
- Impact on other slices / acceptance criteria: ...
Waiting for your decision.
```

## Slice Quality

Good slices have one behavior, a clear test, and limited file ownership.
Avoid layer-only tickets ("database part") when a vertical slice is possible.

## Guardrails

- Plans sequence approved work; they do not invent requirements.
- Keep steps independently verifiable.
- Update status and evidence as steps complete.
- If the source artifact is missing, route back to `grill`.
