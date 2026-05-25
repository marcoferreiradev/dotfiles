#!/usr/bin/env bash
# Idempotent bootstrap: brew bundle, stow modules, mac defaults.
set -euo pipefail

cd "$(dirname "$0")"

echo "==> brew bundle"
brew bundle

echo "==> stow zsh starship git cursor"
stow zsh starship git cursor

echo "==> Cursor extensions"
if command -v cursor &>/dev/null && [[ -f cursor-extensions.txt ]]; then
  while IFS= read -r ext; do
    [[ -z "$ext" || "$ext" =~ ^# ]] && continue
    cursor --install-extension "$ext" --force 2>/dev/null || true
  done < cursor-extensions.txt
fi

echo "==> macos/defaults.sh"
bash macos/defaults.sh

echo
echo "Done. Manual steps left:"
echo "  - iTerm Settings → Preferences → Load from custom folder → $PWD/iterm"
echo "  - Restart shell"
