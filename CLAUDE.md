# Agent entry point

This repository is an executable pipeline for taking an Apple-platform app from
an unproven idea to a live App Store listing. Read `AGENTS.md` for conduct
rules; this file tells you where to start and what to run.

## Start here

1. Read the current state. If it is unclear, run the
   `$app-store-launch-orchestrator` skill first and build the dossier.
2. Enter at the earliest unproven gate (see `README.md` → Independent entry
   routes). Never re-run discovery when the user already chose an idea.
3. Every stage claim needs evidence. A green build is not a release; an
   approval is not market fit.

## Stage → what you actually run

| Stage | Skill | Executable |
|---|---|---|
| Coordinate | `$app-store-launch-orchestrator` | dossier in the working repo |
| Discover / Validate | `$app-market-discovery` / `$app-idea-validator` | web research; primary sources only |
| Specify / Design | `$apple-product-spec` / `$apple-app-designer` | spec + visual QA matrix |
| Build | `$ios-app-builder` | XcodeGen project; XcodeBuildMCP (`.mcp.json` wires it) |
| Verify | `$ios-release-tester` | `xcodebuild test` on a booted simulator; then **Release config itself** |
| Package | — | `scripts/archive-and-upload.sh` |
| Ship gate | — | `scripts/verify-ipa.sh` — run BEFORE upload, on the exported IPA |
| Submit | `$app-store-connect-preparer` | `scripts/asc-release.py` (idempotent; `--submit` stays human-gated) |
| Audit | `$app-compliance-auditor` | trigger map in the skill references |
| Recover | `$app-review-recovery` | rejection-pattern playbook |
| Launch | `$app-launch-operator` | scorecard + spend gates |

## Hard-won rules the docs encode (read before you repeat the mistakes)

- `Product.products()` returns **empty without throwing**. Never render a price
  StoreKit did not return. `docs/case-study-wattprep.md`.
- Run the **Release configuration**, not only tests: config-gated content can
  ship an empty app while Debug looks full.
- Purchase-flow tests hang headless (the payment sheet needs UI). Gate them
  behind an env var; skip with a reason.
- A released App Store version closes its slot — new builds need a new
  marketing version.
- Rewrite review notes per submission. Never reference an attachment that is
  not attached.
- Declare `ITSAppUsesNonExemptEncryption` truthfully in the project spec so
  export compliance stops blocking every submission.
- Consumer terms: arbitration + individual-claims waiver is the clause that
  matters; disclaimers cannot waive consumer-protection statutes; content
  accuracy is the only control that prevents claims. `docs/case-study-wattprep.md`.

## Human-only gates

Identity/MFA, agreements, tax/banking, payment authorization, licensed
professional sign-off, and the final irreversible submit (`--submit`) belong to
the account holder. Prepare everything, verify after they act, continue. Full
matrix: `docs/human-handoff-matrix.md`.
