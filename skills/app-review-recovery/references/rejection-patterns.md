# Rejection pattern playbook

| Signal | Likely root cause | Verification | Durable control |
|---|---|---|---|
| Subscription lacks Terms/EULA | Metadata link absent/inaccessible | Open saved localization and URL; inspect paywall | Submission preflight requires Terms for auto-renewables |
| Guideline 4 crowded interface | Supported width was functionally but not visually tested | Reproduce exact device; capture all size classes | Device contract + screenshot QA + intentional family targeting |
| New group cannot submit | Group has no product in submission | Inspect submission item list | Dependency graph for first subscription |
| IAP/subscriptions returned with app | Associated app rejection | Review item statuses and message | Resubmit complete dependency set after app fix |
| Screenshot processing blocks review | Invalid/stuck asset or hidden well | Media Manager by locale/device | Exact RGB export; incremental upload and saved proof |
| Reviewer cannot access feature | Missing demo account, setup, hardware, region, or notes | Clean external reproduction | Deterministic review path and precise notes |
| Metadata promises missing feature | Prototype or stale copy/screenshots | Trace each claim to build/test | Versioned promise-to-evidence matrix |

For every pattern, still search for additional issues in the complete submission.
