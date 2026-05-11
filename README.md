# My Skills

Lightweight engineering workflow skills for coding agents.

Designed for daily development with Codex, Claude Code, and Cursor. Not a heavy
methodology — just the important engineering gates:

- clarify functional changes before implementation
- write the right level of documentation
- use domain language consistently
- plan larger work before coding
- implement behavior with TDD
- diagnose bugs before patching
- verify before claiming completion

## Supported Agents

| Agent | Status | Entry point |
|---|---|---|
| Codex | Supported | `.codex-plugin/plugin.json`, `scripts/install-codex-skills.sh` |
| Claude Code | Supported | `.claude-plugin/plugin.json`, `hooks/` |
| Cursor | Supported | `.cursor-plugin/plugin.json` |
| Gemini | Compatibility | `GEMINI.md` |

## Skills

| Skill | When |
|---|---|
| [`grill`](skills/engineering/grill/SKILL.md) | New feature, behavior change, API/data change, domain terms unclear |
| [`plan`](skills/engineering/plan/SKILL.md) | Sequencing approved work into steps and vertical slices |
| [`tdd`](skills/engineering/tdd/SKILL.md) | Implementing behavior one red→green→refactor cycle at a time |
| [`diagnose`](skills/engineering/diagnose/SKILL.md) | Bugs, errors, failures — reproduce first, fix second |
| [`finish`](skills/engineering/finish/SKILL.md) | Verify diff + evidence, then commit/push/PR |
| [`review`](skills/engineering/review/SKILL.md) | Handling code review feedback with verification |
| [`architecture`](skills/engineering/architecture/SKILL.md) | Coupling, boundaries, test seams blocking current work |
| [`subagents`](skills/engineering/subagents/SKILL.md) | Parallel delegation for large approved work |
| [`prototype`](skills/engineering/prototype/SKILL.md) | Quick spike or PoC, skip full gates |
| [`caveman`](skills/engineering/caveman/SKILL.md) | Terse communication, same gates |

## How Triggering Works

Three layers ensure skills activate:

1. **SKILL.md `description`** — each skill has keywords (中英双语) that the
   agent matches semantically against user intent
2. **`skills/TRIGGERS.md`** — a compact intent→skill mapping table injected
   via SessionStart hook
3. **`CLAUDE.md` / `AGENTS.md`** — instructs the agent to read TRIGGERS.md
   before any coding task

No dedicated router skill. The agent matches intent directly.

## Default Flow

```text
grill → user approves artifact → plan (if multi-step) → tdd → finish
```

Bug flow:

```text
diagnose → tdd (regression test) → finish
```

Review flow:

```text
review → diagnose or tdd as needed → finish
```

## Documentation Levels

| Level | File | When |
|---|---|---|
| 0 | none | Visual micro-change, typo, formatting |
| 1 | `docs/agents/notes/YYYY-MM-DD-topic.md` | Single feature, single module |
| 2 | `docs/agents/specs/YYYY-MM-DD-topic-design.md` | Multi-module, API, data flow |
| 3 | Level 2 + `docs/agents/plans/YYYY-MM-DD-topic.md` | Needs sequencing |
| ADR | `docs/adr/NNNN-title.md` | Hard to reverse, trade-off driven |
| Domain | `CONTEXT.md` | Domain term or boundary resolved |

## Install

### Claude Code

```bash
claude -p "<prompt>" --plugin-dir "$PWD"
```

The `hooks/session-start` hook injects `TRIGGERS.md` at session start.

### Codex

```bash
scripts/install-codex-skills.sh
```

Preview first: `scripts/install-codex-skills.sh --dry-run`

### Cursor

Uses `.cursor-plugin/plugin.json` with `hooks/hooks-cursor.json`.

## Contributing

Skill changes are behavior changes, not prose edits. For functional changes:

- write or update the relevant artifact under `docs/agents/`
- keep `SKILL.md` files concise
- update tests when routing behavior changes
- run `tests/codex/validate-plugin-shape.sh`

Before opening a PR, show the complete diff and get explicit approval.
