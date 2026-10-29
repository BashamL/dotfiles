# Small helpers. Most use fzf: type to filter, Enter to pick, Esc to cancel.

# md <file>: read Markdown nicely formatted (q or Ctrl-C closes it).
# Replaces Oh My Zsh's `md` alias for mkdir -p; `take` still makes a folder.
unalias md 2>/dev/null
md() { glow --style dark --width $(( COLUMNS > 110 ? 100 : COLUMNS - 4 )) "$@" | less }

# Show the cheat sheet
cheat() { md "$DOTFILES/CHEATSHEET.md" }

# y: browse files in yazi; quitting with q leaves you in the folder you were in
y() {
  local tmp cwd
  tmp=$(mktemp -t yazi-cwd.XXXXXX)
  yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd <"$tmp"
  [[ -n $cwd && $cwd != "$PWD" ]] && builtin cd -- "$cwd"
  rm -f -- "$tmp"
}

# fe [query]: fuzzy-find a file and open it in Cursor
fe() {
  local file
  file=$(fzf --query="$*" --preview 'bat --color=always --style=numbers --line-range :300 {}') && cursor "$file"
}

# rge <pattern>: search file contents, preview the hit, open it in Cursor at that line
rge() {
  [[ -z $1 ]] && { echo "usage: rge <pattern>"; return 1 }
  local hit
  hit=$(rg --line-number --no-heading --color=always --smart-case "$@" |
    fzf --ansi --delimiter : \
        --preview 'bat --color=always --style=numbers --highlight-line {2} {1}' \
        --preview-window '+{2}-/2') || return
  cursor --goto "$(cut -d: -f1,2 <<<"$hit")"
}

# fbr: fuzzy-pick a git branch (most recent first) and switch to it
fbr() {
  local branch
  branch=$(git for-each-ref --sort=-committerdate refs/heads --format='%(refname:short)' |
    fzf --preview 'git log --oneline --graph --color=always -20 {}') && git switch "$branch"
}

# wt: fuzzy-jump between git worktrees of the current repo
wt() {
  local dir
  dir=$(git worktree list | fzf --preview 'git -C {1} log --oneline --color=always -10' | awk '{print $1}') && cd "$dir"
}

# fkill: fuzzy-pick processes and kill them (Tab to select several)
fkill() {
  local pids
  pids=$(ps -u "$USER" -o pid,%cpu,%mem,command | sed 1d | fzf --multi --header 'Tab: select, Enter: kill' | awk '{print $1}')
  [[ -n $pids ]] && echo "$pids" | xargs kill -"${1:-15}"
}

# port <n>: what's listening on a port; killport <n>: stop it
port() { lsof -nP -iTCP:"$1" -sTCP:LISTEN }
killport() {
  local pids
  pids=$(lsof -tiTCP:"$1" -sTCP:LISTEN)
  [[ -z $pids ]] && { echo "nothing on :$1"; return 1 }
  echo "$pids" | xargs kill && echo "stopped :$1"
}

# update-all: Homebrew, Oh My Zsh, its extra plugins, tldr pages
update-all() {
  brew update && brew upgrade && brew cleanup
  omz update
  local p
  for p in fzf-tab you-should-use; do
    git -C "$ZSH_CUSTOM/plugins/$p" pull --ff-only --quiet && echo "updated $p"
  done
  tldr --update
}
