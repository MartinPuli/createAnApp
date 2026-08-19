# Apple agent toolchain

## Tool priority

1. Use purpose-built Apple/Xcode tools when available.
2. Use XcodeBuildMCP or its CLI for discovery, simulator build/test/run, UI automation, logs, screenshots, and device workflows.
3. Use native `xcodebuild`, `simctl`, `xcresulttool`, `plutil`, `codesign`, and `security` for gaps and independent verification.
4. Use App Store Connect API or supported delivery tools for repeatable metadata/build operations.
5. Use browser/computer control only where no supported API exists, preserving human attestations and confirmation steps.

## XcodeBuildMCP

Current upstream installation options include Homebrew and npm. Verify current requirements and tool names from the upstream repository before use. This repository's `.mcp.json` pins the npm package version researched on 2026-08-19; change that pin only after reviewing upstream source, permissions, telemetry, release notes, and the local release workflow.

```bash
brew tap getsentry/xcodebuildmcp
brew install xcodebuildmcp
xcodebuildmcp --help
xcodebuildmcp tools
```

Or allow an MCP client to launch the server:

```json
{
  "mcpServers": {
    "XcodeBuildMCP": {
      "command": "npx",
      "args": ["-y", "xcodebuildmcp@2.7.0", "mcp"]
    }
  }
}
```

Example CLI flow:

```bash
xcodebuildmcp simulator build --scheme MyApp --project-path ./MyApp.xcodeproj
xcodebuildmcp simulator build --scheme MyApp --project-path ./MyApp.xcodeproj --simulator-name "iPhone 17" --build-for-testing --test-products-path ./MyApp.xctestproducts
xcodebuildmcp simulator test --test-products-path ./MyApp.xctestproducts --simulator-name "iPhone 17"
```

Do not copy the example device name blindly. Discover installed runtimes and select devices matching the supported-device matrix.

## Independent verification

An agent-controlled simulator interaction is exploratory evidence, not a durable release test. Convert stable critical flows into XCTest/XCUITest and preserve `.xcresult` outputs. Verify archive settings and entitlements independently from the debug simulator build.

## Deterministic project generation

Generate the Xcode project from a declarative spec (e.g. XcodeGen's
`project.yml`) instead of hand-editing the pbxproj. Regenerate after **every**
spec change — version bumps included — or the build silently uses the stale
project. Put Info.plist values in the spec (`INFOPLIST_KEY_*`), including a
truthful `ITSAppUsesNonExemptEncryption`, so export compliance stops blocking
every submission with a manual question.

## Test-failure diagnostics

- **`TEST FAILED` with no failing assertion** means a test started and never
  finished. Diff the `Test Case '-… started` lines against the
  `passed/failed` lines to find which ones hung; the usual cause is a call
  that needs foreground UI (a payment sheet) running headless. Gate those
  tests behind an environment variable so they skip with a reason.
- **Simulator destinations by name drift across Xcode releases.** A device
  name that existed last month may not exist today. List available simulators
  and target by UDID, not by name.
- **A second model container in a test host can trap** when the app under test
  already created one (SwiftData/Core Data). Test the data layer at the
  serialization level (decode the bundled seed, assert its invariants) rather
  than booting a second container.
- **Debug-only launch arguments must survive state refreshes.** A flag like
  `-screenshotMode` that flips an entitlement is overwritten the next time the
  real entitlement refreshes; OR the flag back in at every refresh point, and
  compile all of it out of Release.

## Concurrency rule

Avoid multiple build agents writing to the same DerivedData, simulator, app container, or archive path. Allocate unique DerivedData/test-product paths and simulator devices, or serialize build/test work.

## Secrets and authority

- Prefer short-lived, least-privilege App Store Connect API keys.
- Store keys in a secrets manager or protected keychain, never source control.
- Never print private keys or session cookies in logs.
- Do not automate MFA circumvention.
- Do not accept agreements or sign legal/tax/banking attestations as the human.
- Review telemetry behavior of development tools; XcodeBuildMCP documents internal runtime-error telemetry and opt-out controls.
