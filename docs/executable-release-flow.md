# Executable release flow

The scripts in this repository automate repeatable mechanics without making human attestations or silently submitting/releasing an app.

## 1. Archive and export

```bash
scripts/archive-and-export.sh \
  --project /absolute/path/App.xcodeproj \
  --scheme App \
  --team TEAMID \
  --out /absolute/path/release
```

Use `--workspace` instead of `--project` when appropriate. This creates a Release archive, checks its required archive structure and metadata, and exports an App Store Connect IPA. Apple's upload validation is then run against the exported IPA in step 3.

## 2. Verify the exact IPA

```bash
scripts/verify-ipa.sh \
  --ipa /absolute/path/release/export/App.ipa \
  --bundle-id com.example.app \
  --version 1.0 \
  --build 1 \
  --require-privacy-manifest \
  --require "Privacy"
```

Use `--require-privacy-manifest` only when the app's audited behavior requires one. `--require` searches the complete packaged app, including localized resources, rather than only the executable. Verification does not prove runtime behavior; it prevents uploading an artifact whose identity or required packaged content is already wrong.

## 3. Upload that same IPA

```bash
scripts/upload-ipa.sh \
  --ipa /absolute/path/release/export/App.ipa \
  --key-id "$ASC_KEY_ID" \
  --issuer-id "$ASC_ISSUER_ID"
```

The App Store Connect API private key must already be stored in a location supported by Apple's upload tool. Do not place it in the repository or command history. Upload is an authorized external-state change; obtain the account holder's authority before running it.

## 4. Stage the version

```bash
python3 scripts/asc-stage-version.py \
  --bundle-id com.example.app \
  --platform IOS \
  --version 1.0 \
  --build 1
```

For an update, optionally add `--notes /absolute/path/whats-new.txt`. Set `ASC_KEY_ID`, `ASC_ISSUER_ID`, and `ASC_KEY_PATH` in the process environment. The script waits for the exact marketing-version/build-number pair to become valid, creates or reuses the version, attaches the build, and optionally updates existing localization release notes. It does not submit the version, attest compliance, add first-time IAP dependency items, or release it.

## 5. Complete the dossier and submit

Run `$app-store-connect-preparer`, inspect the complete draft item set, and complete human-only declarations. Use App Store Connect or a separately reviewed API workflow to submit only after every gate passes. A first subscription/group and other dependent items may need to be included with the app version.

## Safety properties

- Export and upload are separate, so the verified IPA is the uploaded IPA.
- All paths are explicit.
- Secrets remain outside the repository.
- Staging is idempotent for an existing version/build.
- Submission and release remain explicit authority gates.
