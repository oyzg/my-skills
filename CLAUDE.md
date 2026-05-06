# My Skills Instructions

Use `engineering-flow-lite` at the start of engineering work to choose the
smallest workflow that preserves documentation, diagnosis, TDD, review, and
verification gates.

This repository is Codex-first. Treat `.codex-plugin/plugin.json` and the
`skills/*/SKILL.md` files as the primary product surface. Claude, Cursor,
Gemini, and OpenCode files are compatibility metadata.

Functional work requires a written artifact before implementation. Functional
work includes changes to behavior, data, APIs, state, permissions, error
handling, architecture, or tests.

Pure visual micro-tweaks, typos, formatting-only changes, and narrow
non-behavioral cleanup do not require a document.

Caveman mode can compress communication, but cannot skip required gates.

Before opening a pull request, show the complete diff to the human partner and
get explicit approval.
