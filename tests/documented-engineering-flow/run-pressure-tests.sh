#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
PROMPT_DIR="$SCRIPT_DIR/prompts"
TIMESTAMP="$(date +%s)"
OUTPUT_DIR="/tmp/my-skills-tests/$TIMESTAMP/documented-engineering-flow"

mkdir -p "$OUTPUT_DIR"

run_case() {
  local name="$1"
  local prompt_file="$PROMPT_DIR/$name.txt"
  local case_dir="$OUTPUT_DIR/$name"
  local log_file="$case_dir/claude-output.json"

  mkdir -p "$case_dir/project"
  cp "$prompt_file" "$case_dir/prompt.txt"

  (
    cd "$case_dir/project"
    timeout 120 claude -p "$(cat "$prompt_file")" \
      --plugin-dir "$PLUGIN_DIR" \
      --dangerously-skip-permissions \
      --max-turns 5 \
      --verbose \
      --output-format stream-json \
      > "$log_file" 2>&1 || true
  )

  echo "Case: $name"
  grep -o '"skill":"[^"]*"' "$log_file" 2>/dev/null | sort -u || echo "  skills: none"
  echo "  log: $log_file"
}

run_case functional-skip-docs
run_case urgent-bug-quick-fix
run_case obvious-implementation-no-test
run_case caveman-functional-change
run_case wrong-review-feedback
run_case done-without-verification
run_case button-size-micro-change
run_case api-behavior-change

echo "Pressure test logs: $OUTPUT_DIR"
