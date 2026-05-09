#!/usr/bin/env bash
# Run all skill triggering tests.

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROMPTS_DIR="$SCRIPT_DIR/prompts"

SKILLS=(
    "using-my-skills"
    "setup-project-context"
    "domain-context"
    "design-grill-docs"
    "write-implementation-plan"
    "slice-to-issues"
    "subagent-coordination"
    "tdd-behavior-slices"
    "diagnose-feedback-loop"
    "architecture-deepening"
    "review-feedback-rigor"
    "verify-before-done"
    "branch-finish-lite"
    "caveman"
)

echo "=== Running Skill Triggering Tests ==="
echo ""

PASSED=0
FAILED=0
RESULTS=()

for skill in "${SKILLS[@]}"; do
    prompt_file="$PROMPTS_DIR/${skill}.txt"

    if [ ! -f "$prompt_file" ]; then
        echo "SKIP: No prompt file for $skill"
        continue
    fi

    echo "Testing: $skill"

    if "$SCRIPT_DIR/run-test.sh" "$skill" "$prompt_file" 3 2>&1 | tee "/tmp/my-skills-test-$skill.log"; then
        PASSED=$((PASSED + 1))
        RESULTS+=("PASS $skill")
    else
        FAILED=$((FAILED + 1))
        RESULTS+=("FAIL $skill")
    fi

    echo ""
    echo "---"
    echo ""
done

echo ""
echo "=== Summary ==="
for result in "${RESULTS[@]}"; do
    echo "  $result"
done
echo ""
echo "Passed: $PASSED"
echo "Failed: $FAILED"

if [ $FAILED -gt 0 ]; then
    exit 1
fi
