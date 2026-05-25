#!/usr/bin/env bash
# Aplica defaults do macOS. Idempotente — pode rodar várias vezes.
#
# Antes de rodar a primeira vez, recomendo:
#   defaults read > ~/macos-defaults-snapshot.plist
# para ter um snapshot do estado original caso queira voltar algo.
#
# Cresce orgânico: adicione novos `defaults write` quando esbarrar com algo que
# vale a pena trackear.

set -euo pipefail

echo "==> Keyboard"
# Faz tecla repetir bem rápido quando segura (default macOS é lento)
defaults write NSGlobalDomain KeyRepeat -int 2          # repeat rate (menor = mais rápido)
defaults write NSGlobalDomain InitialKeyRepeat -int 15  # delay antes de começar repeat
# Permite repeat ao segurar tecla (default = false desde Lion: mostra accent menu)
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

echo "==> Finder"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true   # mostrar extensões
defaults write com.apple.finder ShowPathbar -bool true            # barra de path no fundo
defaults write com.apple.finder ShowStatusBar -bool true          # barra de status no fundo
# defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"   # list view (descomente se preferir lista)

echo "==> Screenshots"
mkdir -p "$HOME/Screenshots"
defaults write com.apple.screencapture location -string "$HOME/Screenshots"
defaults write com.apple.screencapture type -string "png"
defaults write com.apple.screencapture disable-shadow -bool true   # sem sombra em screenshots de janela

echo "==> Trackpad / Mouse"
# Habilita tap-to-click no trackpad
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

echo "==> Misc"
# Desabilita auto-correção (incomoda em código)
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
# Acelera abertura/fechamento de janelas
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

echo "==> Restart affected processes"
killall Finder Dock SystemUIServer 2>/dev/null || true

echo
echo "Done. Algumas configs só aparecem após logout/login (Trackpad)."
