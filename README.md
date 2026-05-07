# My Skills

Lightweight documented engineering workflow skills for Codex-first coding
agents.

This plugin combines a small router skill with focused engineering workflows:
functional work gets written decisions and executable plans when needed,
domain language is captured, approved work can be sliced into local issues,
bugs get diagnosis before patches, behavior changes get TDD, review feedback
gets checked, and completion claims need fresh evidence. Core `SKILL.md` files
stay short; high-value workflows include templates or references that Codex
loads only when needed.

## Primary Target

This repository is primarily for Codex through `.codex-plugin/plugin.json`.
Claude, Cursor, Gemini, and OpenCode metadata are compatibility layers.

## Skills

| Skill | Purpose |
| --- | --- |
| `engineering-flow-lite` | Route tasks and enforce gates |
| `setup-project-context` | Initialize project docs and context conventions |
| `domain-context` | Capture domain language and boundaries |
| `design-grill-docs` | Clarify functional work and write docs |
| `write-implementation-plan` | Turn approved docs into executable plans |
| `slice-to-issues` | Split approved work into local vertical-slice issues |
| `tdd-behavior-slices` | Implement behavior through vertical TDD |
| `diagnose-feedback-loop` | Diagnose bugs with feedback loops |
| `architecture-deepening` | Improve structure where current work needs it |
| `review-feedback-rigor` | Handle review feedback with verification |
| `verify-before-done` | Require fresh evidence before completion claims |
| `branch-finish-lite` | Finish verified branch work |
| `caveman` | Compress communication without skipping gates |

## Core Rule

Functional implementation requires a written artifact before code. Functional
work includes changes to behavior, data, APIs, state, permissions, error
handling, architecture, or tests.

Pure visual micro-tweaks, typos, formatting-only changes, and narrow
non-behavioral cleanup do not require a document.

## Default Flow

```text
engineering-flow-lite
-> setup-project-context when repo workflow docs are missing
-> domain-context when terms or boundaries are unclear
-> design-grill-docs
-> user approves artifact
-> write-implementation-plan when sequencing is needed
-> slice-to-issues when local issue slices are useful
-> tdd-behavior-slices
-> verify-before-done
-> branch-finish-lite when integration is needed
```

Bug flow:

```text
engineering-flow-lite
-> diagnose-feedback-loop
-> tdd-behavior-slices
-> verify-before-done
```

Review flow:

```text
engineering-flow-lite
-> review-feedback-rigor
-> diagnose-feedback-loop or tdd-behavior-slices when needed
-> verify-before-done
```

## Documentation Levels

| Level | File | Use when |
| --- | --- | --- |
| 0 | none | Visual-only micro-change, typo, formatting-only, non-behavioral config cleanup |
| 1 | `docs/agents/notes/YYYY-MM-DD-topic.md` | Single feature, single-module behavior, small logic bug |
| 2 | `docs/agents/specs/YYYY-MM-DD-topic-design.md` | Multi-module behavior, API, data flow, permission, error handling |
| 3 | Level 2 plus `docs/agents/plans/YYYY-MM-DD-topic.md` | Work needs sequencing, delegation, or multiple implementation tasks |
| Issues | `docs/agents/issues/YYYY-MM-DD-topic.md` | Approved work needs independently implementable local slices |
| ADR | `docs/adr/NNNN-title.md` | Hard to reverse, surprising, trade-off driven |
| Domain context | `CONTEXT.md` | Domain term or boundary is resolved |

## Testing

Codex structural validation:

```bash
tests/codex/validate-plugin-shape.sh
```

Codex behavior pressure tests:

```bash
tests/codex/run-pressure-tests.sh
```

Repeat cases to catch flaky routing:

```bash
tests/codex/run-pressure-tests.sh --repeat 3
```

The Codex runner uses `codex exec --ephemeral` with a temporary `CODEX_HOME`.
It copies local Codex CLI authentication, then points that home's `skills/`
directory at this working tree. It checks routing decisions for setup, domain
context, docs, planning, issue slicing, TDD, diagnosis, review, verification,
branch finish, architecture, and caveman gates. Set
`CODEX_PRESSURE_COPY_CONFIG=1` only when the default Codex CLI configuration is
insufficient. The runner defaults to
`CODEX_PRESSURE_MODEL=gpt-5.4` because older Codex CLI builds may reject newer
configured models. It also defaults to
`CODEX_PRESSURE_DISABLE_TOOL_SUGGEST=1` so connector-directory network issues
do not affect skill routing tests.

If the runner reports a Codex CLI network/model startup issue, the case did not
reach skill behavior evaluation. Fix Codex CLI access, then rerun the failed
case by name.

Optional Claude CLI compatibility pressure prompts live in
`tests/documented-engineering-flow/prompts/`.

Run:

```bash
tests/documented-engineering-flow/run-pressure-tests.sh
```

The pressure runner records logs under `/tmp/my-skills-tests/` and requires
Claude CLI API access.
