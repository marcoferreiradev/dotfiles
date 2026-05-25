# ~/.zshrc — Zsh configuration (Zinit + Spaceship)
# Managed by ~/dotfiles via GNU Stow

# ============================================================================
# Startup Performance Debugging (uncomment to profile)
# ============================================================================
# zmodload zsh/zprof  # top of file
# zprof               # bottom of file

# ============================================================================
# XDG Base Directory Support
# ============================================================================
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
[[ -d "$XDG_DATA_HOME/zsh" ]] || mkdir -p "$XDG_DATA_HOME/zsh" "$XDG_CACHE_HOME/zsh"

# ============================================================================
# PATH
# ============================================================================
typeset -U PATH fpath

export PNPM_HOME="$HOME/Library/pnpm"
export ASDF_DATA_DIR="${ASDF_DATA_DIR:-$HOME/.asdf}"
export HOMEBREW_PREFIX="/opt/homebrew"
export BUN_INSTALL="$HOME/.bun"

export PATH="$HOME/.local/bin:$HOME/.npm-global/bin:$PNPM_HOME:$BUN_INSTALL/bin:$HOMEBREW_PREFIX/opt/postgresql@18/bin:$HOMEBREW_PREFIX/bin:$ASDF_DATA_DIR/shims:$PATH"

# ============================================================================
# Zinit (plugin manager)
# ============================================================================
ZINIT_HOME="${XDG_DATA_HOME}/zinit/zinit.git"
if [[ ! -d "$ZINIT_HOME" ]]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# OMZ libs + git plugin (gives gs/ga/gc/gp/gco/gd/gb aliases)
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit cdclear -q
setopt promptsubst

# External plugins (same set as OMZ days, loaded directly)
zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting

# ============================================================================
# History
# ============================================================================
HISTSIZE=50000
SAVEHIST=50000
HISTFILE="$XDG_DATA_HOME/zsh/history"

setopt SHARE_HISTORY HIST_IGNORE_DUPS HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS HIST_VERIFY APPEND_HISTORY HIST_FIND_NO_DUPS

# ============================================================================
# Zsh options
# ============================================================================
setopt AUTO_CD CORRECT INTERACTIVE_COMMENTS NO_BEEP EXTENDED_GLOB NO_CASE_GLOB NUMERIC_GLOB_SORT

bindkey '^L' clear-screen

# ============================================================================
# Completions
# ============================================================================
FPATH="$HOMEBREW_PREFIX/share/zsh/site-functions:$FPATH"
fpath=($HOME/.zsh/completions $fpath)

autoload -Uz compinit
local compinit_dump="$XDG_CACHE_HOME/zsh/zcompdump-${ZSH_VERSION}"
if [[ -n $compinit_dump(#qN.mh+24) ]]; then
  compinit -d "$compinit_dump"
else
  compinit -C -d "$compinit_dump"
fi

# ============================================================================
# Environment
# ============================================================================
export PGDATABASE=postgres
export _ZO_DOCTOR=0  # silence zoxide config-issue warning
export EDITOR='cursor --wait'

# ============================================================================
# Directory shortcuts (use with ~name)
# ============================================================================
hash -d projects=~/Projects 2>/dev/null
hash -d downloads=~/Downloads
hash -d config=~/.config
hash -d desktop=~/Desktop
hash -d dotfiles=~/dotfiles

# ============================================================================
# fzf-tab config
# ============================================================================
zstyle ':completion:*' complete-options true
zstyle ':completion:*:options' description yes
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*' expand yes
zstyle ':completion:*' accept-exact-dirs true
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' list-dirs-first true
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'lsd -1 --color=always $realpath'
zstyle ':fzf-tab:complete:*:*' fzf-preview 'bat --color=always --style=numbers --line-range=:100 $realpath 2>/dev/null || lsd -1 --color=always $realpath'
zstyle ':fzf-tab:*' switch-group '<' '>'

# ============================================================================
# Modular config loading
# ============================================================================
for f in "$HOME/.zsh/aliases.zsh" "$HOME/.zsh/functions.zsh" "$HOME/.zsh/tools.zsh" "$HOME/.zsh/git.zsh"; do
  [[ -f "$f" ]] && source "$f"
done

# ============================================================================
# Bun
# ============================================================================
[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"

# ============================================================================
# Deno
# ============================================================================
[ -f "$HOME/.deno/env" ] && . "$HOME/.deno/env"

# ============================================================================
# essential-skills (marcoferreiradev)
# ============================================================================
alias install-my-skills="bash <(gh api repos/marcoferreiradev/essential-skills/contents/install.sh --jq '.content' | base64 -d)"
alias install-my-skills-global="bash <(gh api repos/marcoferreiradev/essential-skills/contents/install.sh --jq '.content' | base64 -d) --global"
alias update-my-skills="bash <(gh api repos/marcoferreiradev/essential-skills/contents/install.sh --jq '.content' | base64 -d) --update"

# ============================================================================
# Local overrides (not versioned)
# ============================================================================
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# ============================================================================
# Spaceship prompt (after everything that touches PATH)
# ============================================================================
zinit light spaceship-prompt/spaceship-prompt

# ============================================================================
# Zoxide (MUST stay at very end — hooks PATH at init time)
# ============================================================================
eval "$(zoxide init zsh)"
