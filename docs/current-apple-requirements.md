# Current Apple submission baseline

Verified against Apple primary sources on 2026-08-19. Treat this as a dated baseline, not a permanent rulebook. Re-open every linked source immediately before uploading or submitting.

## 1. Account and business prerequisites

- Maintain an active Apple Developer Program membership.
- Ensure the Account Holder has accepted the latest required agreement; an app record cannot be created until this is done.
- Activate the Paid Apps Agreement and complete truthful banking and tax information before selling an app or offering IAP/subscriptions.
- Assign the minimum App Store Connect role needed for each task.
- Declare EU Digital Services Act trader status even when not distributing in the EU. Traders distributing in the EU must provide verified public contact information; Apple cannot decide trader status for the developer.
- Revisit territory-specific obligations such as DAC7, regulated-medical-device declarations, permits, labels, and markings when the product or distribution footprint triggers them.

Sources: [App Store Connect workflow](https://developer.apple.com/help/app-store-connect/get-started/app-store-connect-workflow), [Add a new app](https://developer.apple.com/help/app-store-connect/create-an-app-record/add-a-new-app/), [DSA trader requirements](https://developer.apple.com/help/app-store-connect/manage-compliance-information/manage-european-union-digital-services-act-trader-requirements/).

## 2. App identity and signing

Create the App Store Connect record before uploading a build. Freeze and reconcile:

| Element | Operational rule |
|---|---|
| App name | 2–30 characters per localization; check availability and rights |
| Subtitle | Maximum 30 characters |
| Bundle ID | Must match the explicit App ID, signed build, and app record; cannot be changed after a build upload |
| SKU | Internal and immutable after record creation |
| Version | Customer-facing marketing version |
| Build string | Unique within the version and used with bundle ID/version to identify the build |
| Capabilities | Enable only what the app uses and reconcile portal, entitlements, profile, and archive |
| Signing | Use automatic signing or a valid distribution certificate and App Store Connect provisioning profile |

Sources: [App information](https://developer.apple.com/help/app-store-connect/reference/app-information/app-information), [App Store Connect provisioning profile](https://developer.apple.com/help/account/provisioning-profiles/create-an-app-store-provisioning-profile/).

## 3. Build and upload baseline

- Since April 28, 2026, uploaded apps must be built with Xcode 26 or later using the corresponding 26-series SDK for the target platform.
- Build the exact Release configuration; do not infer archive behavior from Debug.
- Validate the archive, signing, entitlements, privacy manifests, supported device families, minimum OS, architectures, and required capabilities.
- Upload with Xcode, Transporter, or a supported App Store Connect API/CLI path, then wait for processing and resolve warnings, export compliance, and build metadata.
- iOS/iPadOS apps may have an uncompressed app size up to 4 GB and a 500 MB executable `__TEXT` limit for modern deployment targets; smaller limits and App Clip limits apply in specific cases.

Sources: [Upcoming requirements](https://developer.apple.com/news/upcoming-requirements/), [Upload builds](https://developer.apple.com/help/app-store-connect/manage-builds/upload-builds), [View build metadata](https://developer.apple.com/help/app-store-connect/manage-builds/view-builds-and-metadata/), [Maximum build sizes](https://developer.apple.com/help/app-store-connect/reference/app-uploads/maximum-build-file-sizes).

## 4. Version metadata

| Field | Current requirement |
|---|---|
| Name | Required; 2–30 characters |
| Subtitle | Optional; maximum 30 characters |
| Promotional text | Optional; maximum 170 characters; can be updated without a new binary |
| Description | Required; plain text; maximum 4,000 characters; describe only shipping functionality |
| Keywords | Required; maximum 100 bytes; each keyword over two characters; no competitor/app/company names |
| Screenshots | Required; 1–10 per supported display/localization |
| App previews | Optional; up to 3 per device size and localization |
| Support URL | Required and must expose a real contact path |
| Privacy policy | Required for every app; URL for iOS/macOS, policy text for tvOS |
| Terms/EULA | Required in-app for subscription terms; include the standard EULA link in the description or configure a custom EULA when applicable |
| Age rating | Required; an Unrated app cannot be published |
| App privacy | Required and must include integrated third-party partners |
| Review information | Contact, accessible test path, demo credentials/mode, setup, notes, and attachments when needed |
| Release method | Manual, automatic, or automatic no earlier than a chosen date |

Sources: [Platform version information](https://developer.apple.com/help/app-store-connect/reference/app-information/platform-version-information), [App privacy](https://developer.apple.com/help/app-store-connect/manage-app-information/manage-app-privacy), [Age rating](https://developer.apple.com/help/app-store-connect/manage-app-information/set-an-app-age-rating/).

## 5. Privacy and SDK supply chain

- Maintain a data map covering app code, every SDK, backend, website, analytics, ads, AI providers, and other processors.
- Keep App Store privacy answers inclusive across all supported platforms and update them whenever practices change.
- Include a valid `PrivacyInfo.xcprivacy` where required. Declare collected data, tracking domains, and every required-reason API with an approved reason matching actual use.
- App Store Connect rejects invalid privacy manifests and submissions that omit required reasons.
- Listed commonly used SDKs require privacy manifests; binary distributions of listed SDKs also require signatures. The developer remains responsible for SDK behavior.
- Ask only for permissions essential to the current feature, at the point of need, with accurate purpose strings and a usable denial path.

Sources: [Privacy manifests](https://developer.apple.com/documentation/bundleresources/privacy-manifest-files), [Required-reason APIs](https://developer.apple.com/documentation/bundleresources/describing-use-of-required-reason-api), [Third-party SDK requirements](https://developer.apple.com/support/third-party-SDK-requirements/), [App Privacy Details](https://developer.apple.com/app-store/app-privacy-details/).

## 6. Accounts, login, and user content

- Do not require login when significant account-based functionality is absent.
- If account creation exists, let the user initiate deletion of the entire account from inside the app; a deactivation-only flow is insufficient.
- If a third-party/social login establishes the primary account, also provide an equivalent privacy-preserving login option unless a documented guideline exception applies.
- Apps with public user-generated content must filter objectionable material, provide reporting and timely response, let users block abusive users, and publish contact information.
- User uploads trigger file security, rights, privacy, retention, and deletion analysis even when content is not public.

Sources: [Offering account deletion](https://developer.apple.com/support/offering-account-deletion-in-your-app), [App Review Guidelines 1.2, 4.8, and 5.1.1](https://developer.apple.com/app-store/review/guidelines/).

## 7. Accessibility and interface quality

- Design and test every common task—including onboarding, login, purchase, and settings—on every supported device family.
- iOS/iPadOS controls should normally provide a 44×44 pt target; Apple's listed minimum control size is 28×28 pt. Comfortable spacing remains necessary.
- iOS/iPadOS default body text is 17 pt and Apple's listed minimum is 11 pt; support Dynamic Type and verify accessibility sizes.
- Audit VoiceOver, Voice Control, Larger Text, Dark Interface, sufficient contrast, reduced motion, captions/audio descriptions where applicable, and differentiation without color alone.
- Accessibility Nutrition Labels are currently voluntary but visible on devices running OS 26 or later, must be truthful for all common tasks on each declared device, and are expected to become mandatory over time.

Sources: [Accessibility HIG](https://developer.apple.com/design/human-interface-guidelines/accessibility), [Typography HIG](https://developer.apple.com/design/human-interface-guidelines/typography), [Accessibility Nutrition Labels](https://developer.apple.com/help/app-store-connect/manage-app-accessibility/overview-of-accessibility-nutrition-labels).

## 8. TestFlight and release evidence

- Provide beta description, what-to-test instructions, and feedback contact.
- A build is testable for up to 90 days.
- Internal testing supports up to 100 eligible App Store Connect users.
- External testing supports up to 10,000 testers and the first build in a group requires Beta App Review; later builds may also be reviewed.
- Test clean install, upgrade/migration, minimum OS, supported devices, production backend, permissions, account deletion, offline/error states, StoreKit, restore, and support/legal URLs.
- Do not equate local StoreKit configuration, simulator success, or internal TestFlight with real external behavior.

Source: [TestFlight overview](https://developer.apple.com/help/app-store-connect/test-a-beta-version/testflight-overview).

## 9. Commerce

- Digital goods and subscriptions generally use In-App Purchase unless a current guideline exception or entitlement applies.
- Auto-renewable subscriptions must deliver ongoing value, last at least seven days, and work across the user's devices where the app is available.
- Before purchase, clearly disclose what the user receives, price, duration, renewal, trial/offer conditions, and relevant Terms and Privacy links.
- Use catalog-derived price/period data, verify purchase, pending, cancellation, restore, expiration, refund/revocation, billing retry/grace where used, and upgrade/downgrade behavior.
- Most apps should place variations of one service in one subscription group so a user holds only one subscription from that group.
- Submit the first auto-renewable subscription and its first group with a new app version, with at least one product from the group in the same submission.

Sources: [App Review Guidelines 3.1](https://developer.apple.com/app-store/review/guidelines/), [Offer auto-renewable subscriptions](https://developer.apple.com/help/app-store-connect/manage-subscriptions/offer-auto-renewable-subscriptions/).

## 10. Review, release, and operations

- Review the complete five-part guideline set: Safety, Performance, Business, Design, and Legal.
- Completeness is the largest recurring problem category Apple identifies; remove placeholders, broken links, inaccessible features, empty catalogs, and stale review notes.
- Add the exact app version and dependent items to a draft, inspect the item set, then submit the draft for review.
- Resolve all items in a combined submission; linked IAP/subscription items can be returned when the app version is rejected.
- Choose public, private/custom, or unlisted distribution deliberately; public-to-private changes generally require a new app record.
- For updates, phased release advances 1%, 2%, 5%, 10%, 20%, 50%, and 100% over seven days and can be paused for up to 30 days.
- After release, verify the public storefront, download, purchase/restore, support, analytics, crashes, refunds, ratings/reviews, and incident rollback.

Sources: [App Review](https://developer.apple.com/app-store/review/), [Submit an app](https://developer.apple.com/help/app-store-connect/manage-submissions-to-app-review/submit-an-app/), [Distribution methods](https://developer.apple.com/help/app-store-connect/manage-your-apps-availability/set-distribution-methods), [Phased release](https://developer.apple.com/help/app-store-connect/update-your-app/release-a-version-update-in-phases).
