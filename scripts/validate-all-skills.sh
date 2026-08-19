#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
validator="${SKILL_VALIDATOR:-$HOME/.codex/skills/.system/skill-creator/scripts/quick_validate.py}"

if [[ ! -f "$validator" ]]; then
  echo "error: skill validator not found: $validator" >&2
  echo "set SKILL_VALIDATOR to the skill-creator quick_validate.py path" >&2
  exit 2
fi

expected=(
  app-store-launch-orchestrator
  app-market-discovery
  app-idea-validator
  apple-product-spec
  apple-app-designer
  apple-agent-toolchain
  ios-app-builder
  ios-release-tester
  app-store-connect-preparer
  app-compliance-auditor
  app-review-recovery
  app-launch-operator
)

for skill in "${expected[@]}"; do
  directory="$repo_root/skills/$skill"
  [[ -d "$directory" ]] || { echo "error: missing $skill" >&2; exit 1; }
  python3 "$validator" "$directory"
  [[ -f "$directory/agents/openai.yaml" ]] || { echo "error: missing interface metadata for $skill" >&2; exit 1; }
  invocation="\$$skill"
  rg -Fq "$invocation" "$directory/agents/openai.yaml" || { echo "error: default prompt does not invoke $invocation" >&2; exit 1; }
done

required_artifacts=(
  docs/current-apple-requirements.md
  docs/full-lifecycle-checklist.md
  docs/human-handoff-matrix.md
  docs/app-store-field-guide.md
  skills/apple-app-designer/references/apple-measurements.md
  skills/app-idea-validator/references/validation-evidence.md
  skills/app-compliance-auditor/references/conditional-requirements.md
  skills/app-review-recovery/references/rejection-catalog.md
  .mcp.json
  docs/executable-release-flow.md
  scripts/archive-and-export.sh
  scripts/verify-ipa.sh
  scripts/upload-ipa.sh
  scripts/asc-stage-version.py
)

for artifact in "${required_artifacts[@]}"; do
  [[ -f "$repo_root/$artifact" ]] || { echo "error: missing required artifact: $artifact" >&2; exit 1; }
done

for release_script in archive-and-export.sh verify-ipa.sh upload-ipa.sh; do
  bash -n "$repo_root/scripts/$release_script"
done

python3 - <<PY
from pathlib import Path
source = Path("$repo_root/scripts/asc-stage-version.py").read_text()
compile(source, "asc-stage-version.py", "exec")
PY

if rg -n '\[TODO|TODO:|FIXME|REPLACE_ME' "$repo_root/skills" "$repo_root/docs" "$repo_root/README.md"; then
  echo "error: unresolved placeholder found" >&2
  exit 1
fi

for term in 'market' 'behavioral validation' 'design' '44×44' 'screenshot' 'Xcode 26' 'StoreKit' 'TestFlight' 'privacy manifest' 'account deletion' 'subscription' 'rejection' 'DSA' 'accessibility' 'age rating' 'launch'; do
  rg -qi "$term" "$repo_root/README.md" "$repo_root/skills" "$repo_root/docs" || {
    echo "error: lifecycle coverage missing: $term" >&2
    exit 1
  }
done

private_word='PRIVATE'
secret_pattern="BEGIN (RSA |EC |OPENSSH |DSA )?${private_word} KEY|AKIA[0-9A-Z]{16}|AIza[0-9A-Za-z_-]{30,}|sk_live_[0-9A-Za-z]{16,}|gh[pousr]_[0-9A-Za-z]{20,}"
if rg -n --hidden --glob '!**/.git/**' "$secret_pattern" "$repo_root"; then
  echo "error: possible committed secret" >&2
  exit 1
fi

specific_pattern='case[-]study|sunrise[ ]poppy|stained[ -]glass'
if rg -ni --hidden --glob '!**/.git/**' "$specific_pattern" "$repo_root"; then
  echo "error: product-specific material found in general repository" >&2
  exit 1
fi

echo "Validated ${#expected[@]} skills and repository safety checks."
