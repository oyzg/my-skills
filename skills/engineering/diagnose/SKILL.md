---
name: diagnose
description: Use when debugging bugs, errors, exceptions, failures, empty responses, missing output, performance regressions, or unexpected behavior. 报错, 错误, 异常, 失败, 空响应, 没看到, 没显示, 定位问题, 修复
---

# Diagnose

Build a feedback loop before fixing. Root cause first, patch second.

## Process

1. Build the fastest feedback loop: focused test, curl, CLI fixture, or throwaway harness.
2. Reproduce the user's actual symptom.
3. Write 3–5 ranked falsifiable hypotheses: `If <cause>, then <probe> shows <result>`.
4. Instrument one hypothesis at a time.
5. Convert the repro into a failing regression test when a correct seam exists.
6. State confirmed root cause and fix scope to the user.
7. Fix the root cause.
8. Rerun the loop and regression test.
9. Remove debug logs and throwaway harnesses.

## Stop Conditions

- No reliable loop → state what was tried, ask for logs/access.
- No test seam → document the architecture finding, use `architecture`.
- Repeated fixes fail → stop patching, revisit diagnosis.
