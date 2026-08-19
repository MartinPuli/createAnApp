#!/usr/bin/env bash
set -euo pipefail

IPA=""
WANT_BUNDLE=""
WANT_VERSION=""
WANT_BUILD=""
REQUIRE_PRIVACY=0
REQUIRED=()

usage() {
  echo "usage: $0 --ipa FILE [--bundle-id ID] [--version V] [--build N] [--require-privacy-manifest] [--require TEXT ...]" >&2
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --ipa) IPA="$2"; shift 2 ;;
    --bundle-id) WANT_BUNDLE="$2"; shift 2 ;;
    --version) WANT_VERSION="$2"; shift 2 ;;
    --build) WANT_BUILD="$2"; shift 2 ;;
    --require-privacy-manifest) REQUIRE_PRIVACY=1; shift ;;
    --require) REQUIRED+=("$2"); shift 2 ;;
    --help|-h) usage; exit 0 ;;
    *) echo "unknown argument: $1" >&2; usage; exit 2 ;;
  esac
done

[[ -f "$IPA" ]] || { echo "IPA not found: $IPA" >&2; exit 2; }

TEMP_DIR="$(mktemp -d)"
cleanup() { rm -rf "$TEMP_DIR"; }
trap cleanup EXIT
unzip -q "$IPA" -d "$TEMP_DIR"

shopt -s nullglob
apps=("$TEMP_DIR"/Payload/*.app)
shopt -u nullglob
[[ "${#apps[@]}" = 1 ]] || { echo "expected one top-level app; found ${#apps[@]}" >&2; exit 1; }
APP="${apps[0]}"
INFO="$APP/Info.plist"
[[ -f "$INFO" ]] || { echo "Info.plist missing" >&2; exit 1; }

BUNDLE="$(/usr/libexec/PlistBuddy -c 'Print :CFBundleIdentifier' "$INFO")"
VERSION="$(/usr/libexec/PlistBuddy -c 'Print :CFBundleShortVersionString' "$INFO")"
BUILD="$(/usr/libexec/PlistBuddy -c 'Print :CFBundleVersion' "$INFO")"
echo "bundle=$BUNDLE version=$VERSION build=$BUILD"

fail=0
[[ -z "$WANT_BUNDLE" || "$BUNDLE" = "$WANT_BUNDLE" ]] || { echo "FAIL: bundle mismatch" >&2; fail=1; }
[[ -z "$WANT_VERSION" || "$VERSION" = "$WANT_VERSION" ]] || { echo "FAIL: version mismatch" >&2; fail=1; }
[[ -z "$WANT_BUILD" || "$BUILD" = "$WANT_BUILD" ]] || { echo "FAIL: build mismatch" >&2; fail=1; }

if [[ "$REQUIRE_PRIVACY" = 1 ]] && ! find "$APP" -name PrivacyInfo.xcprivacy -type f -print -quit | grep -q .; then
  echo "FAIL: required privacy manifest missing" >&2
  fail=1
fi

for text_value in "${REQUIRED[@]}"; do
  if rg -aFq -- "$text_value" "$APP"; then
    echo "packaged text present: $text_value"
  else
    echo "FAIL: required packaged text absent: $text_value" >&2
    fail=1
  fi
done

codesign --verify --deep --strict --verbose=2 "$APP"
exit "$fail"
