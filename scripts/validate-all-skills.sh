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

if rg -n '\[TODO|TODO:|FIXME|REPLACE_ME' "$repo_root/skills" "$repo_root/docs" "$repo_root/README.md"; then
  echo "error: unresolved placeholder found" >&2
  exit 1
fi

for term in 'market' 'design' 'StoreKit' 'TestFlight' 'privacy' 'subscription' 'rejection' 'launch'; do
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

echo "Validated ${#expected[@]} skills and repository safety checks."
