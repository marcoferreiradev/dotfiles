# marcoferreiradev/dotfiles — Brewfile (dev)
# Aplique com: `brew bundle` (na raiz do repo)
#
# Buckets opt-in (instalar separadamente em Mac novo, se quiser):
#   brew bundle --file=Brewfile.system    # utilitários macOS (alt-tab, linearmouse, ...)
#   brew bundle --file=Brewfile.personal  # apps pessoais (Notion, Spotify)

# ============================================================================
# Taps
# ============================================================================
tap "supabase/tap"
tap "vtex/vtex"

# ============================================================================
# Formulae (CLI tools)
# ============================================================================
# Modern unix replacements
brew "bat"        # cat com syntax highlighting
brew "fd"         # find moderno
brew "lsd"        # ls com ícones (alias ls=lsd)
brew "dust"       # du moderno
brew "btop"       # top moderno
brew "ripgrep"    # grep rápido (rg)

# Shell + multiplexer
brew "stow"       # symlinks dos dotfiles
brew "tmux"       # terminal multiplexer
brew "fzf"        # fuzzy finder
brew "zoxide"     # cd inteligente (alias cd=z)

# Git & GitHub
brew "git"
brew "gh"

# File managers / media
brew "yazi"       # file manager TUI
brew "ffmpeg"     # áudio/vídeo

# Language toolchains
brew "go"
brew "pnpm"
brew "yarn"
brew "watchman"   # file watcher (React Native)

# Tooling pessoal
brew "rtk"        # token-killer proxy
brew "wget"

# CLIs específicos
brew "supabase/tap/supabase"
brew "vtex/vtex/vtex"

# ============================================================================
# Casks (apps GUI — dev)
# ============================================================================
cask "visual-studio-code"
cask "cursor"     # editor primário; instalar via brew em mac novo
cask "ngrok"

# Cloud / mobile
cask "gcloud-cli"
cask "android-platform-tools"

# AI / agentes
cask "codex"             # OpenAI CLI

# Fontes
cask "font-jetbrains-mono-nerd-font"

# ============================================================================
# npm globals
# ============================================================================
npm "corepack"
npm "@nestjs/cli"
npm "@tobilu/qmd"
