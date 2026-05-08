---
name: review-feedback-rigor
description: Use when receiving code review feedback, requested changes, reviewer comments, or suggestions that need verification before implementation
---

# Review Feedback Rigor

## Overview

Review feedback is input to evaluate, not an order to obey blindly.

## Visibility

Start with one concise line naming this skill and why.

## Process

1. Read all feedback before acting.
2. Restate unclear requirements or ask for clarification.
3. Verify claims against the codebase.
4. Accept technically correct feedback.
5. Push back with evidence when feedback is wrong, harmful, or YAGNI.
6. Implement valid feedback one item at a time.
7. Test each meaningful change.
8. Run `verify-before-done` before claiming the review is addressed.

See `REFERENCE.md` for feedback classes and response shape.

## Push Back When

- The suggestion breaks existing behavior.
- The reviewer missed project constraints.
- The requested feature is unused or speculative.
- The change conflicts with an approved artifact or ADR.
- Compatibility removal is suggested without checking supported runtimes.

## Avoid

- Performative agreement.
- Partial implementation before clarifying ambiguous feedback.
- Removing compatibility or behavior without checking actual project constraints.
- Treating external feedback as automatically correct.
