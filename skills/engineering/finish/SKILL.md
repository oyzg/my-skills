---
name: finish
description: Use when claiming work is done, committing, pushing, creating PR, merging, or cleaning up branches. 提交, 完成, push, PR, merge
---

# Finish

Verify before claiming done, then handle git operations.

## Verify Gate

Before any completion claim:

1. Inspect the current diff.
2. Check changes match the task and approved artifact.
3. Look for unrelated edits, scope creep, missing tests.
4. Run fresh verification — read output and exit status.
5. State the actual result. A blocked check is not a pass.

Red flags: "Should pass", "Looks fixed", "I already ran it earlier."

## Reconciliation Gate (mandatory)

Before commit / PR / marking work done, produce an explicit reconciliation
table comparing the approved plan to what was actually built:

```
| Slice / Acceptance criterion | Status | Evidence (file:line, test, demo) | Notes |
|---|---|---|---|
| ... | ✅ / ❌ / ⚠️ | ... | ... |
```

Rules:
- Every acceptance criterion from the plan must appear as a row.
- ✅ requires concrete evidence (passing test, demo output, file location).
- ❌ or ⚠️ rows BLOCK finish. They require an explicit user decision
  (accept as-is, defer to follow-up issue, or keep working) before any commit,
  push, or PR is allowed.
- Skipped/xfailed/TODO/mock placeholders are ❌, not ✅.
- "It compiles" / "it runs" without criterion-level evidence is ❌.

Only after the table is fully ✅ or all non-✅ rows have user sign-off may you
proceed to branch operations.

## Branch Operations

After verification passes:

1. Detect current branch and workspace type.
2. For explicit commit/push requests, do the action.
3. For open-ended finish requests, present options:
   - Merge locally
   - Push and create PR
   - Keep branch as-is
   - Discard (requires explicit confirmation)
4. Before creating a PR, check for duplicate PRs and satisfy the repo's
   PR template.

## Required Evidence

| Claim | Evidence |
|---|---|
| Tests pass | Fresh test output |
| Build succeeds | Fresh build output |
| Bug fixed | Original repro no longer reproduces |
| Requirements met | Checklist against approved artifact |
| Diff is clean | No unrelated changes |
