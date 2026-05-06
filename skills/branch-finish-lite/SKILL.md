---
name: branch-finish-lite
description: Use when implementation is complete and the user needs merge, pull request, keep-branch, discard, or branch cleanup options
---

# Branch Finish Lite

## Overview

Finish verified development work without hiding risk.

## Process

1. Use `verify-before-done` first.
2. Detect current branch and workspace type.
3. Present options: merge locally, push/create PR, keep branch, discard.
4. Require explicit confirmation before discard.
5. Preserve worktree when creating a PR.

## Options

```text
Implementation verified. What would you like to do?

1. Merge locally
2. Push and create a PR
3. Keep branch as-is
4. Discard this work
```

## PR Guard

Before creating a PR, read and satisfy the repository PR template and check for
duplicate open or closed PRs when targeting an upstream project.

## Discard Guard

Discard permanently removes work. Show branch name, commits, and affected
workspace, then require exact user confirmation before deleting anything.
