#!/usr/bin/env bash
set -euo pipefail

IPA=""
KEY_ID=""
ISSUER_ID=""

usage() {
  echo "usage: $0 --ipa FILE --key-id KEY_ID --issuer-id ISSUER_ID" >&2
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --ipa) IPA="$2"; shift 2 ;;
    --key-id) KEY_ID="$2"; shift 2 ;;
    --issuer-id) ISSUER_ID="$2"; shift 2 ;;
    --help|-h) usage; exit 0 ;;
    *) echo "unknown argument: $1" >&2; usage; exit 2 ;;
  esac
done

[[ -f "$IPA" ]] || { echo "IPA not found: $IPA" >&2; exit 2; }
[[ -n "$KEY_ID" && -n "$ISSUER_ID" ]] || { usage; exit 2; }

xcrun altool --validate-app \
  --file "$IPA" \
  --type ios \
  --apiKey "$KEY_ID" \
  --apiIssuer "$ISSUER_ID"

xcrun altool --upload-app \
  --file "$IPA" \
  --type ios \
  --apiKey "$KEY_ID" \
  --apiIssuer "$ISSUER_ID"
