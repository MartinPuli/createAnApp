# Apple interface and media measurements

Verified 2026-08-19. Re-check Apple's live specifications immediately before export because supported devices and accepted sizes change.

## Interface baselines

| Item | iOS/iPadOS guidance |
|---|---|
| Comfortable control target | 44×44 pt default |
| Listed minimum control size | 28×28 pt; still require sufficient spacing and successful accessibility testing |
| Default text size | 17 pt |
| Listed minimum text size | 11 pt; custom/thin fonts may require larger sizes |
| Dynamic Type | Layout must adapt through accessibility categories without hiding task-critical meaning |
| App icon source | 1024×1024 px for iOS/iPadOS; let Xcode/Icon Composer generate system variants |

Sources: [Accessibility](https://developer.apple.com/design/human-interface-guidelines/accessibility), [Typography](https://developer.apple.com/design/human-interface-guidelines/typography), [App icons](https://developer.apple.com/design/human-interface-guidelines/app-icons/).

## Required screenshot rules

- Upload 1–10 screenshots per supported display/localization.
- Use JPEG/JPG/PNG without alpha or transparency.
- The current highest-resolution iPhone well accepts these 6.9-inch portrait sizes: 1260×2736, 1290×2796, or 1320×2868 px; landscape uses the reversed dimensions.
- If no 6.9-inch assets are supplied, the 6.5-inch well is required for iPhone and accepts 1284×2778 or 1242×2688 px in portrait, reversed in landscape.
- The current 13-inch iPad well is required when the app runs on iPad and accepts 2064×2752 or 2048×2732 px in portrait, reversed in landscape.
- Mac requires 16:10 screenshots at 1280×800, 1440×900, 2560×1600, or 2880×1800 px.
- Apple TV requires 1920×1080 or 3840×2160 px.
- Apple Vision Pro requires 3840×2160 px.
- Apple Watch accepts 422×514, 410×502, 416×496, 396×484, 368×448, or 312×390 px depending on hardware; use one Watch size consistently across localizations.

Do not infer the required well from a simulator name. Read the current Media Manager slot and the live [screenshot specification](https://developer.apple.com/help/app-store-connect/reference/app-information/screenshot-specifications/) before exporting.

## App preview rules

- Optional; up to 3 per supported device size and localization.
- Duration 15–30 seconds; maximum 500 MB; maximum 30 fps.
- H.264 target bitrate 10–12 Mbps, or ProRes 422 HQ; accepted extensions depend on codec.
- iPhone 6.9-inch previews accept 886×1920 portrait or 1920×886 landscape.
- Default poster frame is at 5 seconds; verify it intentionally.
- Previews precede screenshots on the product page and may take up to 24 hours to process.

Source: [App preview specifications](https://developer.apple.com/help/app-store-connect/reference/app-information/app-preview-specifications/).

## Asset validation record

For every exported asset store: localization, device well, orientation, exact pixels, color mode, alpha status, duration/frame rate/codec for video, candidate build, capture source, claim proof, upload status, and final thumbnail proof.
