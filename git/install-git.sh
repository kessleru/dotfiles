#!/usr/bin/env bash
# Configuracoes globais do git.
set -uo pipefail

echo "--> Git: aplicando config global"

git config --global init.defaultBranch main
git config --global pull.rebase false
git config --global core.editor "code --wait"

# Aliases uteis
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.lg "log --oneline --graph --decorate -20"

echo "--> Git: pronto."
