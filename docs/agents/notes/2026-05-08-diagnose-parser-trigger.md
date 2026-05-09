# Diagnose Parser Trigger

## Context

A user showed a debugging case where data entered the system but was imported
as raw JSONL lines instead of being parsed into the expected AgentLens modules.
The agent investigated and patched the parser, but did not visibly route through
`diagnose-feedback-loop`.

This is a real diagnosis task: the symptom is an incorrect parsed result, and
the correct behavior depends on reproducing the import path, identifying the
mapping gap, and proving the expected module output.

## Decision

Strengthen diagnosis trigger language for parser, import, transformation, and
mapping failures.

`diagnose-feedback-loop` should trigger when:

- data imports but is parsed into the wrong shape
- expected modules, records, or fields are missing
- logs/events are classified incorrectly
- a parser, serializer, transformer, mapper, or importer produces wrong output
- the user reports "not parsed", "not recognized", "missing module", "wrong
  mapping", "empty result", or equivalent symptoms
- the user reports Chinese debugging symptoms such as "报错", "错误", "异常",
  "失败", "空响应", "没有内容", "没有解析", "没有返回", "没看到",
  "没有看到", "没有显示", "UI 没有", "定位问题", or "修复"
- the user reports that data exists in one layer but is missing in another,
  such as DB/API has an event but UI does not show it

`using-my-skills` should route data parsing or import-output symptoms to
`diagnose-feedback-loop`.

## Acceptance

- Parser/import/mapping failures are explicitly diagnosis work.
- Chinese error reports and empty-response symptoms are explicitly diagnosis
  work.
- Missing visible output, including "not seen" or "DB/API has it but UI does
  not", is explicitly diagnosis work.
- The skill still requires a feedback loop before patching.
- Pressure tests include a representative "data imported but not parsed into
  modules" case, a Chinese empty-response case, and a Chinese missing-visible
  event case.
