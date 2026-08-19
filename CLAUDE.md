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
| Build | `$ios-app-builder` | XcodeBuildMCP (`.mcp.json` wires it) |
| Verify | `$ios-release-tester` | `xcodebuild test` on a booted simulator; then the **Release configuration itself** |
| Package | — | `scripts/archive-and-upload.sh` |
| Ship gate | — | `scripts/verify-ipa.sh` — run BEFORE upload, on the exported IPA |
| Submit | `$app-store-connect-preparer` | `scripts/asc-release.py` (idempotent; `--submit` stays human-gated) |
| Audit | `$app-compliance-auditor` | trigger map in the skill references; `docs/consumer-terms-liability.md` |
| Recover | `$app-review-recovery` | `docs/app-review-lessons.md` + the rejection-pattern playbook |
| Launch | `$app-launch-operator` | scorecard + spend gates; `docs/niche-distribution.md` |

## Hard-won rules (read before repeating the mistakes)

- A product-catalog request can return **empty without throwing**. Never render
  a price the catalog did not return; disable purchase until the product
  resolves. `docs/app-review-lessons.md`.
- Run the **Release configuration**, not only tests: config-gated content can
  ship an empty app while Debug looks full.
- Purchase-flow tests hang headless (the payment sheet needs UI). Keep catalog
  tests deterministic; gate sheet-crossing tests and record the skip reason.
- Store records are immutable: released version slots close, and product
  identifiers burn on create-delete. Check before coupling code to them.
- Rewrite review notes per submission. Never reference an attachment that is
  not attached. Declare encryption truthfully in the project so export
  compliance stops blocking every submission.
- Consumer terms: disclaimers cannot waive consumer-protection statutes;
  arbitration with an individual-claims waiver is the clause that matters;
  content accuracy is the only control that prevents claims.
  `docs/consumer-terms-liability.md`.

## Human-only gates

Identity/MFA, agreements, tax/banking, payment authorization, licensed
professional sign-off, and the final irreversible submit (`--submit`) belong to
the account holder. Prepare everything, verify after they act, continue. Full
matrix: `docs/human-handoff-matrix.md`.
