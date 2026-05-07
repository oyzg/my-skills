# Subagent Coordination Reference

## Good Subagent Work

| Work type | Why it fits |
| --- | --- |
| Independent adapter or integration slice | Clear ownership and focused tests |
| UI state panel while main session handles API | Parallelizable with limited overlap |
| Test fixture expansion | Useful sidecar, easy to review |
| Migration of one isolated module | File ownership can be explicit |
| Investigation of a bounded code area | Does not block local implementation |

## Poor Subagent Work

| Work type | Risk |
| --- | --- |
| Core interface design | Needs tight shared judgment |
| The next blocking task | Main session will just wait |
| Cross-cutting refactor | High merge and behavior risk |
| Same file as another agent | Conflict-prone |
| Vague "implement the feature" task | Too broad to review safely |

## Delegation Packet

```text
Task: <specific outcome>
Context: <approved artifact or plan path>
Ownership: <files/modules this agent may edit>
Do not touch: <files/modules reserved for others>
Expected tests: <commands or evidence>
Coordination: Other agents may be editing this repo. Do not revert or overwrite
their work; adapt to existing changes.
Return: changed paths, verification run, blockers, and assumptions.
```

## Integration Checklist

- Changed paths match ownership.
- No unrelated cleanup or formatting churn.
- Tests cover the delegated behavior.
- Main plan still holds after integration.
- Combined verification passes or blockers are explicit.
