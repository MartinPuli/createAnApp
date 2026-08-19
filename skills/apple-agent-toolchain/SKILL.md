---
name: apple-agent-toolchain
description: Configure and verify safe tooling for AI-agent Apple development and release work. Use when setting up XcodeBuildMCP, its CLI, Xcode, simulators, xcodebuild, simctl, XCTest results, App Store Connect API, Transporter, browser automation, code signing diagnostics, tool permissions, or a repeatable agent build/test/upload environment.
---

# Apple Agent Toolchain

Choose the least-privilege purpose-built tool, verify it, and preserve an independent fallback. Read `../../docs/toolchain.md` and `../../docs/security-and-secrets.md` when available.

## Discover before installing

1. Inventory macOS, Xcode/SDK, command-line tools, runtimes, simulators, package managers, existing MCP servers, App Store tooling, and authentication state without printing secrets.
2. Inspect the project type, workspace/project, schemes, packages, deployment targets, and device families.
3. Prefer an existing verified tool over cloning or installing another copy.
4. Check upstream requirements and release notes before installation.

## Configure XcodeBuildMCP

Use the upstream package from `getsentry/XcodeBuildMCP`. Prefer Homebrew or ephemeral `npx` according to environment policy. Verify `xcodebuildmcp --help` and `xcodebuildmcp tools`. Configure the MCP client using current upstream instructions; do not invent server arguments.

Use it for discovery, simulator build/test/run, UI interaction, logs, screenshots, debugging, and supported device actions. Device tools still require legitimate code signing.

Review upstream telemetry documentation and apply the project's privacy policy. Do not confuse development-tool telemetry with app telemetry, but document both.

## Maintain native fallbacks

Keep working knowledge of:

- `xcodebuild -list`, `-showBuildSettings`, `build`, `test`, `archive`, `-exportArchive`;
- `xcrun simctl` runtime/device/app/container/log/screenshot operations;
- `xcresulttool` for durable test evidence;
- `plutil`, `codesign`, and archive inspection;
- App Store Connect API/Transporter for authorized metadata and build delivery.

Never erase simulator/device/project data as a first diagnostic step. Resolve exact targets and preserve user state.

## Isolate concurrent work

Use unique DerivedData, result-bundle, archive, test-products, log, and simulator resources per active build agent. Serialize operations that share signing, the same simulator, or the same app container.

## Separate automation from authority

The agent may prepare and run authorized repeatable operations. The human must retain MFA, agreements, identity, tax/banking truth, private signing material, regulated attestations, payment authorization, and irreversible public release where required.

## Verify the setup

Prove:

1. project/scheme discovery;
2. simulator discovery and boot;
3. clean build in an isolated path;
4. one test with a preserved result bundle;
5. app install/launch and log capture;
6. screenshot capture;
7. archive/signing diagnostics without exposing secrets;
8. fallback command path.

Output a tool inventory, version/source, purpose, permissions, telemetry note, verification result, and failure recovery path.
