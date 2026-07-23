# dotfiles

Configurações pessoais aplicadas automaticamente em **todo Codespace novo, de qualquer repositório**.

## Como ativar (uma vez só)

1. Crie um repositório **público** na sua conta GitHub chamado `dotfiles`.
2. Suba o conteúdo desta pasta para a raiz dele.
3. Vá em <https://github.com/settings/codespaces> → seção **Dotfiles** →
   marque **"Automatically install dotfiles"** e selecione o repo `dotfiles`.

Pronto. A partir daí o GitHub roda `install.sh` sozinho em cada Codespace novo.

## Uso manual

Se quiser aplicar num Codespace já existente:

```bash
git clone https://github.com/<seu-usuario>/dotfiles.git ~/dotfiles
bash ~/dotfiles/install.sh
```

## O que tem aqui

| Caminho | O que faz |
|---|---|
| `install.sh` | Entrypoint — chama os três instaladores abaixo |
| `claude/settings.json` | Config do Claude Code: 11 plugins habilitados + marketplace oficial + modelo `opus` |
| `claude/install-claude.sh` | Copia o settings (com backup/merge) e reinstala os plugins via CLI |
| `vscode/settings.json` | Layout minimalista (sem status bar, tabs, command center; activity bar embaixo), tema One Dark Pro, Prettier no save, git autofetch |
| `vscode/extensions.txt` | Lista das 16 extensões |
| `vscode/install-vscode.sh` | Aplica settings e instala as extensões |
| `git/install-git.sh` | `init.defaultBranch main`, aliases (`st`, `co`, `br`, `lg`) |

Todos os scripts são **idempotentes** — podem rodar quantas vezes for preciso.
