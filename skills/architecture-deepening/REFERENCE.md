# Architecture Deepening Reference

## Deep Module Signals

Prefer modules with small public interfaces and substantial internal behavior.

Good signs:
- Callers do not know storage details.
- Tests assert behavior through stable boundaries.
- Related decisions live together.
- Adding one behavior changes few files.

Shallow signs:
- Callers assemble internal data shapes.
- Tests mock private helpers.
- One file changes for unrelated reasons.
- Data or permission rules are duplicated across layers.

## Recommendation Shape

```text
Problem: <current coupling or testability issue>
Boundary: <new or clearer ownership boundary>
Interface: <small public API>
Migration: <safe sequence>
Verification: <behavior tests proving no regression>
```

## Avoid

- Renaming for style.
- Splitting files without reducing caller knowledge.
- Broad cleanup not required by the current task.
- Architecture work without a verification seam.
