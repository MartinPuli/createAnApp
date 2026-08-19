#!/usr/bin/env bash
# Archive an iOS app, export a signed App Store IPA, and optionally upload it.
#
# Battle-tested flow: `xcodebuild -exportArchive` with automatic signing and the
# already-authenticated Xcode session, so no credentials pass through the agent.
# Export (reviewable IPA on disk) and upload are separate on purpose — run
# verify-ipa.sh between them.
#
# Usage:
#   scripts/archive-and-upload.sh --project ios/MyApp.xcodeproj --scheme MyApp \
#       --team TEAMID1234 --out /tmp/release [--upload]
set -euo pipefail

PROJECT="" SCHEME="" TEAM="" OUT="" UPLOAD=0
while [[ $# -gt 0 ]]; do case "$1" in
  --project) PROJECT="$2"; shift 2;;
  --scheme)  SCHEME="$2";  shift 2;;
  --team)    TEAM="$2";    shift 2;;
  --out)     OUT="$2";     shift 2;;
  --upload)  UPLOAD=1;     shift;;
  *) echo "unknown arg: $1" >&2; exit 2;;
esac; done
[[ -n "$PROJECT" && -n "$SCHEME" && -n "$TEAM" && -n "$OUT" ]] || {
  echo "required: --project --scheme --team --out" >&2; exit 2; }

mkdir -p "$OUT"
ARCHIVE="$OUT/$SCHEME.xcarchive"

xcodebuild archive \
  -project "$PROJECT" -scheme "$SCHEME" -configuration Release \
  -destination 'generic/platform=iOS' \
  -archivePath "$ARCHIVE" -allowProvisioningUpdates

/usr/libexec/PlistBuddy -c "Print :ApplicationProperties" "$ARCHIVE/Info.plist"

DEST="export"; [[ $UPLOAD -eq 1 ]] && DEST="upload"
cat > "$OUT/ExportOptions.plist" <<PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>method</key>        <string>app-store-connect</string>
    <key>teamID</key>        <string>$TEAM</string>
    <key>uploadSymbols</key> <true/>
    <key>signingStyle</key>  <string>automatic</string>
    <key>destination</key>   <string>$DEST</string>
</dict>
</plist>
PLIST

xcodebuild -exportArchive \
  -archivePath "$ARCHIVE" \
  -exportOptionsPlist "$OUT/ExportOptions.plist" \
  -exportPath "$OUT/$DEST" -allowProvisioningUpdates

if [[ $UPLOAD -eq 1 ]]; then
  echo "UPLOADED — poll processing state with asc-release.py"
else
  echo "EXPORTED — run scripts/verify-ipa.sh on $OUT/$DEST/*.ipa before uploading"
fi
