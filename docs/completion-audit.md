# Completion audit

Before declaring any stage complete, build a requirement-to-evidence table:

| Requirement | Authoritative source | Evidence inspected | Status | Gap/next action |
|---|---|---|---|---|

Use `PROVEN`, `CONTRADICTED`, `INCOMPLETE`, `STALE`, or `MISSING`. A passing narrow test cannot prove a broad requirement. Examples:

- A simulator build does not prove an App Store archive.
- A UI test that finds a label does not prove visual usability.
- A StoreKit configuration does not prove Sandbox/TestFlight commerce.
- A privacy manifest does not prove third-party SDK behavior.
- A saved form does not prove a public URL works.
- App Review approval does not prove release or market fit.
- A competitor score does not prove willingness to pay.

The stage passes only when every required row is `PROVEN`, no higher-priority contradiction remains, and evidence belongs to the exact current version.

## Freshness invalidators

Invalidate evidence after material changes to source, build configuration, dependency versions, supported devices, entitlements, data flow, monetization, metadata, screenshots, policies, account agreements, or platform rules.
