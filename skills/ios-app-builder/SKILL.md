---
name: ios-app-builder
description: Implement or finish a production-grade Swift and SwiftUI app from an accepted product specification. Use when creating Xcode targets, models, persistence, navigation, responsive views, imports/exports, StoreKit 2, privacy manifests, accessibility, migrations, error handling, tests, or replacing prototype behavior with real App Store-ready functionality.
---

# iOS App Builder

Implement in vertical slices against acceptance criteria. Do not present prototype controls, mock exports, placeholder data, or unverified commerce as finished functionality.

## Establish a trustworthy baseline

1. Inspect repository instructions and dirty state.
2. Build and test before editing.
3. Record workspace/project, scheme, bundle, device families, deployment target, versions, signing mode, dependencies, entitlements, manifest, and existing failures.
4. Map every public/product promise to current source and tests.
5. Use `$apple-agent-toolchain` if the build environment is not verified.

## Implement vertical slices

For each slice:

- model and validation;
- persistence/migration;
- service or platform boundary;
- adaptive UI and all states;
- accessibility identifiers and semantics;
- unit/integration/UI tests;
- error, cancellation, offline, and recovery behavior;
- documentation and acceptance evidence.

Prefer native frameworks and a minimal dependency set. Keep secrets server-side or in protected configuration. Never embed private API keys in the app.

## Persistence and migrations

Use atomic writes or a transactional store. Test exact round trips, corruption/error handling, app termination/relaunch, upgrades from prior schema, deletion/export, backup behavior, and storage-pressure failure. State where data lives and what deleting the app does.

## StoreKit 2

Use stable product identifiers that match App Store Connect. Implement product loading, localized Apple pricing, purchase verification, current entitlement reconstruction at launch, transaction updates, restore/sync, expiration, refund/revocation, pending/cancelled/failure states, billing retry/grace behavior if applicable, offline caching without false access, and accessible legal/paywall surfaces.

Maintain a checked-in StoreKit configuration with fake local transactions only; never treat it as Sandbox/TestFlight proof.

## Privacy and platform integration

- Request permissions in context and explain denied recovery.
- Maintain `PrivacyInfo.xcprivacy` and required-reason API declarations.
- Inventory network endpoints, SDKs, entitlements, background modes, URL schemes, and data flows.
- Keep support, privacy, and Terms links reachable.
- Ensure features function on every declared device family.
- Add review-friendly demo behavior without hidden production bypasses.

## Visual and accessibility quality

Invoke `$apple-app-designer` for adaptive screens. Test compact/regular widths and large text. Avoid fixed layouts that collapse on review devices. Automated existence assertions must be complemented by screenshot review.

## Maintain release hygiene

Use unique build numbers, deterministic configurations, release-safe logging, actionable errors, no debug menus or placeholder copy, production icons, correct display name/category/orientations, and no dead features. Keep Review Notes updated as behavior changes.

## Finish with evidence

Run `$ios-release-tester`. Provide changed files, acceptance mapping, tests, screenshots, known limitations, data/SDK changes requiring compliance updates, and exact remaining human actions. Never claim production readiness from a debug simulator build alone.
