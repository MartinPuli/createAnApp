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
| IAP cannot be purchased (2.1(b)) | Product.products() returned empty without throwing; UI showed hardcoded prices with live buy buttons | Cold-launch on a clean simulator and watch the catalog actually load | Render only catalog-derived prices; disable buy until the product resolves; retry with backoff and an honest failed state |
| Screenshot rejected or upload fails by size | Slot accepts exact pixel dimensions only | Check the slot's accepted sizes; verify dimensions programmatically | Export to exact accepted sizes per slot before upload |
| Product ID unusable | Identifier reserved/burned by prior create-delete in ASC | Attempt creation in ASC before writing code | Treat product IDs as immutable once created; create in ASC first |
| Reviewer told of an attachment that is absent | Review notes copied from a prior submission | Re-read the notes as the reviewer, against the actual submission | Rewrite review notes per submission; promise only what is attached |
| Release build missing content that Debug shows | A content gate differs across build configurations | Run the Release configuration itself, not only tests | Unit test asserts shipped content passes its own release gate |

For every pattern, still search for additional issues in the complete submission.
