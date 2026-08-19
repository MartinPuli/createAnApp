# Create an App: AI-agent skills for shipping on the App Store

This repository is an operational skill suite for taking an Apple-platform app from an unproven idea to a measured App Store launch. It was extracted from a real end-to-end launch that included market reselection, native iPad development, StoreKit subscriptions, TestFlight, two App Review rejections, remediation, approval, release, and post-launch compliance work.

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

## Real rejection lessons

The source launch failed twice before approval:

- Auto-renewable subscriptions were submitted without a functional Terms of Use link in metadata.
- A later review found the interface crowded and unusable on supported iPad/iPhone review devices.

Other encountered failure modes included submitting a new subscription group without one of its products and screenshot uploads remaining stuck in processing. The complete sanitized case study and recovery rules are in [`docs/case-study-lumenfoil.md`](docs/case-study-lumenfoil.md).

## Validate the suite

```bash
./scripts/validate-all-skills.sh
```

The validator checks skill structure, interface metadata, forbidden placeholders, required lifecycle coverage, and accidental secret patterns.

## Source policy

Platform rules change. Each production run must re-check current primary sources rather than relying on dates or UI labels in this repository. Start with [`docs/official-sources.md`](docs/official-sources.md).

## License

MIT. See [`LICENSE`](LICENSE).
