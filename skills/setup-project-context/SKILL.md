---
name: setup-project-context
description: Use when setting up a repository to use My Skills, choosing docs/agents locations, initializing CONTEXT.md, docs/agents directories, local issue files, or project workflow conventions
---

# Setup Project Context

## Overview

Create the small project scaffolding that the other skills assume.

## Visibility

Start with one concise line naming this skill and why.

## Process

1. Inspect existing project instructions and docs.
2. Create or update project agent instructions from
   `templates/agent-instructions.md` when `AGENTS.md`, `CLAUDE.md`, or
   equivalent files are missing or do not require `using-my-skills`.
3. Create missing directories only when useful:
   - `docs/agents/notes/`
   - `docs/agents/specs/`
   - `docs/agents/plans/`
   - `docs/agents/issues/`
   - `docs/adr/`
4. Create `CONTEXT.md` from `templates/context.md` when domain terms matter.
5. Write `docs/agents/README.md` from `templates/agents-readme.md`.
6. Keep setup local and tool-agnostic unless the user asks for GitHub/Linear.

## Guardrails

- Do not overwrite existing docs.
- Preserve existing project instructions; append the router rule instead of
  replacing unrelated guidance.
- Do not add external dependencies.
- Keep setup minimal; project conventions belong in project docs, not skills.
