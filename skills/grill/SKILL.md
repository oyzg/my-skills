---
name: grill
description: Use when creating or changing functional behavior, APIs, data, state, permissions, error handling, architecture, requirements, domain terminology, design notes, specs, ADRs, or when domain terms are unclear. 需求讨论, 功能设计, 领域术语
---

# Grill

Clarify functional work and domain language before implementation.

## Process

1. Inspect existing code, docs, `CONTEXT.md`, and ADRs before asking questions.
2. Identify unresolved decision branches: behavior, data, API, state,
   permissions, errors, domain language.
3. Answer branches from the repository when possible.
4. Interview the user — one question at a time, with your recommended answer.
   Ask at least 3 meaningful questions for unclear work. If fewer are needed,
   state which branches were already resolved from code or docs.
5. Challenge vague or conflicting domain language.
6. Update `CONTEXT.md` immediately when terms are resolved.
7. Choose the document level and write the artifact.
8. Ask the user to approve before implementation.

## Document Levels

| Level | File | When |
|---|---|---|
| 0 | none | Visual micro-change, typo, formatting |
| 1 | `docs/agents/notes/YYYY-MM-DD-topic.md` | Single feature, single module |
| 2 | `docs/agents/specs/YYYY-MM-DD-topic-design.md` | Multi-module, API, data flow |
| 3 | Level 2 spec → route to `plan` | Needs sequencing or delegation |
| ADR | `docs/adr/NNNN-title.md` | Hard to reverse, surprising, trade-off |

## Domain Language

- Look for `CONTEXT.md`, `CONTEXT-MAP.md`, `docs/adr/` before naming concepts.
- Capture stable domain terms, not implementation details.
- Record rejected alternatives when a term is disputed.

## Gate

Stop after writing the artifact. No code until user approves.
