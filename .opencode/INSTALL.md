# Installing My Skills for OpenCode

## Prerequisites

- [OpenCode.ai](https://opencode.ai) installed

## Installation

Add this plugin to the `plugin` array in your `opencode.json`:

```json
{
  "plugin": ["my-skills@git+https://github.com/oyzg/my-skills.git"]
}
```

Restart OpenCode. The plugin registers all skills and injects the
`engineering-flow-lite` bootstrap.

## Usage

Use OpenCode's native `skill` tool:

```text
use skill tool to list skills
use skill tool to load my-skills/engineering-flow-lite
```

## Troubleshooting

1. Check OpenCode logs for plugin load errors.
2. Verify the plugin line in `opencode.json`.
3. Use the skill tool to list discovered skills.

When skills reference Claude Code tools:

- `TodoWrite` maps to OpenCode's todo tool.
- `Task` with subagents maps to OpenCode's subagent system.
- `Skill` maps to OpenCode's native skill tool.
- File operations map to the host's native file tools.
