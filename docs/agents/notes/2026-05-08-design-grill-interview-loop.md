# Design Grill Interview Loop

## Context

`design-grill-docs` currently says to inspect code/docs, ask one question at a
time when code cannot answer it, then write the smallest sufficient artifact.
That is directionally right, but it is too easy for an agent to ask one shallow
clarification question, write a document, and miss unresolved requirements.

Matt Pocock's `grill-me` skill is intentionally stronger: interview the user
relentlessly, walk each branch of the design tree, ask one question at a time,
provide a recommended answer for each question, and inspect the codebase instead
of asking when the answer is discoverable.

## Decision

Update `design-grill-docs` so functional design work includes an explicit
interview loop before writing the artifact.

The loop should:

- inspect existing code and docs first
- identify unresolved decision branches
- ask exactly one question at a time
- include a recommended answer with each question
- explain why the answer matters when the trade-off is not obvious
- use the user's answer to choose the next branch
- ask at least three meaningful questions for unclear functional work unless
  code/docs resolve enough branches to make fewer questions sufficient
- stop only when the remaining unknowns are either resolved, intentionally
  deferred, or small enough to document as assumptions
- then write the smallest sufficient artifact and ask for approval before
  implementation

The loop should not ask the user to explain facts that can be found by reading
the repository.

## Scope

This change updates the skill instructions only. It does not add a separate
`grill-me` skill because the current suite already routes functional design
work through `design-grill-docs`.

## Acceptance

- `design-grill-docs` makes multi-turn interviewing a required part of
  unresolved functional design work.
- Unclear functional work gets at least three meaningful questions unless the
  skill states which branches were already resolved from repository evidence.
- The skill still keeps questions one at a time.
- Each user-facing question includes a recommended answer.
- The skill still writes documentation before implementation.
- The skill still avoids unnecessary questions when code/docs can answer them.
