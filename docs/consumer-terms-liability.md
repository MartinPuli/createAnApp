# Consumer terms and liability architecture

Generalized from real launch work. This is engineering documentation about
risk structure, not legal advice; have consumer terms reviewed by counsel
before relying on them.

## What contract language cannot do

- **Consumer-protection statutes commonly void consumer waivers.** In several
  U.S. states a consumer's waiver of the state consumer-protection act is void
  unless strict conditions are met (one example of the class: Texas Bus. & Com.
  Code §17.42 requires the consumer to have had independent counsel at
  purchase — never true of an app buyer). A liability cap manages a claim after
  it exists; it does not defeat a deceptive-practices claim arising from a
  false statement in the product.
- **Fee-shifting makes small claims economical.** Where the statute awards
  attorney's fees to a prevailing consumer, "the app only costs a few dollars"
  is not a defense strategy: the exposure is the fees, not the refund.
- **Gross negligence, willful misconduct, and personal injury** cannot be
  disclaimed anywhere in the US. Screens a user might rely on for real-world
  work need their own point-of-use safety notice; the only mitigations for the
  injury tail are structural — a liability entity and E&O insurance — not
  drafting.

## The clause hierarchy, by value

1. **Binding individual arbitration + class-action waiver**, with a
   small-claims carve-out, a 30-day email opt-out, a jury-trial waiver, and a
   severability clause so one struck claim does not sink the section. The class
   action is the scenario that can exceed a small product's lifetime value by
   orders of magnitude; this one section removes it.
2. **Accuracy of the content itself.** The only control that prevents claims
   rather than managing them. A disclaimer does not make a false statement
   true. A small bank of independently verifiable facts can ship on technical
   review; scaling the content is what requires qualified professional
   sign-off. Record provenance honestly in shipped data (an explicit
   `professionalSignOff: false` style flag) rather than implying a review that
   has not happened.
3. **Point-of-use disclosure.** Machine-generated or machine-refined output is
   labelled where it appears, stating plainly which part is human-reviewed.
   Disclosure buried in terms is treated as weaker by regulators and stores.
4. **Warranty disclaimer and liability cap.** Still worth having — they set
   expectations and cap the ordinary case — but they are the floor, not the
   shield.

## Platform-required minimums

A store-distributed EULA must also carry the platform's standard clauses:
parties (the agreement is with the developer, not the platform), maintenance
and support responsibility, warranty-failure refund mechanics, product-claim
responsibility, third-party IP-claim responsibility, export/sanctions
representations, and the platform as third-party beneficiary. Check the
platform's current minimum-terms document rather than copying an old EULA.

## Trademark hygiene for exam-prep, companion, and ecosystem apps

- Nominative use is permitted: naming the exam, standard, or product you
  prepare people for is fine; implying endorsement is not. "Prep for the X
  exam" passes; "X-approved" does not.
- Carry the non-affiliation notice on every surface — app, store listing,
  website, ads — because it is easiest to drop in marketing copy.
- Never use the rights-holder's logos or lettermarks. Registered marks get the
  ® on first mention.

## Cheap structural closures

- **No user-generated content** (when true) forecloses the third-party
  copyright surface entirely; state it in the terms.
- **No network code** (when true) makes the privacy label auditable by grep
  instead of asserted by policy, and closes the tracking-statute surface.
  A zero-data privacy policy still needs its GDPR and CCPA sections — stating
  there is nothing to access, delete, or port is itself the compliance answer.
- **Every marketed statistic traced to its primary source before it ships.**
  An unverifiable claim on a store page or landing page is itself a
  consumer-protection violation.
