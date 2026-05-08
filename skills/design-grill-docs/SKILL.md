---
name: design-grill-docs
description: Use when creating or changing functional behavior, APIs, data, state, permissions, error handling, architecture, requirements, design notes, specs, ADRs, domain terminology, or user approval before implementation
---

# Design Grill Docs

## Overview

Clarify functional work, challenge assumptions against code and domain docs,
interview the user until the important decision branches are resolved, then
write the smallest sufficient artifact before implementation.

## Process

1. Inspect existing code and docs before asking questions.
2. Identify unresolved decision branches: user outcome, behavior, data, API,
   state, permissions, errors, rollout, tests, and domain language.
3. Answer branches from the repository when possible instead of asking the
   user to explain existing code.
4. Interview the user when a branch cannot be resolved from code or docs.
5. Challenge vague or conflicting domain language.
6. Choose the document level.
7. Write the artifact.
8. Ask the user to approve it before implementation.

## Interview Loop

For unresolved functional design work, interview before writing the artifact.

- Ask exactly one question at a time.
- Include your recommended answer with each question.
- Explain why the answer matters when the trade-off is not obvious.
- Use the user's answer to choose the next branch of the design tree.
- Ask at least three meaningful questions for unclear functional work.
- If fewer than three questions are needed, state which branches were already
  resolved from code, docs, tests, or existing conventions.
- Continue until the meaningful branches are resolved, intentionally deferred,
  or small enough to document as assumptions.
- Do not ask questions that can be answered by inspecting code, docs, tests,
  or existing conventions.

Use concise questions. The goal is shared understanding, not a long survey.

## Document Levels

| Level | File | Use when |
| --- | --- | --- |
| 0 | none | Visual-only micro-change, typo, formatting-only, non-behavioral config cleanup |
| 1 | `docs/agents/notes/YYYY-MM-DD-topic.md` | Single feature, single-module behavior, small logic bug |
| 2 | `docs/agents/specs/YYYY-MM-DD-topic-design.md` | Multi-module behavior, API, data flow, permissions, error handling |
| 3 | Level 2 spec, then route to `write-implementation-plan` | Work needs sequencing, delegation, or multiple implementation tasks |
| ADR | `docs/adr/NNNN-title.md` | Hard to reverse, surprising, trade-off driven |
| Domain context | `CONTEXT.md` | Domain term or boundary is resolved |

## Level 1 Template

Use `templates/design-note.md` for Level 1 notes, `templates/spec.md` for Level
2 specs, and `templates/adr.md` for ADRs.

## Domain Docs

Look for `CONTEXT.md`, `CONTEXT-MAP.md`, and `docs/adr/` before naming new
concepts. If a term is resolved, update the relevant context document when it
exists or create one only when there is real domain language to capture.

Offer an ADR only when the decision is hard to reverse, surprising without
context, and caused by a real trade-off.

## Gate

Stop after writing the artifact and ask for user approval before
implementation. Do not start code, scaffolding, or tests until the user has
approved the artifact or explicitly opted out with an exception recorded in
the final response.
