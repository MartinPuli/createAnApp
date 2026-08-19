# Conditional Apple requirement matrix

Use this matrix to identify additional work; verify the current guideline and applicable law before acting.

| Trigger | Minimum Apple-facing controls |
|---|---|
| Account creation | In-app initiation of full account deletion; explain billing/cancellation; delete associated data unless retention is legally required |
| Third-party/social primary login | Equivalent privacy-preserving login option unless a documented Guideline 4.8 exception applies |
| Public UGC, social, messaging, creator content | Filtering, report flow, timely response, user blocking, public contact, moderation operations, age/content controls where required |
| User file uploads | Permission and purpose, file validation, malware/abuse controls, storage/retention/deletion, rights representation; add public-content controls if shared |
| Tracking/ads/attribution | Tracking determination, ATT where required, consent, labels, manifest/domains, vendor review, Kids/health restrictions |
| Required-reason API | Accurate approved reason in each responsible bundle's privacy manifest; no fingerprinting |
| Listed third-party SDK | Required privacy manifest and, for binary dependencies, signature; verify vendor/version provenance |
| Auto-renewable subscription | Ongoing value, ≥7-day period, all-device access, clear pre-purchase terms, restore, EULA/Privacy, group/product submission dependency |
| Health/medical | Accuracy methodology, doctor reminder where relevant, regulated status declaration when triggered, clearance documentation, sensitive-data restrictions, correct legal entity |
| Finance/crypto/gambling/air travel or other regulated service | Correct licensed/legal entity, authorization/partnership evidence, territory and regulatory review |
| Kids Category / child-directed audience | Parental gates, age-appropriate content, strict analytics/ads/data constraints, applicable child-privacy review; Made for Kids choice becomes durable after approval |
| AI generation or advice | Truthful disclosure where material, model/provider and data review, feedback/refinement, safety boundaries, provenance, no fabricated endorsements/results |
| Encryption | Truthful export-compliance determination, documentation where required, and consistent Info.plist declaration |
| EU distribution | DSA trader decision/contact verification; territory-specific consumer, privacy, platform, labeling, medical, tax, and alternative-terms analysis |
| Accessibility label claim | All common tasks work with that feature on the declared device; publish only evidence-backed labels |
| External purchase/link entitlement | Confirm current storefront, category, entitlement, disclosure, commission/reporting, and guideline requirements before implementation |

Primary starting points: [App Review Guidelines](https://developer.apple.com/app-store/review/guidelines/), [Third-party SDK requirements](https://developer.apple.com/support/third-party-SDK-requirements/), [Account deletion](https://developer.apple.com/support/offering-account-deletion-in-your-app), [Export compliance](https://developer.apple.com/help/app-store-connect/manage-app-information/overview-of-export-compliance), [DSA](https://developer.apple.com/help/app-store-connect/manage-compliance-information/manage-european-union-digital-services-act-trader-requirements/).
