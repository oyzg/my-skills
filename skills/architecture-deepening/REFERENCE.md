# Architecture Deepening Reference

## How to Discover Structural Problems

1. Read the direct import graph of the affected file — which modules does it depend on?
2. Identify callers: who imports this module? Do callers know internal shapes?
3. Check test files for mock patterns — mocking private helpers signals a shallow boundary.
4. Run `git log --name-only` on the affected file — files that always change together likely share hidden coupling.
5. Trace data flow: where is the data created, transformed, and consumed? Count the layers that know its shape.
6. Look for duplicated validation or permission checks across layers — these signal a missing authoritative boundary.

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
