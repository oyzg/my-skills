---
name: prototype
description: Use when the user wants a quick spike, PoC, throwaway experiment, or rapid validation before committing to full implementation. 试一下, 快速验证, spike, PoC, prototype
---

# Prototype

Build the fastest throwaway proof that answers a question.

## Process

1. State what question the prototype answers.
2. Build the simplest runnable thing — terminal script, single file, or
   minimal UI variant.
3. Skip docs, full tests, and architecture gates.
4. Show the result to the user.
5. Discard or promote: user decides whether to throw it away or use it
   as input for a proper `grill` → `plan` → `tdd` cycle.

## Rules

- Prototypes are throwaway by default. No production expectations.
- Keep it under one file or one small directory.
- Do not refactor existing code for a prototype.
- Label prototype files clearly so they are not mistaken for production.
