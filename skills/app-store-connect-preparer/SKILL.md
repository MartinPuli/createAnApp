---
name: app-store-connect-preparer
description: Prepare, audit, and complete an Apple App Store Connect submission. Use for app records, bundle IDs, agreements, tax/banking/DSA handoffs, builds, metadata, descriptions, keywords, screenshots, privacy labels, age ratings, export compliance, review information, TestFlight, IAP or subscriptions, release options, Add for Review, or submission troubleshooting.
---

# App Store Connect Preparer

Treat App Store metadata and commerce configuration as versioned release artifacts. Re-check current Apple help before every submission. Read `../../docs/app-store-field-guide.md` and `../../docs/official-sources.md` when available.

## Audit prerequisites

Verify account membership, roles, current agreements, Paid Apps status, tax/banking status, DSA declaration, certificates/signing, bundle registration, app record, and intended territories. Prepare human handoffs for identity, agreements, tax, banking, trader status, and legal/export attestations; never choose or sign them for the human.

## Reconcile the identity chain

The developer portal identifier, Xcode Release build, signed archive, uploaded build, and App Store Connect record must agree on bundle ID, platform, capabilities, version, and build. Verify display name, app icon, minimum OS, device families, orientations, encryption declaration, and entitlements from the archive—not only source files.

## Build the metadata dossier

Prepare and save every localization:

- name, subtitle, description, promotional text, keywords, categories, copyright;
- support, marketing, privacy, and Terms URLs;
- screenshots/previews from the exact build;
- age rating, app privacy, content rights, export compliance;
- review contact, demo credentials/mode, precise notes and attachments;
- pricing, availability, release mode, and phased-release decision.

Use only current, implemented claims. Open every public URL without authentication. For auto-renewable subscriptions, include a functional Terms of Use link in the app description when using Apple's standard EULA, or configure the custom EULA field.

## Configure commerce

For each IAP/subscription, verify reference name, product ID, type/duration, localization, price, availability, tax category, review screenshot/notes, StoreKit mapping, and entitlement behavior.

For the first auto-renewable subscription, submit the new app version, subscription group, and at least one auto-renewable subscription from that group together. Confirm all appear in the submission modal. If the app is rejected and linked items are returned, repair and re-add the complete dependency set.

## Prepare screenshots

Follow current exact pixel specifications for every supported device class. Use real release UI and one to ten accepted RGB JPEG/JPG/PNG images. If processing remains stuck, follow the delete/re-export/small-batch procedure in the field guide and inspect every localization/device well in Media Manager.

## Write review instructions

Provide exact steps from clean launch to core value, paywall, purchase, restore, account/demo access, special permissions/hardware, and non-obvious features. Describe new functionality specifically. Make all reviewed functionality accessible.

## Run preflight

Confirm saved status, public URLs, selected build, metadata/build consistency, commerce dependency set, review access, privacy agreement, screenshot processing, release control, and support availability. Invoke `$ios-release-tester` and `$app-compliance-auditor` before submitting.

## Submit with controlled authority

Use an authorized supported API where available. Otherwise guide the human through Add for Review and Submit for Review after showing the exact item set and unresolved risks. Preserve submission ID, timestamp, item list, and screenshots without personal or financial details.

Return a field-by-field dossier, `READY / CONDITIONAL / BLOCKED` verdict, remaining human actions, and proof required after submission.
