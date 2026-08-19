---
name: app-compliance-auditor
description: Audit an app, website, metadata, SDKs, and marketing for privacy, security, AI transparency, consumer claims, subscriptions, content rights, user-generated content, children, health, financial, export, and platform-policy risks. Use before TestFlight, submission, release, paid marketing, or after adding tracking, cloud, AI, accounts, uploads, sharing, or regulated features.
---

# App Compliance Auditor

Produce a fact-based risk register and remediation plan. Do not present the result as legal advice or universal compliance; identify jurisdiction and counsel/professional handoffs.

## Establish scope and facts

Inspect the exact source, binary/archive, dependencies, privacy manifest, entitlements, permissions, network traffic/endpoints, backend, website forms/cookies, App Store labels, policies, paywall, emails, ads, social assets, and review metadata.

Create one data map for app, SDKs, backend, vendors, and website. “Processed on device” and “collected by the developer or third party” are different; verify actual transmission.

## Reconcile privacy

For every data type, map purpose, collection, sharing, tracking, linkage, storage, retention, deletion, security, permission, processor, and disclosure. Require agreement among source/binary behavior, manifest, consent UI, website, privacy policy, App Store privacy answers, and vendor contracts.

Adding analytics, ads, attribution, crash reporting, session replay, pixels, social SDKs, cloud sync, or AI APIs invalidates prior “data not collected” conclusions until re-audited.

Read `references/trigger-map.md` whenever the product adds a material data, AI, account, upload, sharing, content, territory, or regulated-domain capability.
Read `references/conditional-requirements.md` to map product triggers to Apple-facing controls before assigning a release verdict.

## Audit AI truth

- State whether AI is a product feature, internal development aid, or marketing-production aid.
- Disclose material AI interactions where omission would mislead users.
- Do not call synthetic people, voices, customer work, testimonials, reviews, experts, or outcomes real.
- Obtain likeness/voice rights and label synthetic demonstrations appropriately.
- Do not send user content to an AI provider without a defined feature, lawful basis/consent where required, updated policy/labels, vendor review, retention controls, and deletion path.
- Substantiate performance/safety claims independently of generated copy.

## Audit commerce and claims

Verify price, period, renewal, trial, cancellation, restore, entitlement, Terms, Privacy, and continuing subscription value across app, metadata, website, and ads. Flag dark patterns, fake urgency, omitted material terms, fabricated scarcity, and unsupported savings, accuracy, health, safety, legal, financial, compatibility, or outcome claims.

## Audit content and IP

Maintain provenance for code, models, datasets, fonts, icons, music, footage, patterns, screenshots, user examples, brand names, and AI-generated assets: creator, date, source, license/permission, restrictions, people/brands, AI assistance, and approval.

Local user-selected files do not automatically make the operator a public UGC host. Cloud uploads, public galleries, shared links, comments, feeds, messaging, or marketplaces trigger stronger moderation, reporting, blocking, takedown, repeat-infringer, contact, retention, and possibly DMCA-agent analysis.

## Audit security and safety

Read `../../docs/security-and-secrets.md` when available. Check secrets, dependency provenance, least privilege, authentication/authorization, data protection, abuse, malformed/oversized imports, incident response, vulnerability intake, and rollback. For medical, legal, financial, child, physical-safety, or high-impact features, require qualified review, constrained claims, emergency/escalation behavior, and territory analysis.

## Classify findings

- `STOP-SHIP`: likely illegality, material deception, severe security/safety exposure, missing rights, or platform-blocking mismatch.
- `HIGH`: fix before submission or marketing.
- `MEDIUM`: time-bound remediation with owner.
- `LOW`: hardening or documentation.
- `TRIGGERED`: currently inapplicable but becomes required after a named feature/change.

For each finding include evidence, affected surface, plausible harm, current source/rule, remediation, owner, verification, and re-audit trigger. Separate required action from prudent recommendation and legal uncertainty.

## Deliverables

Produce scope, data/SDK map, claim register, asset provenance gaps, subscription audit, conditional-requirement matrix, policy/label reconciliation, security findings, jurisdiction questions, human/counsel handoffs, and a release verdict. Read `references/audit-matrix.md` for the minimum table.
