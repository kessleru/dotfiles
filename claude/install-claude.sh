#!/usr/bin/env bash
# Restaura a configuracao e os plugins do Claude Code.
set -uo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="${HOME}/.claude"

echo "--> Claude Code: aplicando settings.json"
mkdir -p "${CLAUDE_DIR}"

if [ -f "${CLAUDE_DIR}/settings.json" ]; then
  cp "${CLAUDE_DIR}/settings.json" "${CLAUDE_DIR}/settings.json.bak"
  echo "    backup salvo em settings.json.bak"
fi

if command -v jq >/dev/null 2>&1 && [ -f "${CLAUDE_DIR}/settings.json.bak" ]; then
  # Faz merge preservando chaves que ja existiam (as dos dotfiles vencem).
  jq -s '.[0] * .[1]' "${CLAUDE_DIR}/settings.json.bak" "${HERE}/settings.json" \
    > "${CLAUDE_DIR}/settings.json"
else
  cp "${HERE}/settings.json" "${CLAUDE_DIR}/settings.json"
fi

MARKETPLACE_URL="https://github.com/anthropics/claude-plugins-official.git"
MARKETPLACE="claude-plugins-official"

PLUGINS=(
  "frontend-design"
  "superpowers"
  "code-review"
  "context7"
  "skill-creator"
  "code-simplifier"
  "playwright"
  "claude-md-management"
  "typescript-lsp"
  "feature-dev"
  "security-guidance"
)

if ! command -v claude >/dev/null 2>&1; then
  echo "    'claude' CLI ausente; settings.json aplicado, plugins serao"
  echo "    resolvidos na primeira execucao do Claude Code."
  exit 0
fi

echo "--> Claude Code: adicionando marketplace ${MARKETPLACE}"
claude plugin marketplace add "${MARKETPLACE_URL}" 2>/dev/null || true

for p in "${PLUGINS[@]}"; do
  echo "    instalando ${p}"
  claude plugin install "${p}@${MARKETPLACE}" 2>/dev/null || true
done

echo "--> Claude Code: pronto."
