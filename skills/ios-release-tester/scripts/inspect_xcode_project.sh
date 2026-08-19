#!/usr/bin/env bash
set -euo pipefail

project_root="${1:-.}"

if [[ ! -d "$project_root" ]]; then
  echo "error: project root does not exist: $project_root" >&2
  exit 2
fi

cd "$project_root"

echo "== Apple project inventory =="
find . -maxdepth 3 \( -name '*.xcodeproj' -o -name '*.xcworkspace' -o -name 'Package.swift' -o -name 'project.yml' \) -print | sort

echo
echo "== Release-relevant settings found in text files =="
rg -n --hidden --glob '!**/.git/**' --glob '*.{pbxproj,yml,yaml,xcconfig,plist}' \
  'PRODUCT_BUNDLE_IDENTIFIER|MARKETING_VERSION|CURRENT_PROJECT_VERSION|IPHONEOS_DEPLOYMENT_TARGET|TARGETED_DEVICE_FAMILY|CODE_SIGN_STYLE|DEVELOPMENT_TEAM|INFOPLIST_KEY_CFBundleDisplayName' . \
  | sed -E 's/(DEVELOPMENT_TEAM[^A-Z0-9]+)[A-Z0-9]+/\1<redacted>/' || true

echo
echo "== Privacy, StoreKit, entitlements, and tests =="
find . -type d \( -name .git -o -name .derivedData -o -name DerivedData -o -name build \) -prune -o \
  -type f \( -name 'PrivacyInfo.xcprivacy' -o -name '*.storekit' -o -name '*.entitlements' -o -name '*Tests.swift' \) -print | sort

echo
echo "== Dependency manifests =="
find . -maxdepth 4 -type f \( -name 'Package.resolved' -o -name 'Podfile*' -o -name 'Cartfile*' \) -print | sort

echo
echo "== Potential placeholders =="
marker_pattern='TO''DO|FIX''ME|place''holder|example\.com|YOUR_[A-Z_]+|REPLACE''_ME'
rg -n --hidden --glob '!**/.git/**' --glob '*.{swift,plist,yml,yaml,md}' "$marker_pattern" . || true

echo
echo "Inventory only. Inspect build settings from the resolved Release scheme and archive before deciding readiness."
