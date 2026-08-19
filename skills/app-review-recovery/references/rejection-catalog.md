# App Review rejection catalog

This catalog maps recurring signals to likely causes. The reviewer message and exact current guidelines remain authoritative; never infer the final cause from a guideline number alone.

| Guideline area | Common reviewer signal | Frequent root causes | Evidence and correction |
|---|---|---|---|
| 1.2 User-Generated Content | Missing moderation or abusive-content controls | Public content without filtering, reporting, blocking, contact, or response operation | Exercise publish/report/block/moderate paths; implement the full policy and operational loop |
| 1.4 Physical Harm | Unsafe health/safety statement or unsupported measurement | Diagnostic claim without methodology, fabricated sensor capability, missing professional reminder/clearance | Remove impossible claims or provide substantiation, boundaries, regulated evidence, and accurate review notes |
| 1.5 Developer Information | Support cannot be reached | Placeholder URL, no contact path, stale developer information | Open public support from a clean session and prove monitored contact |
| 1.6 Data Security | Inadequate protection of user information | Embedded secret, weak authorization, excessive retention, insecure transport/storage | Threat-model the exact flow, remediate, retest, and update policy/labels |
| 2.1 App Completeness | Crash, broken flow, placeholder, missing review access | Wrong environment, empty catalog, unavailable backend, mock feature, stale demo account | Reproduce on reviewed device/build; fix systemically; provide deterministic access and evidence |
| 2.3 Accurate Metadata | Screenshots/description/name do not match the binary | Unshipped claims, hidden prices, competitor terms, old screenshots, misleading category/rating | Build promise-to-evidence matrix; replace every unsupported field/asset |
| 2.5 Software Requirements | Private/deprecated API, wrong entitlement, downloading executable behavior | Unsupported framework use, mismatched capabilities, remote code or improper background behavior | Inspect archive and runtime; use public APIs and valid entitlements only |
| 3.1 Payments | Digital purchase bypasses IAP or subscription information is incomplete | External checkout without applicable rule, hardcoded price, no restore, missing EULA, weak ongoing value | Re-evaluate product type/storefront rules; implement StoreKit and transparent commerce; test dependency set |
| 3.2 Business | Submitted by wrong entity or regulated authorization absent | Individual account offers regulated service, missing licenses/partnership proof | Submit through the responsible legal entity and attach current authorization |
| 4.0 Design | Crowded, clipped, confusing, template-like, or unusable on a supported device | Single-device design, accidental iPad support, tiny targets, inaccessible or low-quality workflow | Redesign by size class/device; run visual and accessibility matrix on exact review environment |
| 4.1 Copycats | App/metadata/icon resembles another product | Copied branding, interface, name, description, or misleading affiliation | Establish distinct identity and rights; replace copied or confusing material |
| 4.2 Minimum Functionality | Not enough lasting value, repackaged site, thin wrapper | Static content, generic AI wrapper, narrow novelty, no native utility | Add durable user value and native functionality, or stop/pivot before resubmission |
| 4.3 Spam | Duplicate/template app or saturated low-value variant | Multiple near-identical binaries, repackaged content, category spam | Consolidate products and demonstrate distinct sustained value |
| 4.8 Login Services | Social login lacks equivalent option | Primary account created through third-party login without qualifying alternative/exception | Add compliant equivalent login or document the precise exception |
| 5.1 Privacy | Labels, policy, permission, manifest, or deletion behavior disagree | SDK collection omitted, missing purpose string, no account deletion, tracking without controls | Rebuild data map from binary/traffic; reconcile every public and runtime surface |
| 5.2 Intellectual Property | Rights to content/service/brand cannot be shown | Unlicensed media/data/fonts/marks, scraping or third-party-service use against terms | Remove content or document specific rights and platform authorization |
| Age rating / Kids | Questionnaire or child controls do not match content | UGC/chat/ads/medical themes understated, Kids rules unmet | Re-answer current questionnaire and implement audience-appropriate controls |
| Export compliance | Encryption answer or documentation unresolved | Info.plist and actual crypto behavior disagree | Determine actual use, obtain qualified input where needed, upload documents and reconcile declaration |
| Submission dependency | IAP/group/item returned or cannot be added | First product omitted, associated app rejected, wrong platform submission | Model the item dependency graph and resubmit the complete corrected set |

## Recovery sequence

1. Preserve reviewer text, attachments, device, OS, version/build, submission ID, and item set.
2. Translate each sentence into a testable claim; separate explicit issue from inferred risk.
3. Reproduce the reviewer path on the exact candidate and closest available environment.
4. Search the complete app for every other instance of the same root cause.
5. Fix the system, not only the screenshot or single example.
6. Re-run every invalidated design, build, privacy, commerce, metadata, and review-access gate.
7. Prepare a concise response: acknowledge, identify root cause, state exact changes, give reproduction steps, and cite build/version.
8. Inspect the resubmission item set before the authorized submission action.

Primary source: [App Review Guidelines](https://developer.apple.com/app-store/review/guidelines/) and Apple's [common review issues](https://developer.apple.com/app-store/review/).
