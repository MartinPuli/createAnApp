# Create an App: AI-agent skills for shipping on the App Store

This repository is an operational skill suite for taking an Apple-platform app from an unproven idea to a measured App Store launch. It incorporates generalized lessons from end-to-end shipping work: market selection, native development, StoreKit subscriptions, TestFlight, App Review remediation, release, and post-launch compliance.

The system is evidence-gated: an agent must prove each stage before claiming the next stage is complete. It does not treat a successful build as a production release, an approval as product-market fit, or a legal checklist as legal advice.

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

## Run it

Claude Code agents get their entry point from [`CLAUDE.md`](CLAUDE.md) and the
XcodeBuildMCP server from [`.mcp.json`](.mcp.json). The pipeline's mechanical
stages are scripts, not prose:

```bash
scripts/archive-and-upload.sh --project ios/MyApp.xcodeproj --scheme MyApp --team TEAMID --out /tmp/rel
scripts/verify-ipa.sh --ipa /tmp/rel/export/MyApp.ipa --version 1.0.1 --build 4 --require "some shipped disclosure"
scripts/archive-and-upload.sh ... --upload
scripts/asc-release.py --bundle-id com.example.app --version 1.0.1 --build 4 --notes whats-new.txt   # add --submit only when the human says ship
```

Export and upload are deliberately separate with the IPA ship gate between
them, and `--submit` never runs implicitly. Two companion playbooks round out
the lifecycle: [`docs/consumer-terms-liability.md`](docs/consumer-terms-liability.md)
for the terms that actually reduce exposure, and
[`docs/niche-distribution.md`](docs/niche-distribution.md) for launch economics
in small markets.

## Validate the suite

```bash
./scripts/validate-all-skills.sh
```

The validator checks skill structure, interface metadata, forbidden placeholders, required lifecycle coverage, and accidental secret patterns.

## Source policy

Platform rules change. Each production run must re-check current primary sources rather than relying on dates or UI labels in this repository. Start with [`docs/official-sources.md`](docs/official-sources.md).

## License

MIT. See [`LICENSE`](LICENSE).
