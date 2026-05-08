# My Skills

My Skills is a practical engineering workflow skill suite for coding agents.

It is designed for daily software development with Codex and Claude Code. The
goal is not to make the agent follow a heavy methodology for every task. The
goal is to keep the important engineering gates in place:

- clarify functional changes before implementation
- write the right level of documentation
- use domain language consistently
- plan larger work before coding
- split approved work into reviewable slices when useful
- use subagents only when ownership is independent
- implement behavior with TDD
- diagnose bugs before patching
- verify the diff and evidence before claiming completion

The suite is intentionally middleweight: more disciplined than a loose set of
one-off prompts, but lighter than a full process framework.

## Supported Agents

| Agent | Status | Entry point |
| --- | --- | --- |
| Codex | Supported | `.codex-plugin/plugin.json`, `scripts/install-codex-skills.sh` |
| Claude Code | Supported | `.claude-plugin/plugin.json`, `hooks/` |
| Cursor | Compatibility metadata | `.cursor-plugin/plugin.json` |
| Gemini | Compatibility metadata | `gemini-extension.json`, `GEMINI.md` |
| OpenCode | Compatibility metadata | `.opencode/` |

Codex and Claude Code are the primary targets. Other metadata is kept so the
same skill set can be adapted without changing the skill content.

## Skills

| Skill | When it applies |
| --- | --- |
| `engineering-flow-lite` | Starting coding-session work or choosing the correct workflow |
| `setup-project-context` | Setting up repo-level docs, context, and agent conventions |
| `domain-context` | Clarifying project terms, boundaries, and shared language |
| `design-grill-docs` | Interviewing unclear functional work, then writing the right artifact before implementation |
| `write-implementation-plan` | Turning an approved artifact into ordered implementation steps |
| `slice-to-issues` | Splitting approved work into independently reviewable local issues |
| `subagent-coordination` | Coordinating optional subagents for large independent work |
| `tdd-behavior-slices` | Implementing observable behavior one TDD slice at a time |
| `diagnose-feedback-loop` | Investigating bugs, failures, regressions, or unexpected behavior |
| `architecture-deepening` | Improving structure when boundaries or test seams block the task |
| `review-feedback-rigor` | Handling review feedback with verification and pushback when needed |
| `verify-before-done` | Inspecting diff and fresh evidence before completion claims |
| `branch-finish-lite` | Committing, pushing, or finishing verified branch work |
| `caveman` | Compressing communication without skipping workflow gates |

## Core Rules

Functional implementation requires a written artifact before code. Functional
work includes behavior, data, APIs, state, permissions, error handling,
architecture, and tests.

Pure visual micro-tweaks, typos, formatting-only edits, and narrow
non-behavioral cleanup do not require a document.

Subagents are optional. They may be used only after documentation/planning,
explicit approval for delegation, and a clear split of file or module
ownership.

Completion claims require a quality gate: inspect the current diff, compare the
change with the approved artifact or plan, and run fresh verification.

When a skill is used, the agent should say so briefly before doing the work.
The visible line is intentionally short, so users can tell the workflow is
active without paying for a long explanation.

## Default Flow

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
| 2 | `docs/agents/specs/YYYY-MM-DD-topic-design.md` | Multi-module behavior, API, data flow, permissions, error handling |
| 3 | Level 2 plus `docs/agents/plans/YYYY-MM-DD-topic.md` | Work needs sequencing, delegation, or multiple implementation tasks |
| Issues | `docs/agents/issues/YYYY-MM-DD-topic.md` | Approved work needs independently implementable local slices |
| ADR | `docs/adr/NNNN-title.md` | Hard to reverse, surprising, trade-off driven |
| Domain context | `CONTEXT.md` | Domain term or boundary is resolved |

Concrete examples live in `docs/agents/examples/`. Use them to calibrate the
expected detail level for context docs, design notes, specs, plans, local
issues, and subagent delegation packets.

## Install

### Codex

Install or refresh this local skill set for Codex:

```bash
scripts/install-codex-skills.sh
```

Preview changes first:

```bash
scripts/install-codex-skills.sh --dry-run
```

The script links `skills/*` into `${CODEX_HOME:-~/.codex}/skills`. Restart
Codex after installing. Use `--force` only when intentionally replacing an
existing non-symlink skill directory with the same name.

### Claude Code

Claude Code support is provided by:

- `.claude-plugin/plugin.json`
- `hooks/hooks.json`
- `hooks/session-start`

The session-start hook injects `engineering-flow-lite` as the routing bootstrap
so Claude Code starts with the same workflow discipline.

For local compatibility testing:

```bash
claude -p "<prompt>" --plugin-dir "$PWD"
```

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

Claude Code compatibility tests:

```bash
tests/skill-triggering/run-all.sh
tests/explicit-skill-requests/run-all.sh
tests/documented-engineering-flow/run-pressure-tests.sh
```

Codex pressure tests use `codex exec --ephemeral` with a temporary
`CODEX_HOME`. Claude Code compatibility tests require Claude CLI API access.
All pressure-test logs are written under `/tmp/my-skills-tests/`.

## Contributing

This is a public repository, but skill changes should be treated as behavior
changes, not prose edits. For functional changes:

- write or update the relevant artifact under `docs/agents/`
- keep `SKILL.md` files concise
- put heavier guidance in `REFERENCE.md`, templates, or examples
- update pressure tests when routing behavior changes
- run `tests/codex/validate-plugin-shape.sh`

Before opening a PR, fill out `.github/PULL_REQUEST_TEMPLATE.md` and include
real verification evidence.
