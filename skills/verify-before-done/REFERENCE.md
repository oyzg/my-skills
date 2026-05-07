# Verify Before Done Reference

## Diff Review Gate

Before running checks, inspect the current changes:

- `git status --short`
- relevant `git diff`
- staged vs unstaged changes when committing
- generated files or lockfiles that changed

Look for:

- unrelated edits or formatting churn
- scope added beyond the approved artifact or plan
- missing docs for functional changes
- missing tests for behavior changes
- broken domain language or naming consistency
- subagent patches outside their ownership

If the diff is not clean, fix or explain it before claiming completion.

## Artifact Alignment Gate

For functional work, compare the diff against the source artifact:

| Source | Check |
| --- | --- |
| Design note/spec | Required behavior is implemented and no unapproved behavior was added |
| Implementation plan | Planned slices are complete or remaining slices are named |
| Local issue | Acceptance criteria and test notes are addressed |
| ADR | Decision constraints are preserved |
| `CONTEXT.md` | Domain terms are used consistently |

## Evidence Matrix

| Claim | Strong evidence |
| --- | --- |
| Diff is clean | Fresh status/diff inspection and no unrelated changes |
| Tests pass | Fresh command, exit status, relevant output |
| Build works | Fresh build command and exit status |
| Bug fixed | Original repro fails before and passes after |
| UI works | Browser interaction, screenshot, DOM assertion, or visual check |
| API works | Request/response evidence and status code |
| Review addressed | Comment-by-comment checklist plus tests |
| Subagent work integrated | Delegated patches reviewed, ownership respected, combined checks run |
| Branch ready | Clean status, inspected diff, relevant checks |

## Completion Wording

Good:

```text
Verified with `npm test -- auth`: 42 passed.
Blocked from running browser check because dev server is unavailable.
```

Bad:

```text
Should be fixed.
Looks good.
Tests were probably fine.
```

## If Verification Is Blocked

State:

- What you tried.
- Why it failed.
- The strongest evidence still available.
- What would prove the claim next.
