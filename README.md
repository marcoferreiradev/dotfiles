# dotfiles

Setup pessoal pra macOS: iTerm2 + zsh (Zinit + Spaceship) + tmux + CLI tools modernos + macOS defaults. Gerenciado com [GNU Stow](https://www.gnu.org/software/stow/).

## Features

### Shell (zsh)
- **Zinit** em vez de Oh My Zsh — startup mais rápido, sem framework pesado
- **Spaceship prompt** carregado via Zinit (sem instalação extra)
- Configuração modular em `~/.zsh/*.zsh` (aliases, functions, git, tools)
- Integração com CLI modernos (bat, fd, lsd, ripgrep, fzf, zoxide)

### Tmux
- Prefix **`C-Space`** (sem conflito com zsh ou apps que usam `C-b`/`C-a`)
- Mouse on, base-index 1, history 50k, renumber-windows
- Vim copy-mode (`v` seleciona, `y` copia)
- Truecolor habilitado
- Zero plugins inicial — adiciona quando sentir falta

### macOS
- `defaults.sh` idempotente (Dock, Finder, teclado, etc.)
- iTerm2 prefs versionadas (carregadas via custom folder)
- Cursor settings + keybindings sincronizados via Stow

### Editores
- Cursor (primário) — settings, keybindings e lista de extensões versionadas
- VS Code (secundário) — instalado via Brewfile, config manual

## Bootstrap em Mac novo

```bash
# 1. Xcode CLT (se ainda não tiver)
xcode-select --install

# 2. Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 3. Clone
git clone git@github.com:marcoferreiradev/dotfiles.git ~/dotfiles
cd ~/dotfiles

# 4. Bootstrap idempotente (brew bundle + stow + macOS defaults + Cursor extensions)
./install.sh

# 5. (Opcional) Brewfiles extras
brew bundle --file=Brewfile.system    # alt-tab, linearmouse, stats, mole, etc.
brew bundle --file=Brewfile.personal  # notion, spotify

# 6. iTerm2: Settings → General → Preferences → Load preferences from custom folder → ~/dotfiles/iterm

# 7. Restart shell
exec zsh
```

## File Structure

```
dotfiles/
├── install.sh            📜 bootstrap idempotente
├── Brewfile              🔧 dev essentials (default `brew bundle`)
├── Brewfile.system       🔧 utilitários macOS (opt-in)
├── Brewfile.personal     🔧 apps pessoais (opt-in)
├── cursor-extensions.txt 📜 lista de extensões do Cursor
├── .stow-local-ignore    ⚙️  arquivos que Stow ignora
│
├── zsh/                  🔗 pacote Stow → ~/.zshrc + ~/.zsh/
│   ├── .zshrc
│   └── .zsh/             # aliases, functions, git, tools (modular)
│
├── tmux/                 🔗 pacote Stow → ~/.tmux.conf
│   └── .tmux.conf
│
├── git/                  🔗 pacote Stow → ~/.gitconfig
│   └── .gitconfig
│
├── cursor/               🔗 pacote Stow → ~/Library/.../Cursor/User/
│   └── Library/Application Support/Cursor/User/{keybindings,settings}.json
│
├── iterm/                📂 carregado pelo iTerm (custom prefs folder, não-Stow)
│   └── com.googlecode.iterm2.plist
│
└── macos/                📜 script (não-Stow)
    └── defaults.sh
```

**Legenda:** 🔗 pacote Stow • 📜 script • 📂 carregado pelo app • 🔧 Brewfile • ⚙️ config Stow

## Customization & Updating

### Overrides por máquina

Crie `~/.zshrc.local` pra configs específicas que não vão pro repo (work paths, secrets, alias temporário):

```bash
# ~/.zshrc.local
export WORK_DIR="$HOME/work/oficina-reserva"
alias work="cd $WORK_DIR"
```

O `zsh/.zshrc` carrega automaticamente esse arquivo se existir.

### Adicionar/editar aliases e functions

Edite os módulos em `zsh/.zsh/` (aliases.zsh, functions.zsh, etc.). Como são symlinks via Stow, salvar = ativo no próximo shell.

### Atualizar o repo

```bash
cd ~/dotfiles
git pull
./install.sh    # idempotente — re-aplica drift
```

Pra forçar re-stow de um pacote específico:

```bash
stow -R zsh    # equivalente a -D + -S
```

## Troubleshooting

- **Symlink órfão** (arquivo no home aponta pra nada): `cd ~/dotfiles && stow -D <pkg> && stow <pkg>`
- **Spaceship não renderiza**: abrir **aba nova** do iTerm — Spaceship só ativa no `precmd` real; `zsh -ic '...'` mostra falso negativo.
- **iTerm prefs não carregadas**: Settings → General → Preferences → "Load preferences from custom folder" apontando pra `~/dotfiles/iterm`.
- **Cursor sem extensões**: rerodar `./install.sh` (a seção de extensões é idempotente).
- **`brew bundle` reclama de cask faltando**: provavelmente é cask do `Brewfile.system` ou `.personal` instalado fora do default — rode `brew bundle cleanup --file=Brewfile` pra ver o que sobra.

## Inspirações

- [pbpeterson/dotfiles](https://github.com/pbpeterson/dotfiles) — estrutura modular de zsh + tmux + nvim
- [Gordon Beeming — My Dotfiles Setup](https://gordonbeeming.com/blog/2026-03-10/my-dotfiles-setup-how-i-manage-my-dev-environment) — filosofia Stow-first, manter simples pra atualizar sempre
