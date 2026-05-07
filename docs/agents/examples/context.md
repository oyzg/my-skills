# Context Example

## Domain Terms

| Term | Meaning | Avoid Saying |
| --- | --- | --- |
| Workspace | Collaboration boundary containing projects, members, and settings. | tenant, org |
| Billing Account | Entity that owns payment method, invoices, and subscription state. | workspace |
| Member | User with access to one workspace. | account user |

## Boundaries

- A workspace owns projects and membership.
- A billing account owns subscription and invoice data.
- A user may be a member of multiple workspaces.
- Workspace is not the billing account.

## Important Flows

- Export billing report: workspace admin requests an export, but invoice data is
  read from the billing account.

## Decisions

- 2026-05-07: Use "workspace" for collaboration scope and "billing account" for
  payment scope. Avoid "tenant" because the product does not expose tenancy as a
  user-facing concept.
