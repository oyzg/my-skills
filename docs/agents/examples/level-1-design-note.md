# Billing Export Filename Design Note

## Problem

Billing export downloads currently use a generic `export.csv` filename, which
makes repeated downloads hard to distinguish.

## Decision

Use `billing-export-YYYY-MM.csv` for monthly billing exports.

## Scope

In:
- Change the generated download filename for monthly billing exports.
- Preserve the existing CSV contents and export permissions.

Out:
- Changing export filters.
- Changing invoice data shape.
- Adding scheduled exports.

## Open Questions

- None.

## Test Plan

- Add a behavior test that exports April 2026 billing data and asserts the
  download filename is `billing-export-2026-04.csv`.
