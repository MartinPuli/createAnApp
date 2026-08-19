---
name: app-review-recovery
description: Diagnose an Apple App Review rejection, reproduce the reviewer experience, implement and verify the complete fix, prepare a precise response, and resubmit all dependent items. Use when an app version, subscription group, IAP, subscription, custom product page, or metadata is rejected, returned, blocked, or repeatedly fails review.
---

# App Review Recovery

Treat the reviewer message, attachments, tested devices, version/build, and submission item set as authoritative incident evidence. Do not resubmit after changing text alone unless the root cause is proven to be metadata-only.

Read `references/rejection-catalog.md` to classify common signals and `references/rejection-patterns.md` for operational controls, but let the exact current reviewer evidence override both.

## Preserve the incident

Record submission ID, review date, exact app version/build, review devices/OS, guideline, full message, screenshots/attachments, affected items/statuses, prior responses, and current storefront/build state. Redact reviewer contact and account data from public repositories.

## Classify root cause

Map each issue to one or more layers:

- code/functionality;
- supported-device design/accessibility;
- commerce/StoreKit;
- metadata/screenshot/URL;
- privacy/security/legal/content rights;
- account/agreement/configuration;
- review access/instructions/environment;
- submission dependency/state.

Read the current cited guideline and linked Apple help. Look for additional contradictions; do not assume the first visible issue is the only one.

## Reproduce the reviewer path

Use the exact build and closest available review device/OS. Start from a clean install and follow the supplied screenshots/message. Inspect adaptive widths, localization, permissions, offline/network conditions, logged-out/gated states, StoreKit availability, and review credentials.

If exact reproduction is impossible, state the gap and test conservative variants.

## Implement the systemic fix

Fix every instance, not only the screenshot location. Update source, tests, design system, supported-device declaration, metadata, policies, and review notes as affected. Use a new build for binary changes.

Common controls:

- Subscription EULA: functional Terms link in description when using the standard Apple EULA, or configured custom EULA; verify paywall/legal links too.
- Crowded UI: redesign compact widths; do not simply shrink fonts. Audit every supported family/orientation/Dynamic Type size.
- New subscription group: submit group plus at least one product and required new app version in the same submission.
- Returned commerce items: repair and re-add the complete app/group/product dependency set.
- Stuck screenshots: delete, valid RGB re-export, small-batch upload, save, and inspect every Media Manager well.

Read `references/rejection-patterns.md` for the case-derived playbook.

## Verify before resubmission

Invoke `$ios-release-tester`, `$apple-app-designer`, `$app-compliance-auditor`, and `$app-store-connect-preparer` as affected. Build a requirement-to-evidence table. Confirm the selected build and every attached item status.

## Reply precisely

Write a short respectful response:

1. acknowledge the cited issue;
2. state the root cause;
3. state exactly what changed and in which build/metadata;
4. give clean reproduction steps;
5. identify supporting attachments;
6. ask one focused question only if necessary.

Do not argue that another app was approved, minimize the issue, or claim a fix without evidence.

## Resubmit the dependency set

Inspect the final submission modal. Include the app version, unapproved subscription group, and affected products when required. Submit only after all items are ready and no screenshot/build processing remains.

Return root cause, changes, verification, response draft, item checklist, residual risk, and post-submission monitoring plan.
