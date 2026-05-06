# Diagnosis Feedback Loop Reference

## Fast Loop Examples

| Symptom | First useful loop |
| --- | --- |
| API bug | focused request script or API test |
| UI regression | browser repro, DOM assertion, or screenshot |
| flaky test | repeated focused test with seed/logging |
| build failure | smallest failing build command |
| data bug | fixture import plus query/assertion |

## Hypothesis Shape

```text
If <cause> is true, then <probe> will show <observable result>.
```

Good:

```text
If the cache key omits tenant id, then two tenants with the same project id
will read the same cached permissions entry.
```

Bad:

```text
Maybe cache is broken.
```

## Stop And Reassess

- The repro cannot be made deterministic.
- More than two patches failed.
- The test seam is too shallow to prove the user symptom.
- Fixing the bug requires changing module boundaries or ownership.
