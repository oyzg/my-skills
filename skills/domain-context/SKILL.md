---
name: domain-context
description: Use when domain terms, business concepts, naming, boundaries, ubiquitous language, CONTEXT.md, glossary, or cross-team vocabulary are unclear before design or implementation
---

# Domain Context

## Overview

Turn repeated explanations into shared language.

## When To Use

Use before design or implementation when project terms are ambiguous, overloaded,
or repeatedly explained. Use with `design-grill-docs` when a feature depends on
domain concepts that are not yet documented.

## Process

1. Inspect existing `CONTEXT.md`, `CONTEXT-MAP.md`, docs, ADRs, and code names.
2. Identify ambiguous terms, aliases, boundaries, and relationships.
3. Ask focused questions only when the code/docs cannot answer.
4. Write or update `CONTEXT.md` using `templates/context.md`.
5. Prefer the resolved domain term in docs, tests, APIs, and code names.
6. Feed behavior or architecture changes back to `design-grill-docs`.

## Guardrails

- Capture stable domain language, not temporary implementation details.
- Do not invent terminology to sound formal.
- Keep entries short enough to reduce future tokens.
- If a term is disputed, record the decision and the rejected alternatives.
