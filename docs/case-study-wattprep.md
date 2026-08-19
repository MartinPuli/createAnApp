# Sanitized case study: WattPrep from idea to a live listing and a compliance update

Process lessons from a second real launch: a Texas journeyman-electrician exam-prep iPhone app, taken through four App Review rejections to approval, release, and a post-launch compliance update. Identifiers, credentials, signing materials, and account data are intentionally omitted. Where this case repeats a Lumenfoil lesson it is not restated; read both.

## Product path

The niche was selected from a regulator's own published statistics: the state licensing body publishes exam volumes and pass rates (8,490 exams, 27.9% pass in the last fiscal year). That one number did three jobs — it validated demand, it sized the ceiling honestly (~6,000 unique candidates a year; a profitable side product, not a company), and after verification against the primary source it became the headline marketing claim. The rule extracted: a statistic used in marketing must be traced to the primary source *before* it ships, because an unverifiable claim on a store page or landing page is itself a consumer-protection violation.

The exam format was the product insight: open-book, two separately timed and separately scored parts. The app trained speed-in-the-code rather than memorization, which no national competitor mirrors. Positioning followed the same logic — be first in the state-specific niche rather than thirteenth in the national category, and price against the $315–400 classroom course, never against the $19.99 generic apps.

## Implementation evidence

SwiftUI + SwiftData, a deterministic XcodeGen project (no hand-edited pbxproj), StoreKit 2 with one auto-renewable subscription and one non-consumable lifetime unlock, a StoreKit configuration file for deterministic purchase tests, a privacy manifest, and **zero network code** — no URLSession, no third-party SDKs, no analytics. The "Data Not Collected" privacy label was therefore auditable by grep rather than asserted by policy: there is no code path capable of transmitting data.

## Rejection: Guideline 2.1(b) — a paywall that looked alive and was dead

**Apple signal:** in-app purchase products could not be purchased during review.

**Root cause:** `Product.products(for:)` can return an **empty array without throwing** — on slow storefronts, sandbox hiccups, and cold launches. The paywall rendered hardcoded price strings and enabled buy buttons regardless, so the reviewer saw prices and tapped buttons that did nothing. Every local test had passed because the local catalog always loaded.

**Fix:** explicit `loading / loaded / failed` state; retry with exponential backoff; **never render a price StoreKit did not return** (show a placeholder); keep purchase buttons disabled until their product object exists; a visible retry path with an honest error.

**Permanent control:** the paywall may only display catalog-derived prices. Preflight includes a cold launch on a clean simulator watching the catalog actually load, and review notes state the exact tap path to the paywall.

## Rejection: screenshot exact-size failures

Store slots and IAP review screenshots each accept exact pixel sizes only (e.g. 1242×2208 for the IAP review image, 1284×2778 for the 6.5-inch slot). Uploads at any other size fail late, after the dossier looks complete. Control: export to the slot's accepted size exactly, verify dimensions programmatically before upload.

## Failure: a reserved product identifier

A product ID deleted and recreated during setup became permanently unusable ("reserved"). The code, config, and docs all had to migrate to a new identifier. Control: treat product IDs as immutable and burned once created in App Store Connect; create them in ASC first and only then wire them into code.

## Failure: the Release build shipped zero content

A content-quality gate (`smeApproved`) filtered the question bank in Release configuration only. Debug showed 20 questions; Release showed none. Every functional test had run in Debug. Control: a unit test now asserts the bundled content passes the release gate, and preflight runs the Release configuration, not just the tests.

## Failure: headless StoreKit purchase tests wedge the suite

`product.purchase()` presents a payment sheet, which requires a foreground UI. Under headless `xcodebuild test` the call never returns and takes the test host down — the suite reports TEST FAILED with no failing assertion. Control: purchase-flow tests are gated behind an environment variable and skip with a stated reason in headless runs; catalog-load tests still run everywhere.

## Operational lessons around App Store Connect

- **A released version closes its slot.** Compliance changes cut after the shipped build required a new marketing version (1.0.1); a new build cannot attach to a released version. Plan version numbers around what has already gone live.
- **Stale review notes invite rejection.** Notes carried over from a prior submission promised an attached screen recording that was not attached and described the wrong build number. Rewrite review notes per submission; promise only what is actually attached.
- **Declare export compliance in the project.** `ITSAppUsesNonExemptEncryption: NO` (when truthful — this app has no networking at all) removes a manual blocking question from every submission.
- **The ASC API replaces the browser.** When browser automation is unavailable, an App Store Connect API key (ES256 JWT) can poll the uploaded build to `VALID`, create or reuse the version, attach the build, set localized release notes, and submit. Keep every step idempotent so a re-run resumes instead of duplicating, and keep the irreversible submit behind an explicit flag a human turns on.

## Legal architecture for a solo developer

This case added the liability work the first case lacked. The load-bearing findings:

1. **Disclaimers cannot waive consumer-protection statutes.** Texas Bus. & Com. Code §17.42 voids a consumer's DTPA waiver unless the consumer had independent counsel at purchase — never true of an app buyer. A liability cap manages a claim after it exists; it does not defeat a deceptive-trade-practices claim arising from a false statement in the content. Fee-shifting statutes make small-ticket suits economical for plaintiffs' lawyers, so "the app only costs $40" is not a defense strategy.
2. **Arbitration with an individual-claims waiver is the highest-value clause.** The class action is the scenario that exceeds a niche app's lifetime value by orders of magnitude; binding individual arbitration with a small-claims carve-out and a 30-day opt-out removes it. This single paragraph is worth more than every other clause combined.
3. **Content accuracy is the only control that prevents claims rather than managing them.** A disclaimer does not make a false statement true. A small bank of independently verifiable facts can ship on technical review; *scaling* the content is what requires a licensed professional's sign-off. Record provenance honestly in the data (an explicit `licensedSmeSignOff: false` flag) rather than implying a review that has not happened.
4. **Disclose AI at the point of use, not only in the terms.** Machine-refined output is labeled where it appears, with the human-reviewed part stated plainly. Buried-in-ToS disclosure is treated as weaker by regulators and stores alike.
5. **Safety-adjacent surfaces carry their own notice.** Any screen a user might rely on for real-world work (field calculators here) shows a persistent verify-against-the-source notice. Cheap insurance against the one claim category no contract can waive: personal injury.
6. **No user-generated content = no third-party copyright surface.** State it in the terms; it forecloses an entire claim category.
7. **What remains open is structural, not contractual:** an LLC (liability shield) and E&O insurance are the only mitigations for the personal-injury tail; neither can be replaced by drafting.

## Distribution lessons for a niche market

- Compute the ceiling before spending: ~6,000 buyers/year × realistic penetration told us $300 of marketing recovers after 9 lifetime sales, and interest-targeted social ads can never pay (the audience is unfindable by interest). Search ads on exact state-specific terms are the only paid channel with intent.
- **The app-name field outranks the keyword field.** A brand-only name ("WattPrep") carries zero search terms while every competitor spends the name field on them. Rename to `Brand: Category Term` at the next metadata edit — free, no build required.
- Zero reviews is a conversion blocker ahead of any traffic problem. Apple grants **100 promo codes per version** — free lifetime-unlock inventory to seed honest reviews through instructors and cohorts. In-app, request a review only after the user passes a milestone (a passed mock exam), gated to a repeat success and once per version, because iOS grants three prompts a year.
- The highest-leverage channel was not an ad: the offline classroom operators (trade-association chapters charging $315–400 for prep courses) teach the exact buyer. Offer the app free to instructors and cohorts as the between-sessions drill — complementary to the class, not competitive with it.

## Controls extracted into this suite

1. Prices on a paywall come only from the live catalog; buy buttons stay disabled until products resolve.
2. Run and inspect the Release configuration before any archive; test that shipped content passes its own release gates.
3. Treat product IDs as immutable once created; create in ASC before wiring into code.
4. Rewrite review notes per submission; never reference an attachment that is not attached.
5. Verify every marketed statistic against its primary source before it appears anywhere public.
6. Arbitration + individual-claims waiver in consumer terms; AI disclosure at point of use; safety notices on reliance surfaces; honest provenance flags in shipped data.
7. Compute niche unit economics before allocating any marketing budget; prefer name-field ASO, promo codes, and channel partners over paid social in small markets.
