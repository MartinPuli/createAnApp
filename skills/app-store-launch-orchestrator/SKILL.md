---
name: app-store-launch-orchestrator
description: Coordinate an Apple app from idea research through specification, design, development, testing, App Store Connect, compliance, review recovery, release, and post-launch measurement. Use when the user asks to create, finish, ship, publish, launch, or assess an iPhone, iPad, macOS, watchOS, tvOS, or visionOS app; when the current stage is unclear; or when several specialist skills must be sequenced without skipping evidence gates.
---

# App Store Launch Orchestrator

Create and maintain a launch dossier, identify the earliest unproven prerequisite, route the work to the correct specialist skill, and refuse false completion claims.

## Start with current state

1. Inspect the repository, build configuration, tests, assets, policies, website, store metadata, account status, and prior review messages.
2. Read `../../docs/lifecycle.md`, `../../docs/human-handoff-matrix.md`, and `../../docs/completion-audit.md` when available.
3. Record each lifecycle gate as `UNASSESSED`, `BLOCKED`, `FAILED`, `CONDITIONAL`, `PASSED`, or `STALE`.
4. Treat external state as authoritative. Do not rely on prior chat claims that something was uploaded, tested, accepted, or released.
5. Identify the earliest failed prerequisite; do not optimize a later stage while it remains unresolved unless the later work is safely parallel.

## Route the work

| Need | Invoke |
|---|---|
| No idea exists; discover markets and candidates | `$app-market-discovery` |
| A specific idea exists; validate or falsify it | `$app-idea-validator` |
| Convert evidence into scope | `$apple-product-spec` |
| Design or audit UI across Apple devices | `$apple-app-designer` |
| Configure Xcode/MCP/API tooling | `$apple-agent-toolchain` |
| Implement the app | `$ios-app-builder` |
| Test release behavior and archives | `$ios-release-tester` |
| Complete App Store Connect | `$app-store-connect-preparer` |
| Audit privacy, security, AI, claims, or rights | `$app-compliance-auditor` |
| Diagnose or recover from rejection | `$app-review-recovery` |
| Launch and measure distribution | `$app-launch-operator` |

If a named skill is unavailable, implement its evidence contract directly rather than skipping the stage.

Do not force discovery when the user already has an idea. Preserve that idea as the validation subject and route directly to `$app-idea-validator`. If validation falsifies it, report that result; invoke discovery only when the user asks for replacement ideas.

## Maintain the launch dossier

For every gate, capture:

- requirement and acceptance condition;
- current evidence with path, URL, build number, or screenshot;
- contradiction or missing evidence;
- owner: agent, human, or qualified professional;
- next action and verification method;
- invalidation triggers.

Redact secrets and personal identity, banking, tax, address, phone, credential, signing, and private-key data.

## Control human handoffs

Continue autonomous work until a human-only action is the actual next gate. Prepare exact fields and instructions, but leave identity, agreements, tax, banking, DSA status, export/legal attestations, regulated sign-off, credentials/MFA, payment authorization, and irreversible public release to the authorized human.

Do not stop merely because a human action will eventually be required. Complete every safe prerequisite first.

## Apply stop-ship rules

Stop submission or release when any of these is true:

- a marketed core feature is mocked, missing, or fails;
- supported-device UI is visually broken or unaudited;
- purchase, restore, entitlement, cancellation/expiration, or offline behavior is unverified;
- privacy labels, policies, manifest, SDK behavior, and data map disagree;
- required support, privacy, or Terms URLs fail;
- review cannot access gated functionality;
- subscription/IAP dependency items are missing;
- unresolved high-severity security, safety, rights, or deceptive-claim risk exists;
- archive/signing evidence does not match the selected build.

## Prove completion

Before reporting a stage complete, build the requirement-to-evidence table from `../../docs/completion-audit.md`. Report exact remaining human actions separately. Call the product `shipped` only after storefront availability, commerce, support, and measurement are verified.
