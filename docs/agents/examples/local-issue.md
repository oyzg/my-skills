# Add Admin Billing Export Endpoint

## Source

- `docs/agents/plans/2026-05-07-billing-export.md`

## Goal

Add the admin-only API route for monthly billing exports.

## Scope

In:
- `GET /api/workspaces/:workspaceId/billing-export?month=YYYY-MM`
- Admin permission check.
- Success response wired to the CSV formatter.

Out:
- UI download button.
- CSV formatter internals beyond the formatter interface.
- Scheduled exports.

## Files

- `backend/routes/billing-export.ts`
- `backend/routes/billing-export.test.ts`
- `backend/routes/index.ts`

## Test

- `npm test -- billing-export`

## Dependencies

- Month parsing helper exists.
- CSV formatter interface exists.
