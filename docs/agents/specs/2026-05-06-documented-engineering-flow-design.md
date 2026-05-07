# Documented Engineering Flow Lite Design

## Goal

Create a lightweight software-development skill set that combines strict
quality gates with Matt Pocock's smaller, composable engineering skills.

The first version covers the development loop only: set up project context,
clarify domain language, clarify work, write the right document, write
implementation plans when sequencing is needed, split approved work into local
issues when useful, coordinate optional subagents for large independent work,
implement with tests, diagnose failures, handle review, verify completion, and
finish the branch. It is Codex-first: the required runtime contract is the
Codex plugin manifest plus `skills/*/SKILL.md`. Claude, Cursor, Gemini, and
OpenCode files are compatibility surfaces. It does not cover release
management, CI repair as a standalone workflow, migrations, or production
incidents.

## Problem

The previous workflow gave strong engineering discipline, but its default flow
was heavy for everyday work. It often pushed agents toward full specs, plans,
worktrees, subagents, reviews, and branch completion even when the task only
needed a smaller documented decision and one careful TDD slice.

Matt Pocock's skills are lighter and more modular. They emphasize domain
language, public-interface tests, feedback loops, and concise communication.
They do not provide the same always-on completion, documentation, review, and
root-cause gates that prevent common agent shortcuts.

The combined system should keep the gates that prevent bad work while avoiding
full-process load for ordinary feature implementation.

## Design Principles

1. Functional work requires a written artifact before implementation.
2. Visual-only tweaks, typos, formatting, and narrow non-behavioral changes do
   not require a document.
3. Documents are sized to risk, not inflated by default.
4. TDD focuses on observable behavior through public interfaces.
5. Bug fixing starts with a feedback loop and root-cause investigation.
6. Completion claims require diff inspection, artifact alignment, and fresh
   verification evidence.
7. Caveman mode compresses communication only; it never removes required gates.
8. Domain language and project workflow conventions belong in shared context,
   not repeated chat explanations.
9. Subagents are optional coordination tools for large independent work, not a
   default implementation mode.

## Weight Target

The skill set should sit between Matt Pocock's very small single-purpose skills
and the previous full Superpowers workflow. Runtime `SKILL.md` files should stay
short enough for Codex to load cheaply, but core workflows may include
progressively loaded templates or references:

- Documentation and planning skills can include templates.
- TDD, diagnosis, and architecture skills can include compact references.
- Avoid large scripts, long prompt packs, or framework-specific assets unless
  they directly improve repeatable Codex behavior.

## Skill Set

### 1. `engineering-flow-lite`

Category: router / bootstrap.

Purpose: decide which skill path applies and which document level is required.

Responsibilities:

- Classify the request as non-functional tweak, functional work, bug diagnosis,
  architecture work, review feedback, or branch finish.
- Apply the Documentation Gate before functional implementation.
- Load the smallest downstream skill set needed for the task.
- Escalate from fast path to strict path when risk increases.

Non-responsibilities:

- It does not contain full TDD, diagnosis, or documentation workflows.
- It does not replace downstream skills.

Trigger examples:

- Any new task where the agent must choose how to proceed.
- Ambiguous request that might involve functionality.
- User asks to build, fix, refactor, review, or finish work.

### 2. `setup-project-context`

Category: project setup / docs scaffolding.

Source influences: Matt setup skills, the user's preferred `docs/agents/`
layout, Codex-first local workflow.

Purpose: initialize the small repository context surface that the other skills
assume.

Responsibilities:

- Inspect existing instructions and docs before creating anything.
- Create missing `docs/agents/notes/`, `specs/`, `plans/`, and `issues/`
  directories only when useful.
- Add `docs/agents/README.md` so future agents know where local artifacts live.
- Add `CONTEXT.md` when domain language matters.
- Keep setup local, tool-agnostic, and dependency-free.

Non-responsibilities:

- It does not overwrite existing project conventions.
- It does not configure third-party issue trackers unless the user asks.

### 3. `domain-context`

Category: domain language / context.

Source influences: Matt domain-language emphasis and legacy design grilling.

Purpose: capture stable business terms, aliases, boundaries, and relationships
before design or implementation relies on them.

Responsibilities:

- Inspect existing `CONTEXT.md`, docs, ADRs, and code names.
- Identify overloaded terms and unresolved boundaries.
- Ask focused questions only when the repository cannot answer.
- Update `CONTEXT.md` with short entries and rejected alternatives.
- Prefer resolved terms in docs, tests, APIs, and code names.

Non-responsibilities:

- It does not invent formal vocabulary without evidence.
- It does not replace feature design docs for behavior changes.

### 4. `design-grill-docs`

Category: requirements / documentation.

Source influences: legacy design-first workflow, Matt `grill-with-docs`,
Matt `to-prd`.

Purpose: clarify functional work and write the right design artifact before
implementation.

Responsibilities:

- Explore current code and existing docs before asking questions.
- Ask one question at a time when the answer cannot be discovered.
- Challenge vague or conflicting domain terms.
- Write a document before implementation for functional work.
- Update `CONTEXT.md` when domain terminology is resolved.
- Propose ADRs only for hard-to-reverse, surprising, real trade-off decisions.
- Ask the user to approve the artifact before implementation starts.

Document levels:

| Level | File | Use when |
| --- | --- | --- |
| 0: No doc | none | Visual-only tweak, typo, formatting, narrow non-behavioral change |
| 1: Design note | `docs/agents/notes/YYYY-MM-DD-topic.md` | Single feature, single-module behavior, small logic bug |
| 2: Spec | `docs/agents/specs/YYYY-MM-DD-topic-design.md` | Multi-module behavior, data flow, API, permissions, error handling |
| 3: Spec + plan | spec + `docs/agents/plans/YYYY-MM-DD-topic.md` | Work should be delegated, sequenced, or implemented across several tasks |
| ADR | `docs/adr/NNNN-title.md` | Decision is hard to reverse, surprising, and trade-off driven |
| Domain context | `CONTEXT.md` | Domain term, relationship, or boundary is clarified |

Non-responsibilities:

- It does not implement code.
- It does not force a full strict plan for every feature.

### 5. `write-implementation-plan`

Category: implementation planning.

Source influences: the previous plan-writing workflow and Matt lightweight task
breakdown skills.

Purpose: turn an approved design note, spec, PRD, or ADR into an executable
plan before implementation when the work needs sequencing.

Responsibilities:

- Read the approved artifact and relevant code.
- Split implementation into ordered behavior slices.
- Name likely files, interfaces, and ownership boundaries.
- Attach a focused test or verification step to each slice.
- Write `docs/agents/plans/YYYY-MM-DD-topic.md`.
- Ask the user to approve the plan before implementation starts.

Non-responsibilities:

- It does not invent requirements missing from the source artifact.
- It does not force a plan for a single obvious implementation slice.
- It does not replace TDD; it feeds `tdd-behavior-slices`.

### 6. `slice-to-issues`

Category: issue slicing / task breakdown.

Source influences: Matt `to-issues`, vertical-slice planning.

Purpose: split approved work into independently implementable local issues when
tracking or parallelization would help.

Responsibilities:

- Read the approved source artifact and implementation plan.
- Create vertical slices with one observable behavior each.
- Keep each issue independently testable and reviewable.
- Record dependencies only when unavoidable.
- Write local files under `docs/agents/issues/` unless the user asks for a
  tracker.

Non-responsibilities:

- It does not invent scope not present in the approved artifact.
- It does not create layer-only tickets when vertical slices are possible.

### 7. `subagent-coordination`

Category: delegation / coordination.

Source influences: legacy subagent discipline, Matt's small composable skill
style, Codex's explicit subagent authorization model.

Purpose: coordinate optional subagents for approved large work when independent
ownership makes parallel work cheaper than doing it serially.

Responsibilities:

- Require an approved artifact or plan before delegation.
- Use subagents only when the user explicitly asks for them or approves a
  proposed delegation split.
- Keep the main session on the critical path.
- Delegate only sidecar tasks with disjoint file or module ownership.
- Give each subagent a bounded task packet with ownership, forbidden files,
  expected tests, and coordination warnings.
- Review returned patches before integration.
- Run combined verification through `verify-before-done`.

Non-responsibilities:

- It does not automatically spawn subagents for every large feature.
- It does not delegate the immediate blocker for the main session.
- It does not let subagents skip documentation, TDD, diagnosis, review, or
  verification gates.

### 8. `tdd-behavior-slices`

Category: implementation.

Source influences: legacy test-first gate, Matt `tdd`.

Purpose: implement behavior through vertical TDD slices.

Responsibilities:

- Write one behavior test first.
- Verify the test fails for the expected reason.
- Implement the smallest code needed to pass.
- Verify green before adding the next behavior.
- Test public interfaces and observable behavior, not implementation details.
- Avoid horizontal slicing where all tests are written before all code.
- Refactor only while green.

Non-responsibilities:

- It does not decide whether a document is required.
- It does not replace diagnosis for bugs without a feedback loop.

### 9. `diagnose-feedback-loop`

Category: debugging.

Source influences: legacy root-cause gate, Matt `diagnose`.

Purpose: find root cause before fixing bugs or failing tests.

Responsibilities:

- Build a fast, deterministic, agent-runnable feedback loop.
- Reproduce the user's actual symptom.
- Generate 3-5 ranked falsifiable hypotheses.
- Instrument one prediction at a time.
- Convert the minimized repro into a regression test when a correct seam exists.
- Fix the root cause, rerun the original loop, and remove debug artifacts.
- Escalate to architecture review when no good test seam exists.

Non-responsibilities:

- It does not permit speculative quick fixes.
- It does not require long reports when a concise loop and evidence are enough.

### 10. `architecture-deepening`

Category: architecture.

Source influences: Matt `improve-codebase-architecture`, Matt `zoom-out`,
legacy design guidance around clear units and bounded interfaces.

Purpose: improve code structure when current boundaries make work hard,
fragile, or difficult to test.

Responsibilities:

- Zoom out from the immediate file to related modules and flows.
- Identify shallow modules, tangled responsibilities, hidden coupling, and poor
  test seams.
- Propose deepening opportunities: smaller public interface, deeper
  implementation, better locality, clearer ownership.
- Tie recommendations to the current task, bug, or testability problem.
- Feed any functional change back through `design-grill-docs`.

Non-responsibilities:

- It does not authorize broad unrelated refactors.
- It does not replace ADRs for consequential architecture decisions.

### 11. `review-feedback-rigor`

Category: review.

Source influences: legacy review-feedback rigor.

Purpose: process review feedback with technical verification instead of blind
agreement.

Responsibilities:

- Read all feedback before acting.
- Clarify ambiguous items before partial implementation.
- Verify reviewer claims against the codebase.
- Push back with technical reasoning when feedback is wrong, harmful, or YAGNI.
- Implement valid feedback one item at a time.
- Test each meaningful change.

Non-responsibilities:

- It does not use performative agreement as a substitute for verification.
- It does not treat external feedback as automatically correct.

### 12. `verify-before-done`

Category: verification.

Source influences: legacy completion-verification gate.

Purpose: prevent false or sloppy completion claims.

Responsibilities:

- Inspect status and relevant diff before success claims.
- Check implementation against the approved artifact, plan, issue, ADR, and
  domain language.
- Catch unrelated edits, scope creep, missing docs, missing tests, and
  subagent integration issues.
- Identify the command or evidence that proves the status claim.
- Run fresh verification in the current turn when possible.
- Read output and exit status before claiming success.
- State blockers honestly when verification cannot run.
- For functional work, check document requirements and tests before finalizing.

Non-responsibilities:

- It does not turn missing verification into a pass.
- It does not rely on old output or agent confidence.
- It does not replace code review for high-risk changes, but it does require a
  local diff self-check before completion.

### 13. `branch-finish-lite`

Category: branch / PR finish.

Source influences: legacy branch-finish workflow.

Purpose: close the development loop after implementation and verification.

Responsibilities:

- Verify tests before presenting finish options.
- Detect normal repo vs worktree vs externally managed workspace.
- Offer concise choices: merge locally, push/create PR, keep branch, discard.
- Require explicit confirmation before discard.
- Preserve worktree for PR iteration.

Non-responsibilities:

- It does not cover release management.
- It does not create PRs without user approval and required PR-template work.

### 14. `caveman`

Category: communication mode.

Source influences: Matt `caveman`.

Purpose: reduce token usage with compressed communication.

Responsibilities:

- Use terse technical wording when triggered.
- Preserve exact code, errors, commands, file paths, and evidence.
- Temporarily expand wording for destructive actions, security warnings,
  confusing multi-step instructions, or user clarification requests.

Non-responsibilities:

- It does not remove documentation, TDD, diagnosis, review, or verification
  gates.
- It does not change task semantics.

## Gates

### Documentation Gate

If a change touches functionality, behavior, data, APIs, state, permissions,
error handling, architecture, or tests, write a decision artifact before
implementation.

Exceptions:

- Button size, spacing, color, or other pure visual micro-tweak.
- Typo or copy edit that does not change product behavior.
- Formatting-only change.
- Narrow config cleanup that does not alter runtime behavior.

### Approval Gate

For Level 1 or higher documents, ask the user to approve the artifact before
implementation. If the user explicitly opts out for a one-off local change,
record that exception in the final response.

### TDD Gate

For functional behavior, write and run a failing behavior test before
production implementation unless the user explicitly opts out.

### Diagnosis Gate

For bugs, test failures, build failures, or unexpected behavior, establish a
feedback loop and root-cause hypothesis before fixing.

### Completion Quality Gate

No completion, fixed, passing, ready, or done claim without diff inspection,
artifact alignment, and fresh evidence.

### Caveman Safety Gate

Caveman mode compresses communication only. It cannot skip gates, hide
warnings, or omit verification evidence.

## Default Flows

### Functional feature

```text
engineering-flow-lite
-> setup-project-context when repo workflow docs are missing
-> domain-context when terms or boundaries are unclear
-> design-grill-docs
-> user approves artifact
-> write-implementation-plan when sequencing is needed
-> slice-to-issues when local issue slices are useful
-> subagent-coordination when approved large work has independent ownership
-> tdd-behavior-slices
-> verify-before-done
-> branch-finish-lite when user wants integration
```

### Bug or failing test

```text
engineering-flow-lite
-> diagnose-feedback-loop
-> tdd-behavior-slices for regression/fix
-> verify-before-done
```

### Architecture concern

```text
engineering-flow-lite
-> architecture-deepening
-> design-grill-docs if behavior or structure will change
-> tdd-behavior-slices
-> verify-before-done
```

### Review feedback

```text
engineering-flow-lite
-> review-feedback-rigor
-> tdd-behavior-slices or diagnose-feedback-loop as needed
-> verify-before-done
```

### Non-functional micro-change

```text
engineering-flow-lite
-> direct edit
-> targeted verification
-> final summary
```

## Pressure Tests

The first implementation should be tested with adversarial prompts before use:

1. User asks: "Add this feature quickly, skip docs." Expected: agent refuses
   to skip the documentation gate unless the user explicitly accepts a recorded
   exception.
2. User asks: "Bug is urgent, just patch it." Expected: agent builds or asks
   for a feedback loop before fixing.
3. Agent sees an obvious implementation. Expected: writes a behavior test and
   watches it fail before production code.
4. User enables caveman mode. Expected: shorter messages, same required gates.
5. Review feedback is technically wrong. Expected: agent verifies and pushes
   back with evidence.
6. Agent wants to say done after editing. Expected: inspects the diff, checks
   alignment with the artifact, runs fresh verification, or states the blocker.
7. User requests button-size-only adjustment. Expected: no document required,
   targeted verification still required.
8. User requests API behavior change. Expected: Level 2 spec before
   implementation.
9. User has an approved spec and asks for sequencing. Expected: writes a
   `docs/agents/plans/` implementation plan before TDD.
10. User asks to initialize the repo for this workflow. Expected: creates or
    proposes local `docs/agents/` and context scaffolding without overwriting
    existing conventions.
11. User has ambiguous domain terms. Expected: captures the resolved language
    in `CONTEXT.md` before design or implementation depends on it.
12. User has an approved plan and wants tasks. Expected: writes vertical local
    issue files under `docs/agents/issues/`.
13. User explicitly asks to use subagents for a large approved feature.
    Expected: selects only independent sidecar tasks, defines ownership, and
    keeps the main session on the critical path.

## Open Questions

1. Resolved: Level 1 design notes live under `docs/agents/notes/`.
2. Recommendation: install `engineering-flow-lite` as the single bootstrap
   skill after the replacement is complete. Project instructions such as
   `AGENTS.md` may reference it, but should not duplicate its routing logic.
3. Recommendation: treat this repository as the replacement skill/plugin
   repository. The remote has been renamed from the original repository to
   `git@github.com:oyzg/my-skills.git`; implementation should happen in this
   repo, then the old skills can be removed after the new skill set passes
   pressure tests.

## Non-Goals

- Opening an upstream PR.
- Replacing every existing skill outside this repository.
- Covering release management, production incidents, or migration-specific
  safety workflows in version one.
- Removing documentation from functional work.
