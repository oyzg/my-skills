---
name: diagnose-feedback-loop
description: Use when debugging bugs, errors, exceptions, failures, empty responses, response.json failures, parser/import/mapping errors, missing expected output, missing visible output, performance regressions, unexpected behavior, or Chinese reports like 报错, 错误, 异常, 失败, 空响应, 没看到, 没有显示, UI 没有, 没有解析, 定位问题, or 修复 before fixes
---

# Diagnose Feedback Loop

## Overview

Build a reliable pass/fail loop before fixing. Root cause first, patch second.

## Visibility

Start with one concise line naming this skill and why.

## Process

1. Build the fastest available feedback loop: focused test, curl script, CLI fixture, browser script, trace replay, throwaway harness, fuzz loop, or bisect harness.
2. Reproduce the user's actual symptom.
3. Write 3-5 ranked falsifiable hypotheses.
4. Instrument one hypothesis at a time.
5. Convert the minimized repro into a failing regression test when a correct seam exists.
6. State the confirmed root cause and proposed fix scope to the user. If the fix touches more than the minimum required code, pause and confirm scope before patching.
7. Fix the root cause.
8. Rerun the original loop and regression test.
9. Remove debug logs and throwaway harnesses.

## Feedback Loop Quality

A useful loop is fast enough to run repeatedly, deterministic enough to trust,
and specific enough to prove the reported symptom. If the bug is flaky, raise
the reproduction rate with repeated runs, stress, seeded inputs, or narrowed
timing windows before fixing.

See `REFERENCE.md` for feedback-loop examples and hypothesis shape.

## Parser And Import Failures

Treat data parsing, import, transformation, and mapping symptoms as diagnosis
work, even when the suspected file or function looks obvious.

Examples:

- data is imported but remains raw instead of becoming expected records
- expected modules, fields, events, or rows are missing
- data exists in DB/API/logs but is not visible in UI or output
- logs or events are classified into the wrong type
- parser, serializer, transformer, mapper, or importer output is wrong
- user says "not parsed", "not recognized", "missing module", "wrong mapping",
  "empty result", or equivalent symptoms

Reproduce the import path, capture the smallest representative input, state
falsifiable hypotheses, then fix with a regression test when a seam exists.

## Chinese Error Reports

Treat Chinese debugging requests as diagnosis work when they describe a symptom
that needs investigation before a fix.

Examples:

- "报错", "错误", "异常", or "失败"
- "空响应", "没有内容", "没有返回", or `response.json()` on an empty body
- "没有解析", "没有解析到对应模块", "没识别出来", or "映射错了"
- "没看到", "没有看到", "没有显示", "UI 没有", "页面没有", or
  "DB 有但 UI 没有"
- "先定位", "定位问题", "排查一下", "修一下", or "修复"

For these requests, announce `diagnose-feedback-loop`, reproduce the symptom,
then patch only after a feedback loop and ranked hypotheses.

## Hypotheses

Each hypothesis must predict an observable result:

```text
If <cause> is true, then <probe> will show <result>.
```

Test one prediction at a time. Do not stack multiple guesses into one change.

## Stop Conditions

- If no reliable loop can be built, state what was tried and ask for logs, traces, access, or permission to instrument.
- If no correct test seam exists, document that architecture finding and use `architecture-deepening`.
- If repeated fixes fail, stop adding patches and revisit the diagnosis.
