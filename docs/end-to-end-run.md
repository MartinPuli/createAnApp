# Example end-to-end agent run

## User request

> Find the best iPad app opportunity I can operate with minimal human work, build it, prepare subscriptions and App Store submission, recover from review issues, and launch it.

## Orchestrated response pattern

1. `$app-store-launch-orchestrator` creates the dossier and marks every gate unassessed.
2. If no idea exists, `$app-market-discovery` searches broadly, records dated evidence, and ranks distinct opportunities. If the idea already exists, skip this step.
3. `$app-idea-validator` freezes the selected idea, tests its assumptions and behavioral gates, and returns a validation verdict without silently replacing it.
4. `$apple-product-spec` freezes v1 scope, device contract, subscription value, data map, risk register, and acceptance tests.
5. `$apple-app-designer` creates adaptive iPad/compact-width behavior and the visual QA matrix before implementation.
6. `$apple-agent-toolchain` verifies XcodeBuildMCP, Xcode, simulators, native fallback tools, and authority boundaries.
7. `$ios-app-builder` implements real vertical slices, StoreKit, persistence, manifests, accessibility, errors, and tests.
8. `$ios-release-tester` verifies the exact candidate across device, visual, persistence, export, commerce, archive, and TestFlight layers.
9. `$app-compliance-auditor` reconciles code, binary, SDKs, website, labels, terms, claims, AI use, and asset rights.
10. `$app-store-connect-preparer` assembles metadata, screenshots, review path, first subscription group/products, and human account handoffs.
11. If rejected, `$app-review-recovery` preserves the incident, reproduces it, applies the systemic fix, verifies, and resubmits the complete item set.
12. `$app-launch-operator` verifies public availability, activates campaign attribution, publishes truthful creatives, enforces spend gates, and measures retention/proceeds.
13. The orchestrator audits every requirement and reports shipped only after public availability, commerce, support, and measurement are proven.

## Existing-idea shortcut

For a request such as “I already have an app idea; validate it and take it to launch,” the valid sequence is:

`$app-idea-validator` → `$apple-product-spec` → design → toolchain/build → release testing → compliance → App Store Connect → review recovery if needed → launch.

`$app-market-discovery` is deliberately omitted.

## Agent autonomy boundary

The agent completes all safe research, writing, implementation, testing, artifact creation, and supported automation. It pauses only for actual human-only gates such as identity/MFA, legal agreements, bank/tax truth, payment authorization, qualified professional sign-off, or irreversible submission/release when no delegated authority exists. After the human completes a gate, the agent verifies the external result and continues.
