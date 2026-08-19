---
name: apple-product-spec
description: Convert validated opportunity evidence into an implementation-ready Apple product specification. Use when defining MVP scope, user journeys, entitlements, subscription value, supported Apple devices, data flows, architecture, non-goals, safety boundaries, acceptance criteria, review demo paths, or a release plan before Swift/SwiftUI development begins.
---

# Apple Product Spec

Turn the market thesis into a testable product contract. Every public promise must map to a real release behavior and test.

## Establish the product contract

Define:

- target user, buyer, job, context, and moment of use;
- one-sentence value proposition without “AI” unless AI itself is user value;
- core loop and time-to-first-value;
- free, paid, and unavailable capabilities;
- supported device families, orientations, minimum OS, offline behavior, and accessibility target;
- explicit v1 non-goals;
- measurable success, stop, and rollback conditions.

## Specify complete journeys

For each journey, include entry, prerequisites, happy path, cancellation, empty/loading/error/offline states, persistence, destructive confirmation, accessibility, analytics event if any, and acceptance tests.

Cover onboarding, core job, save/relaunch, import/export/share, settings/support/legal, permissions, paywall, purchase, restore, entitlement changes, and account/data deletion if applicable.

## Define monetization as behavior

For every product or subscription, specify immutable product ID convention, entitlement, duration/type, price hypothesis, ongoing value, free limits, upgrade/downgrade relationship, restore, grace/billing retry, expiration/refund/revocation, family sharing decision, server dependency, offline cache, and customer-visible copy.

Do not sell a subscription without credible continuing value. Do not promise a trial or price until App Store Connect is configured identically.

## Build the data and risk maps

For each data type, record source, purpose, device storage, transmission, processor, retention, deletion, backup, encryption, permissions, privacy-label category, and policy text. Include SDK and website data.

Identify safety, privacy, security, IP, claims, child/health/financial, user-content, moderation, AI, and platform risks. Convert each into prevention, detection, response, owner, and stop-ship rule.

## Choose architecture from constraints

Prefer the smallest architecture that satisfies the contract. Decide local versus cloud, sync/conflict strategy, migrations, observability, feature flags, dependency policy, accessibility identifiers, deterministic StoreKit configuration, test seams, export/import validation, and failure recovery.

Avoid a backend when it adds no user value. Do not avoid one when accounts, cross-device sync, public content, server secrets, or verified server state require it.

## Write acceptance criteria

Use observable Given/When/Then criteria. Include:

- functionality and data integrity;
- performance/resource bounds;
- supported-device layout;
- VoiceOver, Dynamic Type, contrast, motion, and input methods;
- permissions and privacy behavior;
- purchase/restore/revocation;
- clean-install and upgrade migrations;
- review-mode access;
- exact release evidence required.

## Deliverables

Produce the PRD, journey map, device matrix, entitlement table, data map, risk register, architecture decision record, acceptance-test matrix, App Review demo script, milestone plan, and human handoffs. Read `references/spec-template.md` for the minimum structure.
