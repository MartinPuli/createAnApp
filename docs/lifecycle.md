# Evidence-gated lifecycle

## Launch dossier

Maintain one version-controlled dossier with these fields:

| Field | Required evidence |
|---|---|
| Product thesis | Target user, job, pain, current alternative, native advantage |
| Market thesis | Dated sources, competitor set, pricing, search/demand signals, falsifiers |
| Distribution thesis | Reachable channels, expected economics, attribution mechanism |
| Product contract | Scope, non-goals, acceptance criteria, supported devices and OS versions |
| Monetization | Entitlements, products, prices, trial/offer truth, restoration and failure behavior |
| Data map | Data type, origin, device/server/third party, purpose, retention, deletion, disclosure |
| Risk register | Product, platform, safety, privacy, IP, security, financial, operational risks |
| Release evidence | Commit, build, archive, tests, device matrix, screenshots, TestFlight version |
| Store dossier | App record, bundle, metadata, privacy, age rating, review access, IAP/subscriptions |
| Compliance evidence | Policies, manifest, SDK inventory, asset provenance, claims substantiation |
| Launch controls | Release mode, rollback, support, budget cap, campaign links, stop/scale rules |
| Review history | Submission ID, exact message, guideline, reproducer, fix, proof, response |

## Gate states

Use only these states:

- `UNASSESSED`: no reliable evidence.
- `BLOCKED`: a required external fact or action is unavailable.
- `FAILED`: current evidence contradicts the gate.
- `CONDITIONAL`: evidence exists but named conditions remain.
- `PASSED`: the complete gate is proven for the exact release candidate.
- `STALE`: evidence predates a material code, SDK, policy, metadata, or business change.

Never roll a `PASSED` gate forward automatically. Re-open affected gates when the app adds an SDK, cloud processing, AI, accounts, public user content, health/financial functions, a new device family, or a new monetization model.

## Decision sequence

1. Inspect the repository, product state, accounts, prior submissions, and current external state.
2. Build the dossier before prescribing actions.
3. Identify the earliest failed or unassessed prerequisite.
4. Invoke the narrow stage skill for that prerequisite.
5. Save artifacts and evidence paths.
6. Run the completion audit for the stage.
7. Advance only when the evidence matches the gate's full scope.

## Definition of shipped

`Shipped` means the intended version is available in its target storefronts, purchasable where promised, support and policies are live, monitoring works, rollback/response ownership exists, and launch attribution is active. `Ready for Distribution`, `Pending Developer Release`, and App Review approval are intermediate states unless availability is verified.
