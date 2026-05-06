# TDD Behavior Slice Reference

## Good Slice

A good slice proves one user-visible or system-visible behavior through the
narrowest stable public interface.

```text
Behavior: expired token is rejected
Test: request with expired token returns 401 and no state change
Implementation: token validation branch only
Verification: focused auth test, then relevant auth suite
```

## Bad Slice

```text
Behavior: implement auth
Test: many mocks for internal helper calls
Implementation: controllers, storage, permissions, UI all at once
Verification: run broad suite only after everything is written
```

## Slice Checklist

- Test fails before production code.
- Failure proves the missing behavior, not broken setup.
- Test uses public API, CLI, UI, or stable module boundary.
- Mocking is limited to unavailable, unsafe, or expensive collaborators.
- Refactor happens only after focused and relevant broader checks pass.
