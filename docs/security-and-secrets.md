# Security, privacy, and secret handling

## Repository secret boundary

Never commit:

- passwords, MFA or recovery codes;
- Apple session cookies;
- `.p8`, `.p12`, provisioning profiles, signing certificates, private keys;
- App Store Connect API key material;
- service-account credentials or cloud API tokens;
- bank, tax, identity-document, or full home-address data;
- production customer data or unredacted support exports;
- `.env` files with real values.

Commit `.env.example` using placeholders only. Rotate a credential immediately if it appears in a command, screenshot, log, issue, commit, or chat that could be exposed.

## Feature-triggered re-audit

Re-open privacy/security/compliance gates when adding:

- analytics, ads, attribution, crash, session-replay, or social SDKs;
- accounts, authentication, cloud sync, backup, exports, sharing, or public links;
- AI APIs or model training/evaluation using user content;
- camera, photos, microphone, contacts, location, health, financial, child, or biometric data;
- user-generated content, comments, feeds, marketplaces, messaging, or creator payouts;
- remote configuration, downloaded code/content, or server-driven functionality;
- new territories, age groups, or regulated claims.

## Minimum release security review

1. Inventory dependencies, SDKs, entitlements, URL schemes, permissions, domains, and network endpoints.
2. Map data at rest and in transit, including third parties.
3. Verify least privilege, local protection, TLS, authentication, authorization, retention, deletion, and backup behavior.
4. Search source, build logs, archives, and repository history for secrets.
5. Verify privacy manifest and required-reason APIs.
6. Test abuse cases, malformed imports, oversized files, offline failures, revoked purchases, and account deletion where relevant.
7. Prepare vulnerability intake, incident ownership, dependency updates, and release rollback.

An App Store approval is not a security audit.
