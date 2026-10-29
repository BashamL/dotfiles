## This machine

macOS on Apple Silicon, zsh with Oh My Zsh. The shell setup lives in `~/dotfiles` (a git repo): change it there, not in `~/.zshrc`, and commit.

- Homebrew is at `/opt/homebrew`. `brew install` runs without a prompt. Add terminal tools you install for good to `~/dotfiles/Brewfile`.
- Node, Ruby and other runtimes come from mise (`.node-version`, `mise.toml`, `mise use`). Don't install them with Homebrew, nvm or rbenv. JavaScript projects use pnpm. Python uses uv.
- Installed: `rg`, `fd`, `jq`, `yq`, `ast-grep` (structural code search and rewrite), `tree`, `gh`, `shellcheck`, `bat`, `eza`, `delta`, GNU coreutils as `g*` (`gdate`, `gtimeout`).
- `sed` is BSD: GNU-style `sed -i 's/a/b/' file` fails. Use `gsed -i`, `sed -i '' …`, or a file-edit tool. `grep -P` works.
- Git: merge conflicts use zdiff3 markers, with an extra `|||||||` section holding the common base between ours and theirs. `git push` on a new branch sets its upstream. Default branch is `main`.
- Nothing here waits for a keyboard: don't run `vim`, `less`, `lazygit`, `btop`, `yazi` (`y`), `menu`, `gh dash` (`prs`), `glow --pager`, `git rebase -i`, or the fzf helpers (`fe`, `rge`, `fbr`, `wt`, `fkill`). In Cursor's agent terminal and Claude Code the shell sets `PAGER=cat` and `GIT_EDITOR=true`, so merges and rebases take the default message.
