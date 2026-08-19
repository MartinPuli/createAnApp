---
name: app-market-discovery
description: Discover, research, compare, and rank possible markets and product ideas for an Apple app before a specific idea has been chosen. Use when the user asks what app to build, wants the best market or niche, requests broad opportunity research, needs multiple unrelated candidates compared, or wants an evidence-based Apple-native business idea. Do not use when the user already has an idea and only wants it validated.
---

# App Market Discovery

Search broadly enough to avoid anchoring on the first plausible idea. Deliver ranked opportunity hypotheses for later validation; do not call them validated.

## Define the search mandate

Record:

- target Apple platforms, devices, territories, and languages;
- consumer, prosumer, or business preference;
- budget, deadline, team, and desired operator autonomy;
- acceptable acquisition and monetization models;
- whether interviews, sales, regulated review, moderation, physical service, or marketplaces are allowed;
- capabilities or risks the user explicitly excludes.

If constraints are missing, make reversible assumptions and label them. Do not narrow the world to categories already mentioned in the conversation.

## Build a diverse opportunity universe

Generate candidates across unrelated jobs and industries. Look for:

- expensive, frequent, urgent, error-prone, or emotionally important work;
- underserved workflows hidden inside generic tools, paper, spreadsheets, desktop-only software, or fragmented services;
- changes in Apple hardware, frameworks, regulation, demographics, or business behavior;
- markets with reachable buyers and observable purchase intent;
- jobs where camera, microphone, location, offline work, Pencil, sensors, Shortcuts/App Intents, on-device processing, or Apple ecosystem continuity materially improve the outcome.

Exclude obvious clones, generic AI wrappers, repackaged websites, speculative network-effect markets without a liquidity plan, and ideas whose service burden violates the mandate.

## Research the market landscape

Use current direct evidence:

- App Store queries by territory, ratings, review recency, screenshots, pricing, IAP/subscriptions, and update cadence;
- competitor sites, help centers, changelogs, public pricing, and positioning;
- search demand, forums, professional communities, complaints, procurement pages, and job posts;
- credible industry, demographic, and platform sources;
- current Apple features that create, commoditize, or eliminate an advantage;
- distribution channels where the buyer can actually be reached.

Save the date, query, source URL, observation, and inference separately. Ratings do not prove revenue; market size does not prove reachability.

## Rank without pretending certainty

Score 0–10 with explicit weights:

| Criterion | Suggested weight |
|---|---:|
| Pain, urgency, or measurable ROI | 20% |
| Willingness-to-pay evidence | 15% |
| Reachable distribution | 15% |
| Recurrence and retention | 10% |
| Competitive opening | 10% |
| Apple-native advantage | 10% |
| Build and operating feasibility | 10% |
| Platform/regulatory risk | 5% |
| Expansion or defensibility | 5% |

For every finalist, search specifically for the strongest reason not to build it: dominant/free substitutes, recent entrants, platform bundling, low frequency, high CAC, weak switching incentive, moderation, liability, regulated claims, or costly human operations. Re-score after the adversarial pass.

## Hand off to validation

Return:

- broad candidate matrix and source ledger;
- top three opportunities with distinct users/jobs;
- chosen recommendation only when requested;
- current alternatives, native advantage, monetization and distribution hypotheses;
- strongest falsifiers and unanswered questions;
- a clear statement that discovery has ranked ideas but has not validated demand or market fit.

Invoke `$app-idea-validator` next for the selected idea. Do not run behavioral experiments or silently begin development inside this skill.

Read `references/opportunity-map.md` for the output structure.
