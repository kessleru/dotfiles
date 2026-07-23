#!/usr/bin/env bash
# Aplica settings do VS Code e instala as extensoes.
set -uo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Em Codespaces o diretorio do usuario e ~/.vscode-remote/data/User
for USER_DIR in "${HOME}/.vscode-remote/data/User" "${HOME}/.vscode-server/data/Machine"; do
  if [ -d "$(dirname "${USER_DIR}")" ]; then
    mkdir -p "${USER_DIR}"
    echo "--> VS Code: escrevendo settings em ${USER_DIR}"
    cp "${HERE}/settings.json" "${USER_DIR}/settings.json"
    break
  fi
done

# Instala extensoes via CLI, se disponivel.
CODE_BIN=""
for c in code code-insiders; do
  if command -v "$c" >/dev/null 2>&1; then CODE_BIN="$c"; break; fi
done

if [ -z "${CODE_BIN}" ]; then
  echo "    CLI 'code' ausente; extensoes serao instaladas pelo Settings Sync."
  exit 0
fi

while IFS= read -r ext; do
  [ -z "${ext}" ] && continue
  case "${ext}" in \#*) continue ;; esac
  echo "    instalando ${ext}"
  "${CODE_BIN}" --install-extension "${ext}" --force >/dev/null 2>&1 || true
done < "${HERE}/extensions.txt"

echo "--> VS Code: pronto."
