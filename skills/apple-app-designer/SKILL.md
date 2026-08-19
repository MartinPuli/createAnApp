---
name: apple-app-designer
description: Design and visually audit adaptive, accessible Apple app experiences across supported devices. Use for SwiftUI screen architecture, iPhone/iPad responsive layouts, navigation, paywalls, empty/loading/error states, Dynamic Type, VoiceOver, Apple Pencil or keyboard support, App Store screenshots, or when App Review reports a crowded, clipped, confusing, or low-quality interface.
---

# Apple App Designer

Design for tasks and size classes, not a single simulator screenshot. Functional UI automation does not prove visual quality.

## Establish the device contract

Read the actual build settings and record supported families, minimum OS, orientations, multitasking/window behavior, pointer/keyboard/Pencil input, and accessibility targets. Never assume iPhone support because the project says iOS; verify `TARGETED_DEVICE_FAMILY` and archive metadata.

If a family is supported, it must receive a deliberately usable experience. If it is not part of the product, exclude it rather than shipping an accidental layout.

Read `references/apple-measurements.md` when defining control/text/icon dimensions or exporting App Store screenshots and previews. Re-check the linked live specifications before final export.

## Design the information architecture

1. Center each screen on one primary task.
2. Keep primary content dominant; move secondary inspectors to sheets, popovers, split-view detail, or navigation destinations as width changes.
3. Define compact and regular-width behavior explicitly.
4. Specify empty, first-run, loading, error, offline, permission-denied, destructive, and success states.
5. Keep settings, privacy, support, Terms, purchase, and restore reachable.

## Prevent crowded layouts

- Set meaningful minimum widths and breakpoints.
- Do not compress dense controls until labels wrap one character per line.
- Replace horizontal segmented controls when localization or Dynamic Type cannot fit.
- Avoid fixed frames based on one device.
- Test long localized strings and larger accessibility text.
- Preserve touch targets, focus order, contrast, and keyboard avoidance.
- Verify sheets and popovers in every declared orientation and window size.

## Design commerce honestly

Before purchase, show the product, duration, full price, renewal behavior, entitlement, restore action, Terms, Privacy, close path, and any trial exactly as configured. Do not preselect or visually conceal material terms. Paid value must remain understandable when StoreKit pricing is unavailable.

## Run a visual QA matrix

For each supported family, capture:

- smallest and largest relevant screen;
- portrait and landscape if declared;
- compact and regular widths, including iPad multitasking/windowing;
- default and largest supported Dynamic Type;
- light/dark mode if supported;
- long strings/localizations;
- VoiceOver focus order and labels;
- keyboard/pointer/Pencil paths where relevant;
- every primary task and all failure states.

Compare screenshots side by side. Flag clipped text, truncation that hides meaning, overlapping controls, excessive density, unreachable actions, ambiguous hierarchy, and mismatch between marketing screenshots and build.

## Prepare App Store visual assets

Use the exact release candidate and real UI. Marketing artwork may add accurate captions but must not invent screens, device capabilities, customers, results, prices, or features. Capture required highest-resolution supported display classes and validate current Apple pixel specifications immediately before upload.

## Deliverables

Produce screen/state inventory, breakpoint rules, reusable components/tokens, accessibility annotations, paywall spec, visual QA matrix, screenshot storyboard, media validation record, and prioritized findings with device-specific evidence. Read `references/visual-qa.md` for the review checklist.
