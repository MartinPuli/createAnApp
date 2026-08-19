#!/usr/bin/env bash
# Ship gate: verify what is actually inside an exported IPA before upload.
#
# Checks version/build, the privacy manifest, and that every required
# user-facing string made it into the binary — the control that catches a
# build cut from the wrong commit (it happened: a compliance build shipped
# without its disclosures because the archive predated them).
#
# Usage:
#   scripts/verify-ipa.sh --ipa out/export/MyApp.ipa --version 1.0.1 --build 4 \
#       --require "Apple Intelligence" --require "Study aid only"
set -euo pipefail

IPA="" WANT_V="" WANT_B=""; REQUIRED=()
while [[ $# -gt 0 ]]; do case "$1" in
  --ipa)     IPA="$2";    shift 2;;
  --version) WANT_V="$2"; shift 2;;
  --build)   WANT_B="$2"; shift 2;;
  --require) REQUIRED+=("$2"); shift 2;;
  *) echo "unknown arg: $1" >&2; exit 2;;
esac; done
[[ -f "$IPA" ]] || { echo "no IPA at $IPA" >&2; exit 2; }

D="$(mktemp -d)"; trap 'rm -rf "$D"' EXIT
unzip -q "$IPA" -d "$D"
APP="$(ls -d "$D"/Payload/*.app | head -1)"
INFO="$APP/Info.plist"
BIN="$APP/$(/usr/libexec/PlistBuddy -c 'Print :CFBundleExecutable' "$INFO")"

fail=0
V="$(/usr/libexec/PlistBuddy -c 'Print :CFBundleShortVersionString' "$INFO")"
B="$(/usr/libexec/PlistBuddy -c 'Print :CFBundleVersion' "$INFO")"
echo "version $V ($B)"
[[ -z "$WANT_V" || "$V" == "$WANT_V" ]] || { echo "FAIL: version $V != $WANT_V"; fail=1; }
[[ -z "$WANT_B" || "$B" == "$WANT_B" ]] || { echo "FAIL: build $B != $WANT_B"; fail=1; }

[[ -f "$APP/PrivacyInfo.xcprivacy" ]] \
  && echo "privacy manifest: packaged" \
  || { echo "FAIL: PrivacyInfo.xcprivacy missing"; fail=1; }

for s in "${REQUIRED[@]+"${REQUIRED[@]}"}"; do
  if strings "$BIN" | grep -q "$s"; then echo "present: \"$s\""
  else echo "FAIL: \"$s\" not in binary"; fail=1; fi
done

exit $fail
