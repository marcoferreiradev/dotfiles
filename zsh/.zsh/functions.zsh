# ~/.zsh/functions.zsh
# Custom shell functions

# zz: Fuzzy find and jump to directory (zoxide + fzf)
zz() {
  local dir
  dir="$(zoxide query -i)" && [[ -n "$dir" ]] && cd "$dir"
}

# pf: Fuzzy find and kill processes (default SIGKILL, accepts signal as $1)
pf() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m --height 40% --reverse | awk '{print $2}')
  if [[ -n "$pid" ]]; then
    echo "$pid" | xargs kill -${1:-9}
    echo "Killed process(es): $pid"
  fi
}

# timezsh: Benchmark zsh startup time
timezsh() {
  local iterations="${1:-10}"
  echo "Running $iterations iterations..."
  for i in $(seq 1 $iterations); do
    local timing=$( (time zsh -i -c exit) 2>&1 | grep real | awk '{print $2}' )
    echo "  Run $i: $timing"
  done
}

# helpme: list custom functions & aliases
helpme() {
  echo "=== Custom Functions ==="
  echo "  zz              - Fuzzy directory jump (zoxide + fzf)"
  echo "  pf [signal]     - Fuzzy process killer"
  echo "  timezsh [n]     - Benchmark zsh startup"
  echo "  helpme          - This help"
  echo ""
  echo "=== Aliases ==="
  echo "  zshconfig       - Edit ~/dotfiles/zsh/.zshrc"
  echo "  dotfiles        - cd ~/dotfiles"
  echo "  reload          - source ~/.zshrc"
  echo "  y               - yazi file manager"
  echo "  ports           - listening ports"
  echo "  pbc/pbp         - clipboard copy/paste"
  echo ""
  echo "=== Git + FZF ==="
  echo "  fbr fco fshow fstash gadd gdiff greset"
}
