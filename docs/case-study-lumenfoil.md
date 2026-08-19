# Sanitized case study: Lumenfoil from idea to approval

This case study records process lessons, not private account data. Identifiers, credentials, banking/tax details, addresses, phone numbers, private email addresses, and signing materials are intentionally omitted.

## Product path

The work did not begin with the final product. Multiple opportunities were researched and displaced when competition, platform risk, distribution, or operating burden invalidated the thesis. The final candidate was an iPad-first stained-glass pattern studio with a narrow job: turn a pattern into a workbench-ready plan using numbered pieces, cutability checks, material estimates, and exports.

The important decision was not “use AI.” It was to select a job where iPad, Apple Pencil, local persistence, visual editing, and printable output were part of the work itself. AI assistance was used to research and build; the released product did not falsely claim an AI feature.

## Implementation evidence

The release candidate used SwiftUI, local JSON persistence, StoreKit 2 monthly and annual subscriptions, a StoreKit configuration for deterministic purchase testing, unit tests, XCUITests, a privacy manifest, real exports, support/privacy links, an App Store icon, and an iPad-only target configuration.

Testing covered:

- build and launch on the intended simulator family;
- editing and undo/redo;
- termination/relaunch persistence;
- navigation through every primary section;
- real export paths;
- StoreKit product identifiers and prices;
- purchase UI and restore path;
- screenshot capture from the exact build;
- archive/signing and TestFlight checks.

## Rejection 1: missing Terms of Use metadata

**Apple signal:** the app offered auto-renewable subscriptions but App Review could not find a functional Terms of Use (EULA) link in app metadata.

**Root cause:** subscription code and products were functional, but the submission dossier treated policy URLs as website/app concerns and omitted the EULA link from the metadata location reviewers used.

**Fix:** use a functional custom EULA configured in App Store Connect or put the standard Apple EULA URL in the App Description. Verify it in the saved localization, the live URL, and the paywall/legal surface. Resubmit the app version and every returned subscription item together.

**Permanent control:** metadata preflight must search the final description for a reachable Terms of Use URL whenever auto-renewable subscriptions exist.

## Rejection 2: crowded adaptive interface

**Apple signal:** Guideline 4 design issue. The interface was crowded and tasks were difficult on review devices, including an iPad and a large iPhone.

**Root cause:** the UI passed functional automation but not visual usability. Multi-column controls collapsed to extremely narrow widths, text wrapped vertically, segmented controls truncated, and the supported-device declaration exposed an experience that had not been visually audited.

**Fix:** redesign narrow workspaces so the canvas remains primary and secondary inspectors become sheets or navigation destinations. Audit the exact supported device families and orientations. If the product is intentionally iPad-only, set and verify the targeted device family rather than shipping an accidental iPhone layout.

**Permanent control:** a green unit/UI test suite is insufficient. Require screenshot review at compact and regular widths, the smallest/largest supported screens, portrait/landscape where declared, Dynamic Type, and real TestFlight hardware.

## Submission dependency failure

**Signal:** a new subscription group could not be submitted because it was not accompanied by an auto-renewable subscription from that group.

**Fix:** for the first subscription, add the app version, new subscription group, and at least one configured subscription product to the same submission. When the app version is rejected, associated first-time products may be returned; repair and resubmit the complete dependency set.

## Screenshot processing failure

**Signal:** App Store Connect reported screenshot uploads in progress for hours and blocked Add for Review.

**Recovery:** remove the stuck assets, re-export valid RGB JPEG/PNG at an accepted exact size, upload a small batch, save, and inspect Media Manager before adding the rest. Do not wait indefinitely while the submission remains blocked.

## Approval is not market fit

Approval proved policy and review acceptance for that version. It did not prove demand, retention, willingness to pay, or profitable acquisition. Those require App Analytics/Sales evidence, cohort retention, subscription conversion/renewal, refund/support data, and controlled campaign attribution.

## Controls extracted into this suite

1. Treat platform metadata as code: version it and preflight it.
2. Test the commercial lifecycle, not only features.
3. Match supported device declarations to verified design evidence.
4. Reconcile privacy across source, binary, SDKs, manifest, website, and App Store labels.
5. Keep asset provenance and AI-use truth for every public creative.
6. Prepare review notes as a reproducible test script.
7. Resubmit dependency sets, not isolated rejected items.
8. Keep human-only identity, contract, tax, banking, and legal attestations out of agent automation.
