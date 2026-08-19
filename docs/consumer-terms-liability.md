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

1. **Binding individual arbitration + class-action waiver** (with a small-claims
   carve-out and a 30-day opt-out). The class action is the scenario that can
   exceed a small product's lifetime value by orders of magnitude; this single
   section removes it. Follow the platform's required consumer-terms minimums
   as well.
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

## Cheap structural closures

- **No user-generated content** (when true) forecloses the third-party
  copyright surface entirely; state it in the terms.
- **No network code** (when true) makes the privacy label auditable by grep
  instead of asserted by policy, and closes the tracking-statute surface.
- **Every marketed statistic traced to its primary source before it ships.**
  An unverifiable claim on a store page or landing page is itself a
  consumer-protection violation.
