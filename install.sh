#!/usr/bin/env bash
# Entrypoint dos dotfiles — o GitHub Codespaces executa este arquivo
# automaticamente em TODO Codespace novo, de QUALQUER repositorio.
# Tambem pode ser rodado a mao: bash install.sh
set -uo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Instalando dotfiles a partir de ${DOTFILES_DIR}"

bash "${DOTFILES_DIR}/claude/install-claude.sh"
bash "${DOTFILES_DIR}/vscode/install-vscode.sh"
bash "${DOTFILES_DIR}/git/install-git.sh"

echo "==> Dotfiles instalados com sucesso."
