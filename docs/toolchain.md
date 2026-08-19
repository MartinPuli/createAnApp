# Apple agent toolchain

## Tool priority

1. Use purpose-built Apple/Xcode tools when available.
2. Use XcodeBuildMCP or its CLI for discovery, simulator build/test/run, UI automation, logs, screenshots, and device workflows.
3. Use native `xcodebuild`, `simctl`, `xcresulttool`, `plutil`, `codesign`, and `security` for gaps and independent verification.
4. Use App Store Connect API or supported delivery tools for repeatable metadata/build operations.
5. Use browser/computer control only where no supported API exists, preserving human attestations and confirmation steps.

## XcodeBuildMCP

Current upstream installation options include Homebrew and npm. Verify current requirements and tool names from the upstream repository before use.

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
      "args": ["-y", "xcodebuildmcp@latest", "mcp"]
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

## Concurrency rule

Avoid multiple build agents writing to the same DerivedData, simulator, app container, or archive path. Allocate unique DerivedData/test-product paths and simulator devices, or serialize build/test work.

## Secrets and authority

- Prefer short-lived, least-privilege App Store Connect API keys.
- Store keys in a secrets manager or protected keychain, never source control.
- Never print private keys or session cookies in logs.
- Do not automate MFA circumvention.
- Do not accept agreements or sign legal/tax/banking attestations as the human.
- Review telemetry behavior of development tools; XcodeBuildMCP documents internal runtime-error telemetry and opt-out controls.
