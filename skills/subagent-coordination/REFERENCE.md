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

## Negative Examples

### No Artifact

```text
Request: "Build this large feature with subagents."
State: No design note, spec, or implementation plan exists.
Decision: Do not delegate. Route to design docs first.
```

### Spec But No Plan

```text
Request: "The spec is approved, now use subagents."
State: No implementation plan or ownership split exists.
Decision: Do not delegate. Write the implementation plan first.
```

### Overlapping Ownership

```text
Request: "Send one subagent to update auth and one to update billing."
State: Both tasks need `backend/routes/account.ts` and shared permission logic.
Decision: Do not delegate yet. Split the ownership or keep the work local.
```

### Blocking Work

```text
Request: "Have a subagent decide the new API contract while we continue."
State: The main implementation depends on that API contract.
Decision: Do not delegate. Decide the contract in the main session.
```

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
