# App Store Connect field guide

## Account prerequisites

- Active Apple Developer Program membership.
- Latest required agreements accepted by the Account Holder.
- Paid Apps agreement active before paid apps or IAP/subscriptions can generate proceeds.
- Banking and tax forms active for intended territories and currencies.
- DSA trader/non-trader declaration completed truthfully for EU distribution.
- Correct App Store Connect role for the task.

Do not store screenshots containing addresses, bank identifiers, tax IDs, or private contact details in a public repository.

## App record

| Field | Rule |
|---|---|
| Platforms | Select only platforms the product will support and test |
| Name | Validate availability and trademarks; localize deliberately |
| Primary language | Match first complete metadata localization |
| Bundle ID | Must match the signed binary exactly; hard to change later |
| SKU | Stable internal identifier; not customer-facing |
| User access | Least privilege consistent with the team |

An app record must exist before uploading a build. The Account Holder must have signed the latest agreement before a new record can be created.

## Version metadata

- App name and subtitle.
- Description with only shipping capabilities.
- Promotional text.
- Keywords without competitor brands or unsupported claims.
- Primary and secondary categories.
- Copyright owner.
- Support URL with a working contact path.
- Marketing URL if used.
- Privacy Policy URL, required for all apps.
- Terms of Use link when using subscriptions; use the standard Apple EULA URL in the description or configure a custom EULA.
- Screenshots for every required supported device class.
- Age rating questionnaire.
- App privacy answers derived from the exact binary and third parties.
- Export compliance answers derived from actual encryption behavior.
- Content rights declaration.
- Advertising identifier declaration where relevant.

## Build and review information

- Marketing version and unique build number.
- Correct signed archive and distribution profile.
- Build processing completed and export compliance resolved.
- Review contact monitored during review.
- Demo account or deterministic demo mode for gated functionality.
- Notes that list exact setup and test steps, paywall path, purchase/restore path, special hardware, and non-obvious behavior.
- Attachments that help reproduce without substituting for accessible functionality.

## Subscription/IAP record

For each product, verify reference name, immutable product ID, type/duration, localization, price, availability, tax category, review screenshot, review notes, entitlement mapping, and App Store Server/StoreKit behavior.

For a first auto-renewable subscription:

1. Create the subscription group.
2. Create and fully configure at least one subscription in it.
3. Add the subscription for review.
4. Add the unapproved group and a new app version to the same submission.
5. Confirm the submission modal contains the app version, group, and product(s).

If the app version is rejected, associated first-time products may be returned. Fix the app, re-add the complete set, and verify each status before resubmitting.

## Screenshot troubleshooting

Apple accepts one to ten screenshots per supported display in JPEG/JPG/PNG. If uploads remain processing unusually long:

1. Save other metadata.
2. Open Media Manager and identify the stuck display/localization.
3. Delete stuck assets.
4. Re-export RGB images at an accepted exact pixel size with no alpha surprises.
5. Upload one or two files, wait for thumbnails, and save.
6. Add the remaining batch only after processing succeeds.
7. Re-open the version and confirm no hidden device/localization well is still processing.

## Submission preflight

- Every required field is saved, not merely entered.
- Every URL returns a public success page without login.
- Screenshot content matches the selected build.
- Privacy, terms, support, pricing, and entitlements agree across app, website, and metadata.
- The intended build is selected.
- IAP/subscription dependency items are included.
- Review credentials and instructions work from a clean device.
- Release mode is intentional: manual, automatic, or phased.
- A rollback/support owner is available.
