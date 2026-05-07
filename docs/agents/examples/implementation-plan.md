# Billing Export Implementation Plan

## Source Artifact

- `docs/agents/specs/2026-05-07-billing-export-design.md`

## Goal

Workspace admins can download a monthly billing CSV with invoice totals and
active member counts.

## Non-Goals

- No UI button.
- No scheduled exports.
- No invoice backfill.

## Assumptions

- `CONTEXT.md` defines workspace and billing account as separate concepts.
- Existing API integration test helpers can create workspace admins and members.

## Steps

1. Add month parsing behavior.
   - Files: `backend/billing/month.ts`, `backend/billing/month.test.ts`
   - Test: `npm test -- billing/month`
   - Done when: invalid and valid `YYYY-MM` values are covered.

2. Add admin-only billing export API behavior.
   - Files: `backend/routes/billing-export.ts`, `backend/routes/billing-export.test.ts`
   - Test: `npm test -- billing-export`
   - Done when: admin success, non-admin `403`, and unknown workspace `404` pass.

3. Add CSV formatting behavior.
   - Files: `backend/billing/billing-export-csv.ts`, `backend/billing/billing-export-csv.test.ts`
   - Test: `npm test -- billing-export-csv`
   - Done when: CSV headers and invoice rows match the spec.

## Risks

- Billing account and workspace ids may be confused.
  Mitigation: tests assert both ids appear in the expected columns.

## Verification

- `npm test -- billing`
- `npm run typecheck`
