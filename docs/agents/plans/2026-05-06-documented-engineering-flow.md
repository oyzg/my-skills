# Documented Engineering Flow Migration Plan

## Goal

Replace the previous heavy workflow with a nine-skill lightweight documented
engineering flow for Codex-first usage.

## Final Skill Set

- `engineering-flow-lite`
- `design-grill-docs`
- `tdd-behavior-slices`
- `diagnose-feedback-loop`
- `architecture-deepening`
- `review-feedback-rigor`
- `verify-before-done`
- `branch-finish-lite`
- `caveman`

## Implementation Steps

1. Add adversarial pressure-test prompts under `tests/documented-engineering-flow/prompts/`.
2. Add `tests/documented-engineering-flow/run-pressure-tests.sh`.
3. Create the nine replacement skills under `skills/`.
4. Update plugin manifests, bootstrap docs, and hook injection to `my-skills`.
5. Replace trigger-test prompts with the new skill names.
6. Remove legacy skill directories and legacy workflow test suites.
7. Verify Codex plugin shape, manifests, hook syntax, skill file set, and stale
   references.
8. Add Codex-first behavior pressure tests that mount the local `skills/`
   directory in an isolated `CODEX_HOME` and validate the agent's routing
   decisions with structured output.

## Verification Notes

JSON manifests should validate with:

```bash
python3 -m json.tool package.json
python3 -m json.tool .codex-plugin/plugin.json
python3 -m json.tool .claude-plugin/plugin.json
python3 -m json.tool .claude-plugin/marketplace.json
python3 -m json.tool .cursor-plugin/plugin.json
```

OpenCode bootstrap syntax should validate with:

```bash
node --check .opencode/plugins/my-skills.js
```

Codex plugin shape should validate with:

```bash
tests/codex/validate-plugin-shape.sh
```

Codex behavior pressure tests should validate routing decisions with:

```bash
tests/codex/run-pressure-tests.sh
```

The Codex runner uses `codex exec --ephemeral` and a temporary `CODEX_HOME`.
It copies local Codex CLI authentication, then points `skills/` at this working
tree. Each case asks Codex to choose the smallest applicable workflow and
returns JSON checked by the test script. These tests cover docs, TDD, diagnosis,
review, verification, branch finish, architecture, and caveman gates. Full
Codex config copying is opt-in through `CODEX_PRESSURE_COPY_CONFIG=1` so global
plugin settings do not pollute the pressure-test environment by default.
The runner defaults to `CODEX_PRESSURE_MODEL=gpt-5.4` to avoid failing on local
Codex CLI builds that do not yet support newer configured models.
If Codex CLI fails during network/model startup, treat the run as blocked before
behavior evaluation and rerun the failed case after fixing CLI access.

Optional compatibility pressure tests require Claude CLI API access:

```bash
tests/documented-engineering-flow/run-pressure-tests.sh
```

In the sandboxed Codex environment, Claude CLI can initialize the plugin but
API calls may fail or time out. Treat that as an environment blocker, not a
passing behavioral test.
