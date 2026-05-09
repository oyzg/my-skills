#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
PROMPT_DIR="$SCRIPT_DIR/prompts"
SCHEMA="$SCRIPT_DIR/pressure-result.schema.json"
TIMESTAMP="$(date +%s)"
OUTPUT_DIR="/tmp/my-skills-tests/$TIMESTAMP/codex-pressure"
TIMEOUT_SECONDS="${CODEX_PRESSURE_TIMEOUT_SECONDS:-180}"
REAL_CODEX_HOME="${CODEX_REAL_HOME:-$HOME/.codex}"
COPY_CONFIG="${CODEX_PRESSURE_COPY_CONFIG:-0}"
MODEL="${CODEX_PRESSURE_MODEL:-gpt-5.4}"
DISABLE_TOOL_SUGGEST="${CODEX_PRESSURE_DISABLE_TOOL_SUGGEST:-1}"
REPEAT=1
SELECTED_NAMES=()

mkdir -p "$OUTPUT_DIR"

if ! command -v codex >/dev/null 2>&1; then
  echo "codex CLI is required for Codex behavior pressure tests"
  exit 1
fi

CASES=(
  project-setup-context
  domain-language-confusion
  functional-skip-docs
  ambiguous-feature-grill
  approved-artifact-no-tests
  approved-spec-needs-plan
  approved-plan-to-issues
  large-feature-subagents
  large-feature-subagents-no-artifact
  approved-spec-subagents-no-plan
  subagents-overlapping-ownership
  urgent-bug-quick-fix
  parser-import-missing-modules
  chinese-empty-response-debug
  chinese-missing-visible-event
  wrong-review-feedback
  done-without-verification
  finish-branch-without-checks
  architecture-tangle
  caveman-functional-change
  button-size-micro-change
  typo-only-change
)

usage() {
  echo "Usage: $0 [--list] [--repeat N] [case-name ...]"
  echo ""
  echo "Environment:"
  echo "  CODEX_PRESSURE_TIMEOUT_SECONDS=180"
  echo "  CODEX_REAL_HOME=$HOME/.codex"
  echo "  CODEX_PRESSURE_COPY_CONFIG=0"
  echo "  CODEX_PRESSURE_MODEL=gpt-5.4"
  echo "  CODEX_PRESSURE_DISABLE_TOOL_SUGGEST=1"
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --help|-h)
      usage
      exit 0
      ;;
    --list)
      printf '%s\n' "${CASES[@]}"
      exit 0
      ;;
    --repeat)
      shift
      if [ "${1:-}" = "" ]; then
        echo "--repeat requires a positive integer"
        exit 1
      fi
      REPEAT="$1"
      ;;
    --repeat=*)
      REPEAT="${1#--repeat=}"
      ;;
    --)
      shift
      while [ "$#" -gt 0 ]; do
        SELECTED_NAMES+=("$1")
        shift
      done
      break
      ;;
    -*)
      echo "Unknown option: $1"
      usage
      exit 1
      ;;
    *)
      SELECTED_NAMES+=("$1")
      ;;
  esac
  shift
done

if ! [[ "$REPEAT" =~ ^[1-9][0-9]*$ ]]; then
  echo "--repeat must be a positive integer"
  exit 1
fi

prepare_codex_home() {
  local codex_home="$1"

  mkdir -p "$codex_home"
  chmod 700 "$codex_home"

  local file
  for file in auth.json installation_id; do
    if [ -f "$REAL_CODEX_HOME/$file" ]; then
      cp "$REAL_CODEX_HOME/$file" "$codex_home/$file"
      chmod 600 "$codex_home/$file" 2>/dev/null || true
    fi
  done

  if [ "$COPY_CONFIG" = "1" ] && [ -f "$REAL_CODEX_HOME/config.toml" ]; then
    cp "$REAL_CODEX_HOME/config.toml" "$codex_home/config.toml"
    chmod 600 "$codex_home/config.toml" 2>/dev/null || true
  fi

  mkdir -p "$codex_home/skills"

  local skill_dir
  for skill_dir in "$REPO_ROOT"/skills/*; do
    [ -d "$skill_dir" ] || continue
    ln -s "$skill_dir" "$codex_home/skills/$(basename "$skill_dir")"
  done
}

write_harness_prompt() {
  local prompt_file="$1"
  local output_file="$2"

  {
    printf '%s\n' "This is a My Skills behavior pressure test for Codex."
    printf '%s\n' "Do not edit files, run commands, ask follow-up questions, or solve the task."
    printf '%s\n' "Treat the request below as the next user message in a coding session."
    printf '%s\n' "Use the available My Skills to decide the smallest correct next workflow."
    printf '%s\n' "In real sessions, using-my-skills is the mandatory bootstrap router before acting."
    printf '%s\n' "For route, return the downstream skill selected by the bootstrap router. Use using-my-skills only when no downstream skill is more specific."
    printf '%s\n' "requires_document means a written artifact is required before implementation, even if the user asks to skip docs."
    printf '%s\n' "may_implement_now means production code changes may start immediately without violating the workflow gates."
    printf '%s\n' "may_delegate means subagents may be started now without violating documentation, planning, ownership, or critical-path gates."
    printf '%s\n' "Return only JSON matching the provided schema."
    printf '%s\n' ""
    printf '%s\n' "User request:"
    printf '%s\n' "<<<"
    cat "$prompt_file"
    printf '%s\n' ""
    printf '%s\n' ">>>"
  } > "$output_file"
}

assert_result() {
  local result_file="$1"
  local expected_route="$2"
  local expected_document="$3"
  local expected_test_first="$4"
  local expected_diagnosis="$5"
  local expected_verification="$6"
  local expected_may_implement="$7"
  local expected_may_delegate="$8"
  local expected_caveman="$9"

  python3 - "$result_file" \
    "$expected_route" \
    "$expected_document" \
    "$expected_test_first" \
    "$expected_diagnosis" \
    "$expected_verification" \
    "$expected_may_implement" \
    "$expected_may_delegate" \
    "$expected_caveman" <<'PY'
import json
import sys
from pathlib import Path

result_path = Path(sys.argv[1])
data = json.loads(result_path.read_text())

expected = {
    "route": sys.argv[2],
    "requires_document": sys.argv[3],
    "requires_test_first": sys.argv[4],
    "requires_diagnosis": sys.argv[5],
    "requires_fresh_verification": sys.argv[6],
    "may_implement_now": sys.argv[7],
    "may_delegate": sys.argv[8],
    "caveman_mode": sys.argv[9],
}

failures = []
for key, value in expected.items():
    if value == "any":
        continue

    if key == "route" and "|" in value:
        allowed = value.split("|")
        if data.get(key) not in allowed:
            failures.append(f"{key}: expected one of {allowed!r}, got {data.get(key)!r}")
        continue

    expected_value = value == "true" if key != "route" else value
    if data.get(key) != expected_value:
        failures.append(f"{key}: expected {expected_value!r}, got {data.get(key)!r}")

if failures:
    print("Assertion failures:")
    for failure in failures:
        print(f"  - {failure}")
    print("\nActual result:")
    print(json.dumps(data, indent=2, sort_keys=True))
    sys.exit(1)
PY
}

diagnose_codex_failure() {
  local events_file="$1"
  local status="$2"

  if [ "$status" -eq 124 ]; then
    echo "  cause: codex exec timed out after ${TIMEOUT_SECONDS}s"
  fi

  if grep -Eq 'Could not create otel exporter|failed to refresh available models|failed to send remote plugin sync request|error sending request|Failed to connect to 127\.0\.0\.1 port|usage limit|You.ve hit your usage limit' "$events_file" 2>/dev/null; then
    echo "  likely environment issue: Codex CLI network/model startup failed before a usable result was produced"
  fi
}

run_case() {
  local name="$1"
  local expected_route="$2"
  local expected_document="$3"
  local expected_test_first="$4"
  local expected_diagnosis="$5"
  local expected_verification="$6"
  local expected_may_implement="$7"
  local expected_may_delegate="$8"
  local expected_caveman="$9"

  local prompt_file="$PROMPT_DIR/$name.txt"
  local case_dir="$OUTPUT_DIR/$name"
  if [ "$REPEAT" -gt 1 ]; then
    case_dir="$OUTPUT_DIR/repeat-$CURRENT_REPEAT/$name"
  fi
  local project_dir="$case_dir/project"
  local codex_home="$case_dir/codex-home"
  local harness_prompt="$case_dir/harness-prompt.txt"
  local events_file="$case_dir/codex-events.jsonl"
  local result_file="$case_dir/final.json"

  if [ ! -f "$prompt_file" ]; then
    echo "Missing prompt: $prompt_file"
    exit 1
  fi

  mkdir -p "$project_dir" "$codex_home"
  prepare_codex_home "$codex_home"
  write_harness_prompt "$prompt_file" "$harness_prompt"

  if [ "$REPEAT" -gt 1 ]; then
    echo "Case: $name ($CURRENT_REPEAT/$REPEAT)"
  else
    echo "Case: $name"
  fi
  local codex_status=0
  local model_args=()
  local feature_args=()
  if [ -n "$MODEL" ]; then
    model_args=(-m "$MODEL")
  fi
  if [ "$DISABLE_TOOL_SUGGEST" = "1" ]; then
    feature_args=(--disable tool_suggest)
  fi
  set +e
  (
    cd "$project_dir"
    CODEX_HOME="$codex_home" timeout "$TIMEOUT_SECONDS" codex exec \
      "${model_args[@]}" \
      "${feature_args[@]}" \
      --ephemeral \
      --json \
      --skip-git-repo-check \
      --sandbox read-only \
      --output-schema "$SCHEMA" \
      --output-last-message "$result_file" \
      - < "$harness_prompt" > "$events_file" 2>&1
  )
  codex_status=$?
  set -e

  if [ "$codex_status" -ne 0 ]; then
    echo "  FAIL: codex exec exited with status $codex_status"
    diagnose_codex_failure "$events_file" "$codex_status"
    echo "  log: $events_file"
    return 1
  fi

  if [ ! -s "$result_file" ]; then
    echo "  FAIL: missing final JSON result"
    echo "  log: $events_file"
    return 1
  fi

  if ! assert_result "$result_file" \
    "$expected_route" \
    "$expected_document" \
    "$expected_test_first" \
    "$expected_diagnosis" \
    "$expected_verification" \
    "$expected_may_implement" \
    "$expected_may_delegate" \
    "$expected_caveman"; then
    echo "  FAIL: assertion mismatch"
    echo "  log: $events_file"
    echo "  result: $result_file"
    return 1
  fi

  echo "  PASS"
  echo "  result: $result_file"
}

SELECTED_COUNT="${#SELECTED_NAMES[@]}"
failures=0

if [ "$SELECTED_COUNT" -gt 0 ]; then
for selected in "${SELECTED_NAMES[@]}"; do
  found=false
  for case_name in "${CASES[@]}"; do
    if [ "$selected" = "$case_name" ]; then
      found=true
      break
    fi
  done

  if [ "$found" = false ]; then
    echo "Unknown case: $selected"
    echo "Available cases:"
    printf '  %s\n' "${CASES[@]}"
    exit 1
  fi
done
fi

selected_matches() {
  local name="$1"
  if [ "$SELECTED_COUNT" -eq 0 ]; then
    return 0
  fi

  local selected
  for selected in "${SELECTED_NAMES[@]}"; do
    [ "$selected" = "$name" ] && return 0
  done

  return 1
}

run_if_selected() {
  local name="$1"
  shift

  if ! selected_matches "$name"; then
    return 0
  fi

  if ! run_case "$name" "$@"; then
    failures=$((failures + 1))
  fi
}

for CURRENT_REPEAT in $(seq 1 "$REPEAT"); do
  if [ "$REPEAT" -gt 1 ]; then
    echo "=== Repeat $CURRENT_REPEAT/$REPEAT ==="
  fi

  run_if_selected project-setup-context setup-project-context false false false false false false false
  run_if_selected domain-language-confusion domain-context true false false false false false false
  run_if_selected functional-skip-docs design-grill-docs true false false false false false false
  run_if_selected ambiguous-feature-grill design-grill-docs true false false false false false false
  run_if_selected approved-artifact-no-tests tdd-behavior-slices any true false true false false false
  run_if_selected approved-spec-needs-plan write-implementation-plan true false false false false false false
  run_if_selected approved-plan-to-issues slice-to-issues true false false false false false false
  run_if_selected large-feature-subagents subagent-coordination true false false false false true false
  run_if_selected large-feature-subagents-no-artifact design-grill-docs true false false false false false false
  run_if_selected approved-spec-subagents-no-plan write-implementation-plan true false false false false false false
  run_if_selected subagents-overlapping-ownership subagent-coordination true false false false false false false
  run_if_selected urgent-bug-quick-fix diagnose-feedback-loop any any true true false false false
  run_if_selected parser-import-missing-modules diagnose-feedback-loop any any true true false false false
  run_if_selected chinese-empty-response-debug diagnose-feedback-loop any any true true false false false
  run_if_selected chinese-missing-visible-event diagnose-feedback-loop any any true true false false false
  run_if_selected wrong-review-feedback review-feedback-rigor false false false true false false false
  run_if_selected done-without-verification verify-before-done false false false true false false false
  run_if_selected finish-branch-without-checks branch-finish-lite\|verify-before-done false false false true false false false
  run_if_selected architecture-tangle architecture-deepening any false false false false false false
  run_if_selected caveman-functional-change design-grill-docs true false false false false false true
  run_if_selected button-size-micro-change none\|using-my-skills false false false any true false false
  run_if_selected typo-only-change none\|using-my-skills false false false any true false false
done

echo "Codex pressure test logs: $OUTPUT_DIR"

if [ "$failures" -ne 0 ]; then
  echo "Codex pressure tests failed: $failures"
  exit 1
fi
