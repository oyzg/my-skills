#!/usr/bin/env bash
# Run all explicit skill request tests.

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROMPTS_DIR="$SCRIPT_DIR/prompts"

SKILLS=(
    "engineering-flow-lite"
    "setup-project-context"
    "domain-context"
    "design-grill-docs"
    "write-implementation-plan"
    "slice-to-issues"
    "tdd-behavior-slices"
    "diagnose-feedback-loop"
    "architecture-deepening"
    "review-feedback-rigor"
    "verify-before-done"
    "branch-finish-lite"
    "caveman"
)

echo "=== Running All Explicit Skill Request Tests ==="
echo ""

PASSED=0
FAILED=0
RESULTS=()

for skill in "${SKILLS[@]}"; do
    prompt_file="$PROMPTS_DIR/${skill}.txt"
    echo ">>> Test: $skill"

    if "$SCRIPT_DIR/run-test.sh" "$skill" "$prompt_file"; then
        PASSED=$((PASSED + 1))
        RESULTS+=("PASS $skill")
    else
        FAILED=$((FAILED + 1))
        RESULTS+=("FAIL $skill")
    fi
    echo ""
done

echo "=== Summary ==="
for result in "${RESULTS[@]}"; do
    echo "  $result"
done
echo ""
echo "Passed: $PASSED"
echo "Failed: $FAILED"
echo "Total: $((PASSED + FAILED))"

if [ "$FAILED" -gt 0 ]; then
    exit 1
fi
