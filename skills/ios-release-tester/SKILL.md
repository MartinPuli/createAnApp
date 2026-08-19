---
name: ios-release-tester
description: Produce release-grade evidence for an Apple app build. Use when testing Swift/iOS/iPadOS apps in simulators, real devices, Sandbox, or TestFlight; verifying StoreKit, persistence, migrations, exports, accessibility, adaptive UI, privacy manifests, archives, signing, screenshots, or deciding whether a specific build is safe to submit.
---

# iOS Release Tester

Test the commercial and operational lifecycle of the exact release candidate. A clean compile is only the first row of evidence.

## Identify the candidate

Record commit, marketing version, build number, scheme/configuration, bundle ID, archive path, Xcode/SDK, supported devices, minimum OS, StoreKit product IDs, and metadata revision. Confirm Xcode/SDK eligibility against `../../docs/current-apple-requirements.md`. Run `scripts/inspect_xcode_project.sh <project-root>` for a sanitized first pass.

## Build the matrix

Cover:

- clean build and complete automated suite;
- smallest/largest supported devices and every declared family;
- orientations and iPad multitasking/window widths if supported;
- current release OS plus minimum supported OS where feasible;
- clean install, upgrade/migration, termination/relaunch, offline, storage/error recovery;
- core journeys, destructive actions, imports/exports, sharing, permissions, support/legal links;
- VoiceOver, Dynamic Type, contrast, focus, keyboard/pointer/Pencil where promised;
- privacy manifest, entitlements, SDK/network inventory, and permission strings;
- release archive, signing, export validation, upload processing, TestFlight installation.
- account creation/deletion, third-party login, UGC moderation, and regulated workflows when present.

## Test StoreKit as a state machine

Layer evidence:

1. Local StoreKit configuration: deterministic product/purchase/refund/expiration tests.
2. Sandbox or TestFlight: real configured products and Apple account flow.
3. App relaunch/offline: entitlement reconstruction and cache limits.
4. Transaction change: renewal, cancellation at period end, billing retry/grace if used, refund/revocation, upgrade/downgrade.
5. Restore: fresh install/device where feasible and clear no-purchase behavior.

Verify product identifiers, localized price/period, entitlement mapping, legal copy, close path, and access to paid value. Do not call local StoreKit proof “TestFlight tested.”

## Test persistence and exports

Confirm exact save/load round trip, atomicity/transaction behavior, migration, corruption handling, deletion semantics, backup/export, and the documented container location. For PDF/SVG/media exports, parse or reopen outputs and verify format, dimensions, page count, scale, content, and error handling; tapping Share is not proof.

## Run visual review

Invoke `$apple-app-designer`. Capture screenshots of every primary task on each supported width class. Specifically reject layouts with vertical-letter wrapping, hidden/truncated meaning, overlapping controls, unreachable actions, or inspectors that crush primary content.

## Preserve evidence

Save command/tool version, result bundle, logs, screenshots, output artifacts, archive validation, TestFlight build, and defects. Redact credentials and personal/tester data.

Classify failures as product, test, environment, account, or external service. Never dismiss a failure as flaky without repeated evidence and a root-cause record.

## Release verdict

Return `PASS`, `CONDITIONAL`, or `STOP-SHIP`. Use `PASS` only when every requirement in the release matrix is proven for the same candidate and no severe defect remains. List residual risks, invalidation triggers, and human TestFlight checks.

Read `references/release-matrix.md` for the required evidence table.
