# dotfiles

Setup pessoal: iTerm2 + zsh (Zinit) + Starship + CLI tools modernos + macOS defaults.

Gerenciado com [GNU Stow](https://www.gnu.org/software/stow/).

## Bootstrap em Mac novo

```bash
# 1. Xcode CLT (se ainda não tiver)
xcode-select --install

# 2. Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 3. Clone
git clone git@github.com:marcoferreiradev/dotfiles.git ~/dotfiles
cd ~/dotfiles

# 4. Brewfile (instala stow, starship, e tudo mais)
brew bundle

# 5. Symlinks via Stow
stow zsh starship git

# 6. macOS defaults
bash macos/defaults.sh

# 7. iTerm: Settings → General → Preferences → Load preferences from custom folder → ~/dotfiles/iterm
```

## Estrutura

| Pasta | O que é |
|-------|---------|
| `zsh/` | `.zshrc` + `~/.zsh/*.zsh` modulares (aliases, functions, git, tools) |
| `starship/` | `~/.config/starship.toml` (prompt) |
| `git/` | `~/.gitconfig` |
| `iterm/` | Preferences plist do iTerm2 (apontado via custom folder) |
| `macos/` | `defaults.sh` idempotente |
| `Brewfile` | Lock de tudo que vem do Homebrew |

## Inspirações

- [pbpeterson/dotfiles](https://github.com/pbpeterson/dotfiles)
- [Gordon Beeming — My Dotfiles Setup](https://gordonbeeming.com/blog/2026-03-10/my-dotfiles-setup-how-i-manage-my-dev-environment)
