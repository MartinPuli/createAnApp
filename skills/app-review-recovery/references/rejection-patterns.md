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
| IAP cannot be purchased | Product catalog returned no matching item, while the UI exposed a purchase action | Cold-launch a clean install and verify the catalog response | Show catalog-derived prices only; disable purchase until the product resolves; expose loading and failure states |
| Screenshot rejected or upload fails | Asset does not match the exact dimensions or format accepted by the selected slot | Compare exported pixels and color mode with the current slot requirements | Export and validate each required device slot before upload |
| Product identifier cannot be reused | Identifier was previously created or removed and remains reserved | Verify availability in App Store Connect before implementing it | Create identifiers deliberately and treat them as immutable |
| Review notes mention evidence that is absent | Notes were copied from an earlier submission | Read the notes against the exact submitted build and attachments | Rewrite review notes for every submission |
| Release build differs from tested behavior | Configuration-gated data or features differ between Debug and Release | Run the archived Release configuration on a clean device | Test the shipping configuration and assert required production content |
| Purchase automation hangs | A system payment sheet requires foreground UI interaction | Observe the test at the purchase boundary | Separate deterministic catalog tests from UI-bound purchase tests and document justified skips |
| Build cannot be attached to an already released version | The submitted version slot is immutable after release | Inspect version and build state in App Store Connect | Create the next version record and attach a new build |

For every pattern, still search for additional issues in the complete submission.
