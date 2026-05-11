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
   Scale question count to the work's scope and novelty:
   - **Trivial change / single tweak**: at least 3 meaningful questions.
   - **Small feature on existing system**: at least 5–7 questions.
   - **0→1 simple new system / standalone tool**: at least **10 questions**,
     covering users, core flows, data model, persistence, interfaces, errors,
     non-functional requirements, scope cuts, success criteria.
   - **0→1 complex system** (multi-module, multi-actor, distributed, or with
     significant domain modeling): at least **15 questions**, additionally
     covering boundaries/integrations, auth & permissions, consistency model,
     failure & recovery, scaling expectations, observability, migration/rollout,
     deprecation/exit, security & compliance, and explicit non-goals.

   If fewer questions are needed, state which branches were already resolved
   from code, docs, or earlier answers. Do not stop early just because the user
   sounds confident — explicitly check each branch before skipping it.
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
