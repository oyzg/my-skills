---
name: architecture-deepening
description: Use when code structure, module boundaries, coupling, poor test seams, or confusing flows make current work harder than it should be
---

# Architecture Deepening

## Overview

Improve structure only where it serves the current task.

## Process

1. Zoom out from the immediate file to related modules and flows.
2. Identify shallow modules, hidden coupling, mixed responsibilities, and poor test seams.
3. Propose deep modules: small interface, deeper implementation, clear ownership.
4. Tie every recommendation to the current feature, bug, or testability problem.
5. Send functional or structural changes through `design-grill-docs` before implementation.

## Documentation Gate

Architecture analysis can start without a new document. Architecture
implementation, module-boundary changes, data-flow changes, or structural
refactors require a written artifact before code changes.

## What To Look For

- Many callers need to know internal details.
- Tests must mock private collaborators to prove behavior.
- A file changes for unrelated reasons.
- Data shape changes ripple through many modules.
- The only available regression seam is too shallow to catch the real bug.

See `REFERENCE.md` for deep-module signals and recommendation shape.

## Guardrails

- No broad unrelated refactors.
- Do not rename or reorganize code just for style.
- Use ADRs for hard-to-reverse architecture decisions.
- Keep recommendations specific enough to test.
