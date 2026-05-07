# Verify Before Done Reference

## Evidence Matrix

| Claim | Strong evidence |
| --- | --- |
| Tests pass | Fresh command, exit status, relevant output |
| Build works | Fresh build command and exit status |
| Bug fixed | Original repro fails before and passes after |
| UI works | Browser interaction, screenshot, DOM assertion, or visual check |
| API works | Request/response evidence and status code |
| Review addressed | Comment-by-comment checklist plus tests |
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
