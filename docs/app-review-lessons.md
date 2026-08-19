# Generalized App Review failure lessons

This playbook contains reusable failure patterns. It intentionally excludes product names, account identifiers, private submission data, screenshots, and niche-specific implementation details.

## Missing Terms of Use for subscriptions

**Review signal:** an app offers auto-renewable subscriptions, but App Review cannot find a functional Terms of Use (EULA) link in the metadata it reviews.

**Common root cause:** purchase code and products are functional, while the submission dossier treats legal links only as website or in-app concerns and omits the EULA from the required metadata surface.

**Recovery:** use a functional custom EULA configured in App Store Connect or include the standard Apple EULA URL in the app description. Verify the saved localization, public URL, paywall, and legal screen. Resubmit every returned dependent subscription item with the app version when required.

**Permanent control:** the metadata preflight must require a reachable Terms of Use URL whenever auto-renewable subscriptions exist.

## Crowded or broken adaptive interface

**Review signal:** the interface is crowded, clipped, difficult to understand, or prevents task completion on a supported review device.

**Common root cause:** functional automation was mistaken for visual usability. Multi-column controls collapse at narrow widths, text wraps vertically, segmented controls truncate, or a supported device family exposes an experience that was never deliberately designed.

**Recovery:** redesign compact workspaces so primary content remains usable and secondary inspectors move to sheets, popovers, or navigation destinations. Audit every supported family, size class, orientation, multitasking width, and Dynamic Type size. If a device family is not part of the product, exclude it in the build settings rather than shipping an accidental layout.

**Permanent control:** require screenshot-based visual review in addition to unit and UI automation. Verify the smallest and largest supported screens and real TestFlight hardware.

## New subscription group without a product

**Review signal:** a new subscription group cannot be submitted because no auto-renewable subscription from the group is included.

**Recovery:** fully configure at least one subscription product, add it for review, and submit the app version, unapproved group, and product together when Apple requires the first subscription to accompany a new version.

**Permanent control:** model submission items as a dependency graph and inspect the final submission modal before submitting.

## Associated commerce items returned

**Review signal:** subscriptions or IAPs are returned after the associated app version is rejected, even when the commerce configuration has no independent defect.

**Recovery:** fix and verify the app-level issue, then re-add the complete required app/group/product set. Do not repeatedly resubmit isolated returned products.

**Permanent control:** preserve the exact item set and statuses for every submission and resubmission.

## Screenshot uploads stuck in processing

**Review signal:** App Store Connect reports screenshot uploads in progress for an unusually long time and blocks Add for Review.

**Recovery:** save other metadata, inspect every device/localization in Media Manager, remove stuck assets, re-export valid RGB JPEG/PNG files at current accepted dimensions, upload one or two, wait for thumbnails, save, and only then add the remaining batch.

**Permanent control:** generate screenshots deterministically from the exact release build, validate format/dimensions before upload, and preserve upload-status evidence.

## General completion rule

A textual correction is not enough when the root cause is binary, visual, commercial, privacy-related, or dependent on submission state. Reproduce the reviewer path, apply the systemic fix, invalidate affected evidence gates, test the exact new candidate, and inspect all submitted items before resubmission.

## Additional reusable failure modes

### Empty commerce catalog

A product-catalog request can complete without throwing and still return no matching products. A safe paywall has explicit loading, loaded, and failed states; displays prices supplied by the catalog; and does not enable purchase until the intended product resolves.

### Debug and Release divergence

Configuration gates can make a feature or dataset appear in development and disappear from the archived build. Test the actual Release configuration on a clean install and add assertions for content that must ship.

### UI-bound purchase testing

Automated tests that cross into a system payment sheet may wait indefinitely without foreground interaction. Keep catalog, entitlement, and state-machine tests deterministic; exercise the system purchase sheet through an appropriate UI or sandbox flow; and record any justified test exclusion.

### Immutable store records

Treat bundle identifiers, product identifiers, and released version slots as durable records. Check availability before coupling code to an identifier, avoid create-delete experimentation in production accounts, and create a new version record when a released version can no longer accept a build.

### Submission-specific review evidence

Review notes and attachments belong to one exact submission. Rewrite them for every build, verify every referenced attachment exists, declare encryption truthfully, and ensure the review path matches the submitted binary rather than an earlier test build.
