# Review Feedback Rigor Reference

## Feedback Classes

| Class | Action |
| --- | --- |
| Correct and clear | Implement one item at a time, then test |
| Correct but broad | Split into smaller changes |
| Ambiguous | Restate and ask for clarification |
| Conflicts with artifact | Check the source artifact or ADR before changing |
| Wrong or harmful | Push back with evidence |
| Speculative | Defer unless product need is explicit |

## Response Shape

```text
Accepted:
- <Feedback> -> <change> -> <verification>

Needs clarification:
- <Question>

Pushing back:
- <Feedback>
- Evidence: <code, test, doc, or behavior>
- Recommendation: <alternative>
```

## Red Flags

- Implementing before reading all comments.
- Saying "fixed" without verification.
- Removing compatibility because a reviewer guessed it is unused.
- Bundling unrelated review suggestions into one change.
