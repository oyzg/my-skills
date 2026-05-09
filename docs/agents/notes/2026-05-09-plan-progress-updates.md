# Plan Progress Updates

## Context

Implementation usually follows an approved plan step by step. The current
skills create plans, then implement behavior slices, but they do not explicitly
require updating the plan after each completed slice. That makes it harder for
the user and later agent turns to see which parts are done, which evidence
proved them, and where to resume.

## Decision

Implementation plans should be living progress documents.

When a plan exists and a slice or step is completed, update the plan before
moving on or claiming completion:

- mark the step as done
- add the verification evidence used for that step
- record any changed file/module ownership when it differs from the plan
- note follow-up risks or deferred work only when they affect later steps

The update should be small. Do not rewrite the plan or churn unrelated sections.

## Scope

This applies to `docs/agents/plans/*.md` and any equivalent approved
implementation plan. It does not require progress updates for pure micro-changes
that have no plan.

## Acceptance

- New plan templates include a status field per step.
- `tdd-behavior-slices` updates the plan after each completed behavior slice
  when a plan exists.
- `using-my-skills` workflow gates require plan progress updates before moving
  to the next planned step or claiming completion.
