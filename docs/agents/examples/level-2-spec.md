# Billing Export Design Spec

## Problem

Workspace admins need a billing CSV export that includes invoice totals and
member counts for the selected month. The current export endpoint only returns
project usage and cannot support finance reconciliation.

## Current Behavior

- `GET /api/workspaces/:workspaceId/export` returns project usage rows.
- Billing account information is stored separately from workspace membership.
- Non-admin members can call the project usage export.

## Proposed Behavior

- Add `GET /api/workspaces/:workspaceId/billing-export?month=YYYY-MM`.
- Only workspace admins may request the export.
- The response is CSV with one row per invoice:
  - invoice id
  - billing account id
  - workspace id
  - month
  - invoice total
  - active member count
- Invalid month values return `400`.
- Non-admin members receive `403`.

## Scope

In:
- Billing export endpoint.
- Admin permission check.
- Month validation.
- CSV formatting.
- Tests for success, invalid month, and permission denial.

Out:
- Scheduled exports.
- UI download button.
- Historical backfill.

## Interfaces

- API: `GET /api/workspaces/:workspaceId/billing-export?month=YYYY-MM`
- Data: read invoices through billing account and active members through workspace membership.
- State: no new persistent state.
- Errors: `400` invalid month, `403` non-admin, `404` unknown workspace.
- Permissions: workspace admin only.

## Risks

- Risk: confusing workspace and billing account boundaries.
  Mitigation: use `CONTEXT.md` terms and test both ids in the CSV.

## Test Plan

- API integration test for admin success.
- API integration test for invalid month.
- API integration test for non-admin denial.
