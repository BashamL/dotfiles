# dotfiles

My terminal setup on macOS: zsh with Oh My Zsh, the Starship prompt, Ghostty with the Catppuccin Mocha theme, and fzf wired into history, files and tab completion. [CHEATSHEET.md](CHEATSHEET.md) lists every shortcut, and `cheat` shows it in the terminal.

## Install

You need macOS, Homebrew and Oh My Zsh. The files expect to live in `~/dotfiles`.

```bash
git clone https://github.com/BashamL/dotfiles ~/dotfiles
~/dotfiles/install.sh
```

Then open a new terminal tab. `install.sh` is safe to run again. It:

- links `starship.toml`, the Ghostty config and the yazi config into `~/.config`, moving any existing file aside
- adds a line to `~/.zshenv`, `~/.zprofile` and `~/.zshrc` that loads its copy in `zsh/`: PATH for every shell, Homebrew for login shells, the rest for the prompt
- includes `git/gitconfig` from `~/.gitconfig`: delta for diffs, zdiff3 conflict markers and a few aliases
- installs the `Brewfile`, two Oh My Zsh plugins (fzf-tab and you-should-use), the yazi theme and the gh-dash extension
- adds `agents/machine.md` to `~/.claude/CLAUDE.md`, and copies it into `~/.codex/AGENTS.md` and `~/AGENTS.md` if they exist, so coding agents know what's installed

`agents/machine.md` describes my Mac. Edit it, or remove that part of `install.sh`, before you run it on yours.

## What's in it

| Path | What it does |
| --- | --- |
| `zsh/` | History, plugins, aliases, fzf helpers (`fe`, `rge`, `fbr`, `wt`), the `menu` launcher and Mac-style text selection on the command line |
| `starship/` | Two-line prompt. `prompt-link` makes the folder and git branch Cmd-clickable in Ghostty |
| `ghostty/` | Terminal config and a cursor-trail shader |
| `yazi/` | File manager config, opened with `y` |
| `git/gitconfig` | Git defaults and aliases |
| `agents/machine.md` | Notes for coding agents about this machine |
| `Brewfile` | The command-line tools these files use |

## Settings for one machine

`zsh/local.zsh` loads last and git ignores it. Put aliases and work shortcuts there. Define a `_menu_rows_local` function in it to add rows to the top of `menu`.

## Agent shells

When Cursor's agent terminal or Claude Code runs the shell (`CURSOR_AGENT`, `CLAUDECODE`, `AI_AGENT` or `CODEX_SANDBOX` is set), it gets a plain prompt, only the git plugin, `PAGER=cat` and `GIT_EDITOR=true`, so no command waits for a keyboard.
