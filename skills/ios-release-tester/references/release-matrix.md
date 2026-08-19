# Release matrix template

| Area | Scenario/device | Expected | Evidence | Status | Defect |
|---|---|---|---|---|---|
| Build | Clean Release build | No warning/error that invalidates release |  |  |  |
| Unit/integration/UI | Full suite | All required tests pass |  |  |  |
| Visual | Each supported size class | Usable, unclipped, accessible |  |  |  |
| Persistence | Save/kill/relaunch/upgrade | Exact data preserved or migrated |  |  |  |
| StoreKit | Purchase/restore/revoke/offline | Correct entitlement state |  |  |  |
| Export/import | Valid/invalid inputs | Correct artifacts and errors |  |  |  |
| Privacy/security | Manifest/SDK/network/secrets | Dossier matches binary |  |  |  |
| Archive | Sign/validate/export/upload | Intended identifiers/entitlements |  |  |  |
| TestFlight | Fresh install and core loop | Same behavior as candidate |  |  |  |

Record commit, version/build, Xcode/SDK, date, tester, device/runtime, and artifact paths above the table.
