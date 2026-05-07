---
name: design-grill-docs
description: Use when creating or changing functional behavior, APIs, data, state, permissions, error handling, architecture, requirements, design notes, specs, ADRs, domain terminology, or user approval before implementation
---

# Design Grill Docs

## Overview

Clarify functional work, challenge assumptions against code and domain docs,
then write the smallest sufficient artifact before implementation.

## Process

1. Inspect existing code and docs before asking questions.
2. Ask one question at a time when code cannot answer it.
3. Challenge vague or conflicting domain language.
4. Choose the document level.
5. Write the artifact.
6. Ask the user to approve it before implementation.

## Document Levels

| Level | File | Use when |
| --- | --- | --- |
| 0 | none | Visual-only micro-change, typo, formatting-only, non-behavioral config cleanup |
| 1 | `docs/agents/notes/YYYY-MM-DD-topic.md` | Single feature, single-module behavior, small logic bug |
| 2 | `docs/agents/specs/YYYY-MM-DD-topic-design.md` | Multi-module behavior, API, data flow, permission, error handling |
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
