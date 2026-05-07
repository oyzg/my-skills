# Subagent Delegation Example

## Main Session Critical Path

Own the API route and permission behavior:

- `backend/routes/billing-export.ts`
- `backend/routes/billing-export.test.ts`

## Subagent 1

Task: Implement month parsing helper.

Context: `docs/agents/plans/2026-05-07-billing-export.md`

Ownership:
- `backend/billing/month.ts`
- `backend/billing/month.test.ts`

Do not touch:
- `backend/routes/`
- `backend/billing/billing-export-csv.ts`

Expected tests:
- `npm test -- billing/month`

Coordination: Other agents may be editing this repo. Do not revert or overwrite
their work; adapt to existing changes.

Return: changed paths, verification run, blockers, and assumptions.

## Subagent 2

Task: Implement billing export CSV formatter.

Context: `docs/agents/plans/2026-05-07-billing-export.md`

Ownership:
- `backend/billing/billing-export-csv.ts`
- `backend/billing/billing-export-csv.test.ts`

Do not touch:
- `backend/routes/`
- `backend/billing/month.ts`

Expected tests:
- `npm test -- billing-export-csv`

Coordination: Other agents may be editing this repo. Do not revert or overwrite
their work; adapt to existing changes.

Return: changed paths, verification run, blockers, and assumptions.
