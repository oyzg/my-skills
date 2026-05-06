#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$REPO_ROOT"

expected_skills=(
  "architecture-deepening"
  "branch-finish-lite"
  "caveman"
  "design-grill-docs"
  "diagnose-feedback-loop"
  "engineering-flow-lite"
  "review-feedback-rigor"
  "tdd-behavior-slices"
  "verify-before-done"
  "write-implementation-plan"
)

echo "Validating Codex plugin manifest..."
python3 -m json.tool .codex-plugin/plugin.json >/dev/null
python3 -m json.tool tests/codex/pressure-result.schema.json >/dev/null
bash -n tests/codex/run-pressure-tests.sh

echo "Validating Codex pressure test cases..."
for test_case in $(tests/codex/run-pressure-tests.sh --list); do
  if [ ! -f "tests/codex/prompts/$test_case.txt" ]; then
    echo "Missing Codex pressure prompt: $test_case"
    exit 1
  fi
done

python3 - <<'PY'
import json
from pathlib import Path

manifest = json.loads(Path(".codex-plugin/plugin.json").read_text())
assert manifest["name"] == "my-skills", manifest["name"]
assert manifest["skills"] == "./skills/", manifest["skills"]
assert manifest["interface"]["displayName"] == "My Skills"
assert "Coding" == manifest["interface"]["category"]
PY

echo "Validating skill set..."
actual="$(find skills -mindepth 2 -maxdepth 2 -name SKILL.md | sed 's#^skills/##; s#/SKILL.md$##' | sort)"
expected="$(printf '%s\n' "${expected_skills[@]}" | sort)"

if [ "$actual" != "$expected" ]; then
  echo "Skill set mismatch"
  echo "Expected:"
  printf '%s\n' "$expected"
  echo "Actual:"
  printf '%s\n' "$actual"
  exit 1
fi

echo "Validating skill frontmatter..."
for skill in "${expected_skills[@]}"; do
  file="skills/$skill/SKILL.md"
  grep -q '^---$' "$file"
  grep -q "^name: $skill$" "$file"
  grep -q '^description: Use when ' "$file"
done

echo "Validating skill support files..."
required_support_files=(
  "skills/architecture-deepening/REFERENCE.md"
  "skills/design-grill-docs/templates/adr.md"
  "skills/design-grill-docs/templates/design-note.md"
  "skills/design-grill-docs/templates/spec.md"
  "skills/diagnose-feedback-loop/REFERENCE.md"
  "skills/tdd-behavior-slices/REFERENCE.md"
  "skills/write-implementation-plan/templates/implementation-plan.md"
)

for file in "${required_support_files[@]}"; do
  if [ ! -s "$file" ]; then
    echo "Missing or empty support file: $file"
    exit 1
  fi
done

python3 - <<'PY'
import re
import sys
from pathlib import Path

errors = []

for skill_file in Path("skills").glob("*/SKILL.md"):
    skill_dir = skill_file.parent
    text = skill_file.read_text()

    for ref in re.findall(r"`([^`]+)`", text):
        if ref == "REFERENCE.md" or ref.startswith("templates/"):
            target = skill_dir / ref
            if not target.is_file():
                errors.append(f"{skill_file}: referenced support file is missing: {ref}")

if errors:
    for error in errors:
        print(error)
    sys.exit(1)
PY

echo "Checking for stale legacy skill references in active surfaces..."
legacy_pattern="using-""super""powers|brain""storming|subagent-driven-development|systematic-debugging|test-driven-development|verification-before-completion|requesting-code-review|writing-plans|executing-plans|dispatching-parallel-agents|finishing-a-development-branch|writing-skills"
if rg -n "$legacy_pattern" \
  README.md CLAUDE.md GEMINI.md .codex-plugin .claude-plugin .cursor-plugin .opencode hooks tests skills docs/agents \
  --glob '!tests/codex/validate-plugin-shape.sh'; then
  echo "Found stale legacy skill reference"
  exit 1
fi

echo "Codex plugin shape OK"
