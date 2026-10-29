#!/usr/bin/env bash
# Links these dotfiles into place. Safe to run again.
set -euo pipefail
DOT="$(cd "$(dirname "$0")" && pwd)"

link() {
  local src="$DOT/$1" dst="$2"
  mkdir -p "$(dirname "$dst")"
  if [[ -e "$dst" && ! -L "$dst" ]]; then
    mv "$dst" "$dst.bak-$(date +%Y%m%d%H%M%S)"
  fi
  ln -sfn "$src" "$dst"
  echo "linked $dst"
}

link starship/starship.toml "$HOME/.config/starship.toml"
link ghostty/config.ghostty "$HOME/.config/ghostty/config.ghostty"
link yazi "$HOME/.config/yazi"

# ~/.zshrc loads zsh/zshrc
grep -q 'dotfiles/zsh/zshrc' "$HOME/.zshrc" 2>/dev/null ||
  printf '\nsource "$HOME/dotfiles/zsh/zshrc"\n' >>"$HOME/.zshrc"

# ~/.gitconfig includes git/gitconfig
git config --global --get-all include.path | grep -qx '~/dotfiles/git/gitconfig' ||
  git config --global --add include.path '~/dotfiles/git/gitconfig'

# Machine notes for agents. Claude Code imports the file; AGENTS.md files
# can't import, so they get a copy between markers (rerun to refresh).
CLAUDE_MD="$HOME/.claude/CLAUDE.md"
grep -qF '@~/dotfiles/agents/machine.md' "$CLAUDE_MD" 2>/dev/null ||
  printf '\n@~/dotfiles/agents/machine.md\n' >>"$CLAUDE_MD"
for f in "$HOME/.codex/AGENTS.md" "$HOME/AGENTS.md"; do
  [[ -f "$f" ]] || continue
  python3 - "$f" "$DOT/agents/machine.md" <<'PY'
import re, sys
path, src = sys.argv[1], sys.argv[2]
block = "<!-- DOTFILES_MACHINE_START -->\n" + open(src).read().strip() + "\n<!-- DOTFILES_MACHINE_END -->"
text = open(path).read()
pattern = r"<!-- DOTFILES_MACHINE_START -->.*?<!-- DOTFILES_MACHINE_END -->"
text = re.sub(pattern, lambda _: block, text, flags=re.S) if re.search(pattern, text, re.S) else text.rstrip() + "\n\n" + block + "\n"
open(path, "w").write(text)
PY
  echo "synced machine notes into $f"
done

# Homebrew packages
brew bundle --file="$DOT/Brewfile"

# Extra Oh My Zsh plugins
CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins"
[[ -d "$CUSTOM/fzf-tab" ]] || git clone --depth 1 https://github.com/Aloxaf/fzf-tab "$CUSTOM/fzf-tab"
[[ -d "$CUSTOM/you-should-use" ]] || git clone --depth 1 https://github.com/MichaelAquilina/zsh-you-should-use "$CUSTOM/you-should-use"

# yazi theme, GitHub dashboard
ya pkg install
gh extension list | grep dlvhdr/gh-dash >/dev/null || gh extension install dlvhdr/gh-dash

echo "done: open a new terminal tab"
