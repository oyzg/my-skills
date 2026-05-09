---
name: architecture
description: Use when code structure, module boundaries, coupling, poor test seams, or confusing flows make current work harder. 架构, 重构, 太乱了, 耦合
---

# Architecture

Improve structure only where it serves the current task.

## Process

1. Zoom out from the immediate file to related modules and flows.
2. Identify shallow modules, hidden coupling, mixed responsibilities, poor test seams.
3. Propose deep modules: small interface, deeper implementation, clear ownership.
4. Tie every recommendation to the current feature, bug, or testability problem.
5. Structural changes require a `grill` artifact before implementation.

## What To Look For

- Many callers need to know internal details.
- Tests must mock private collaborators to prove behavior.
- A file changes for unrelated reasons.
- Data shape changes ripple through many modules.

## Guardrails

- No broad unrelated refactors.
- No renaming just for style.
- Use ADRs for hard-to-reverse decisions.
