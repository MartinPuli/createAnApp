---
name: app-idea-validator
description: Validate or falsify a specific Apple app idea that the user has already chosen. Use when an existing idea, niche, target user, or product thesis must be tested for demand, competition, willingness to pay, distribution, retention, native advantage, economics, or platform risk before development. Preserve the supplied idea as the subject of analysis; do not restart broad idea discovery unless explicitly requested.
---

# App Idea Validator

Test one supplied product hypothesis against current evidence and behavior. Separate interest, activation, payment, retention, and product-market fit. A score or favorable report is not validation.

## Freeze the hypothesis being tested

Record without silently changing it:

- target user and buyer;
- painful job and use context;
- promised outcome;
- proposed Apple device/platform advantage;
- current alternative;
- monetization and price hypothesis;
- initial territory and acquisition channel;
- user constraints and non-negotiables.

If a component is missing, state the minimum assumption needed to test it. If evidence later contradicts the idea, return a failed or conditional verdict rather than substituting another idea. Use `$app-market-discovery` only if the user asks for alternatives.

## Run desk validation

Use dated, direct evidence:

- App Store competitors/substitutes, pricing, subscriptions, ratings, review complaints, screenshots, update cadence, and territory;
- competitor websites, help centers, changelogs, and public pricing;
- search intent, forums, communities, procurement behavior, and recurring complaint language;
- credible category data and current Apple platform changes;
- reachable distribution channels and their likely economics;
- safety, privacy, moderation, regulatory, and App Review risks.

Create a source ledger distinguishing observation from inference. Search adversarially for free incumbents, platform bundling, recent entrants, low frequency, weak switching, high CAC, refund/churn risk, human-service burden, and claims liability.

## Test the business assumptions

Evaluate:

- urgency and measurable value;
- evidence of willingness to pay at the proposed price;
- why users would switch now;
- recurrence and retention mechanism;
- addressable and reachable beachhead, not only total market size;
- channel-to-price economics;
- whether Apple hardware materially improves the job;
- feasibility of delivering every promised outcome;
- risks that make the model non-operable.

Use scoring only to expose assumptions and compare the idea against its own thresholds, not to declare product-market fit.

## Design behavioral validation

Choose the smallest honest experiments that can reject the hypothesis:

- message-specific landing page with a real waitlist or beta CTA;
- App Store keyword/product-page research;
- small-budget campaign with attribution;
- task-complete functional prototype;
- limited TestFlight cohort;
- real free-to-paid behavior after value can be delivered;
- retention and renewal observation appropriate to the job frequency.

When interviews are disallowed, replace opinions with behavior. Never use fake checkout, fake scarcity, fabricated testimonials, bought reviews, or undisclosed synthetic customers. State beta/early-access status accurately.

## Precommit gates

For every experiment define metric, sample/traffic requirement, proceed threshold, stop/pivot threshold, budget cap, deadline, instrumentation, and interpretation limits. Distinguish:

- click or waitlist interest;
- completed core-job activation;
- paid conversion;
- repeated use and renewal;
- viable acquisition/contribution economics.

## Verdict

Return one of:

- `VALIDATED FOR MVP`: current evidence and precommitted validation gate passed; market fit remains unproven.
- `VALIDATE MORE`: evidence is promising but the required behavioral gate is incomplete.
- `PIVOT WITHIN IDEA`: keep the same user/job but change a named assumption.
- `FALSIFIED`: a central assumption failed its threshold.

Produce the source ledger, competitor/substitute map, risk register, experiment results, economics, falsifiers, unknowns, and exact next gate. Invoke `$apple-product-spec` only after `VALIDATED FOR MVP` or an explicit user decision to accept the remaining risk.

Read `references/validation-plan.md` for the output template.
