---
name: slice-to-issues
description: Use when an approved plan, spec, PRD, or TODO list needs to be broken into independently implementable issues, tickets, tasks, vertical slices, or local docs/agents/issues items
---

# Slice To Issues

## Overview

Break approved work into independently grabbable vertical slices.

## Process

1. Read the source artifact and implementation plan.
2. Identify user-visible or system-visible slices.
3. Keep each issue independently testable and reviewable.
4. Include dependencies only when a slice truly cannot stand alone.
5. Write issues locally under `docs/agents/issues/` unless the user asks for a tracker.
6. Use `templates/issue.md` for each issue.

## Issue Quality

Good issues have one behavior, a clear test, and limited file ownership.

Avoid:

- Layer-only tickets like "database part" or "frontend part" when a vertical
  slice is possible.
- Giant issues that require many unrelated behaviors.
- Speculative follow-up work not required by the source artifact.
