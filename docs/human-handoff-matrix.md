# Human handoff matrix

| Task | Agent may prepare | Human must do or attest |
|---|---|---|
| Apple Developer enrollment | Checklist and field guidance | Identity, organization authority, payment, agreements |
| Certificates and signing | Diagnose settings and automate builds | Approve account access/MFA; protect private keys |
| App Store Connect app record | Prepare exact values; use authorized API | Confirm name, SKU, access, irreversible changes |
| Developer name | Explain individual/organization behavior and prepare evidence | Organization chooses registered trade name on its first app record; individual accepts legal-name display |
| Paid Apps agreement | Explain workflow | Accept contract as authorized party |
| Banking and tax | Validate format without retaining secrets | Enter truthful banking/tax data and sign forms |
| DSA trader status | Explain consequences and evidence | Choose truthfully and provide verified public contact data |
| DAC7/territory compliance | Identify trigger and required fields | Make tax/legal classification and submit truthful regulated information |
| Export compliance | Map technical encryption behavior | Make the legal attestation or obtain counsel |
| Privacy/terms | Draft from actual data map | Approve operator identity, jurisdiction, legal position |
| Medical/legal/financial content | Build review packet and version record | Qualified professional approves exact content and scope |
| Trademark | Search public databases and assemble evidence | Decide filing strategy and make legal declarations |
| App submission | Complete dossier and preflight | Final submit if no authorized automation exists |
| Release | Recommend manual/automatic/phased release | Authorize irreversible public release and spend |
| Ads/social accounts | Produce creative and setup instructions | Payment, identity, MFA, platform attestations |
| Customer/community contact | Draft personalized messages | Review and send where automation would be spam or deceptive |

## Handoff format

Every handoff must state:

1. exact screen or system;
2. exact values that are known;
3. fields the agent cannot truthfully decide;
4. privacy warning for sensitive values;
5. what screenshot or status proves completion;
6. the next automated step after the human finishes.

Never ask the human to paste passwords, MFA codes, bank account numbers, tax IDs, private keys, or full identity documents into a chat or repository.

## What Apple completes versus what the operator completes

Apple processes uploaded builds, hosts App Store product pages and StoreKit transactions, performs Beta App Review/App Review, calculates storefront pricing from the chosen base price, generates the public privacy/age/accessibility presentation from submitted answers, distributes approved versions, and reports platform analytics and proceeds.

Apple does **not** choose the product idea, validate demand, establish trademark/content rights, decide legal or trader status, write truthful policies, map SDK behavior, test the app, produce review access, configure products correctly, warrant claims, operate moderation/support, authorize release, acquire users, or determine product-market fit. The developer/operator remains responsible for those outcomes and for the code and SDKs included in the binary.
