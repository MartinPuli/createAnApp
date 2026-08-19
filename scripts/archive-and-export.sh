#!/usr/bin/env bash
set -euo pipefail

PROJECT=""
WORKSPACE=""
SCHEME=""
TEAM=""
OUT=""

usage() {
  echo "usage: $0 (--project PATH | --workspace PATH) --scheme NAME --team TEAMID --out DIR" >&2
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --project) PROJECT="$2"; shift 2 ;;
    --workspace) WORKSPACE="$2"; shift 2 ;;
    --scheme) SCHEME="$2"; shift 2 ;;
    --team) TEAM="$2"; shift 2 ;;
    --out) OUT="$2"; shift 2 ;;
    --help|-h) usage; exit 0 ;;
    *) echo "unknown argument: $1" >&2; usage; exit 2 ;;
  esac
done

if [[ -n "$PROJECT" && -n "$WORKSPACE" ]]; then
  echo "choose either --project or --workspace" >&2
  exit 2
fi
if [[ -z "$PROJECT" && -z "$WORKSPACE" ]] || [[ -z "$SCHEME" || -z "$TEAM" || -z "$OUT" ]]; then
  usage
  exit 2
fi

if [[ -n "$PROJECT" ]]; then
  [[ -e "$PROJECT" ]] || { echo "project not found: $PROJECT" >&2; exit 2; }
  CONTAINER=(-project "$PROJECT")
else
  [[ -e "$WORKSPACE" ]] || { echo "workspace not found: $WORKSPACE" >&2; exit 2; }
  CONTAINER=(-workspace "$WORKSPACE")
fi

mkdir -p "$OUT/export"
ARCHIVE="$OUT/$SCHEME.xcarchive"
EXPORT_PLIST="$OUT/ExportOptions.plist"

xcodebuild archive \
  "${CONTAINER[@]}" \
  -scheme "$SCHEME" \
  -configuration Release \
  -destination 'generic/platform=iOS' \
  -archivePath "$ARCHIVE" \
  -allowProvisioningUpdates

[[ -d "$ARCHIVE" ]] || { echo "archive was not created: $ARCHIVE" >&2; exit 1; }
[[ -f "$ARCHIVE/Info.plist" ]] || { echo "archive metadata is missing" >&2; exit 1; }
/usr/libexec/PlistBuddy -c 'Print :ApplicationProperties' "$ARCHIVE/Info.plist" >/dev/null

cat > "$EXPORT_PLIST" <<PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>method</key><string>app-store-connect</string>
  <key>teamID</key><string>${TEAM}</string>
  <key>signingStyle</key><string>automatic</string>
  <key>uploadSymbols</key><true/>
</dict>
</plist>
PLIST

xcodebuild -exportArchive \
  -archivePath "$ARCHIVE" \
  -exportOptionsPlist "$EXPORT_PLIST" \
  -exportPath "$OUT/export" \
  -allowProvisioningUpdates

shopt -s nullglob
ipas=("$OUT/export"/*.ipa)
shopt -u nullglob
[[ "${#ipas[@]}" = 1 ]] || { echo "expected one IPA in $OUT/export; found ${#ipas[@]}" >&2; exit 1; }
printf '%s\n' "${ipas[0]}"
