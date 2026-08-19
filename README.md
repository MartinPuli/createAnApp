# Create an App: AI-agent skills for shipping on the App Store

This repository is an operational skill suite for taking an Apple-platform app from an unproven idea to a measured App Store launch. It incorporates generalized lessons from end-to-end shipping work: market selection, native development, StoreKit subscriptions, TestFlight, App Review remediation, release, and post-launch compliance.

The system is evidence-gated: an agent must prove each stage before claiming the next stage is complete. It does not treat a successful build as a production release, an approval as product-market fit, or a legal checklist as legal advice.

The current Apple baseline was re-researched from primary sources on 2026-08-19. It now covers exact interface/media measurements, Xcode and SDK upload requirements, account and business prerequisites, metadata limits, TestFlight, StoreKit, privacy manifests and SDK signatures, accessibility labels, age ratings, conditional app types, review, distribution, and post-launch operation. See [`docs/current-apple-requirements.md`](docs/current-apple-requirements.md) and [`docs/full-lifecycle-checklist.md`](docs/full-lifecycle-checklist.md).

## Skill map

| Stage | Skill | Outcome |
|---|---|---|
| Coordinate | [`$app-store-launch-orchestrator`](skills/app-store-launch-orchestrator/SKILL.md) | Current-state dossier, next gate, and handoffs |
| Discover (optional) | [`$app-market-discovery`](skills/app-market-discovery/SKILL.md) | Ranked market and product opportunities |
| Validate | [`$app-idea-validator`](skills/app-idea-validator/SKILL.md) | Evidence and behavioral verdict for one existing idea |
| Specify | [`$apple-product-spec`](skills/apple-product-spec/SKILL.md) | Buildable product, data, monetization, and acceptance spec |
| Design | [`$apple-app-designer`](skills/apple-app-designer/SKILL.md) | Adaptive iPhone/iPad flows and visual QA matrix |
| Tool | [`$apple-agent-toolchain`](skills/apple-agent-toolchain/SKILL.md) | Safe XcodeBuildMCP/CLI and Apple automation setup |
| Build | [`$ios-app-builder`](skills/ios-app-builder/SKILL.md) | Production Swift/SwiftUI implementation |
| Verify | [`$ios-release-tester`](skills/ios-release-tester/SKILL.md) | Test, archive, persistence, StoreKit, and device evidence |
| Submit | [`$app-store-connect-preparer`](skills/app-store-connect-preparer/SKILL.md) | Complete App Store Connect submission dossier |
| Audit | [`$app-compliance-auditor`](skills/app-compliance-auditor/SKILL.md) | Privacy, security, AI, claim, and rights review |
| Recover | [`$app-review-recovery`](skills/app-review-recovery/SKILL.md) | Rejection diagnosis, remediation, and resubmission |
| Launch | [`$app-launch-operator`](skills/app-launch-operator/SKILL.md) | Measured, policy-safe distribution loop |

Start with `$app-store-launch-orchestrator` when the app's state is unclear. Use `$app-market-discovery` only when no idea has been selected. If the user already has an idea, begin directly with `$app-idea-validator`; do not make them repeat market discovery.

## Independent entry routes

- **No idea yet:** `$app-market-discovery` → `$app-idea-validator` → specification → design/build → release/compliance → submission → launch.
- **Idea already chosen:** `$app-idea-validator` → specification → design/build → release/compliance → submission → launch.
- **App already being built:** begin at the earliest unproven design, build, test, compliance, or submission gate.
- **App rejected:** begin with `$app-review-recovery`, then re-run every gate invalidated by the fix.
- **App already live:** begin with `$app-launch-operator` and keep compliance/security triggers active.

Market discovery is optional. Validation, release evidence, compliance, and launch controls are not optional merely because code already exists.

## Evidence gates

1. **Discovery (optional):** a broad market search ranks distinct opportunities without calling them validated.
2. **Validation:** one chosen idea has documented demand, competition, distribution, native advantage, economics, risk, falsifiers, and behavioral gates.
3. **Specification:** every marketed promise maps to an acceptance test and every data flow maps to a disclosure.
4. **Design:** all supported device families, orientations, Dynamic Type, accessibility, empty/error/loading states, and paywalls are usable.
5. **Implementation:** core jobs are real; no prototype button or mock export is presented as functional.
6. **Release:** clean build, automated tests, StoreKit, persistence, restore, archive validation, and TestFlight evidence exist.
7. **Compliance:** binary, website, metadata, privacy labels, terms, AI claims, SDKs, and content rights agree.
8. **Submission:** agreements, bundle, build, metadata, screenshots, review access, subscriptions/IAP, and release controls are complete.
9. **Launch:** attribution links, support, rollback, budget caps, and decision thresholds exist.
10. **Learning:** retention, paid conversion, refunds, support, and proceeds—not downloads alone—drive iteration.

## What the agent cannot impersonate

The agent can research, write, code, test, prepare assets, and automate supported APIs. A human account holder must handle identity verification, legal attestations, contracts, tax and banking truth, regulated professional sign-off, payment authorization, credentials/MFA, and irreversible submission or release actions when the tooling or account policy requires them. See [`docs/human-handoff-matrix.md`](docs/human-handoff-matrix.md).

## App Review lessons

The suite includes reusable controls for recurring review failures, including:

- auto-renewable subscriptions submitted without a functional Terms of Use link in metadata;
- interfaces that function technically but become crowded or unusable on a supported device;
- new subscription groups submitted without a configured product from the group;
- screenshot uploads that remain stuck in processing;
- dependent subscription or IAP items returned after an associated app-version rejection.

The generalized causes, recovery steps, and permanent controls are in [`docs/app-review-lessons.md`](docs/app-review-lessons.md).

## What is covered

- Broad opportunity research and separate behavioral validation of a chosen idea.
- Product scope, device contract, architecture, data map, monetization, and acceptance tests.
- Apple UI measurements, adaptive layouts, accessibility, icons, screenshots, and preview-video specifications.
- Developer account, roles, agreements, tax/banking, DSA, bundle identity, signing, Xcode/SDK, archive, and upload.
- App Store metadata, privacy, age rating, export compliance, accessibility labels, TestFlight, IAP/subscriptions, review access, release modes, and distribution methods.
- Conditional controls for accounts, social login, UGC, uploads, analytics/ads, AI, children, health, regulated products, encryption, and EU distribution.
- Review-rejection recovery, public launch verification, attribution, cohort economics, support, rollback, and ongoing compliance.

## Validate the suite

```bash
./scripts/validate-all-skills.sh
```

The validator checks skill structure, interface metadata, forbidden placeholders, required lifecycle coverage, and accidental secret patterns.

## Execute a release

The repository also includes a conservative executable path for an existing Xcode project:

1. archive and export one signed IPA;
2. verify that exact IPA's identity, version, build, signature, privacy manifest when applicable, and required packaged text;
3. validate and upload that same artifact;
4. stage the build and editable metadata through the App Store Connect API;
5. leave legal attestations, final submission, phased release, and irreversible account actions at the documented authority gate.

See [`docs/executable-release-flow.md`](docs/executable-release-flow.md). The included [`.mcp.json`](.mcp.json) pins the researched XcodeBuildMCP version so a later upstream release cannot silently change the workflow.

## Source policy

Platform rules change. Each production run must re-check current primary sources rather than relying on dates or UI labels in this repository. Start with [`docs/official-sources.md`](docs/official-sources.md).

## License

MIT. See [`LICENSE`](LICENSE).
