# Terminal cheat sheet

Press **q** or **Ctrl-C** to close this. Scroll with the trackpad or arrows. Edit everything with `dots`, apply with `reload`.

## Start here

| | |
| --- | --- |
| `menu` or Cmd-Shift-M | Clickable launcher: click a row to run it (branches, PRs, files, ports, updates) |
| Cmd-click the folder in your prompt | Opens it in Finder |
| Cmd-click the branch in your prompt | Opens it on GitHub |

## Editing the command line like a text box

| Key | What it does |
| --- | --- |
| Click | Put the cursor there |
| Shift-← / Shift-→ | Select a letter at a time |
| Shift-Option-← / → | Select a word at a time |
| Shift-Cmd-← / → | Select to the start or end |
| Backspace, Delete | Remove the selection |
| Type or Cmd-V | Replace the selection |
| Cmd-X | Cut the selection |
| Cmd-C | Copy. Selections copy themselves as you make them, mouse ones too |
| Option-← / → | Jump a word |
| Cmd-← / → | Jump to start or end |
| Option-Backspace, Cmd-Backspace | Delete a word, delete to the start |

The mouse can select and copy text anywhere, but zsh can't delete a mouse selection: use Shift-arrows for that.

## Keys that save the most time

| Key | What it does |
| --- | --- |
| `Ctrl-R` | Fuzzy search your whole history |
| `Ctrl-T` | Fuzzy pick a file and paste its path |
| `Option-C` | Fuzzy pick a folder and cd into it |
| `Tab` | Fuzzy completion menu with previews (`<` `>` switch groups) |
| `→` or `End` | Accept the grey suggestion |
| `Esc Esc` | Rerun the last command with sudo |
| Ctrl + backtick | Drop-down Ghostty from any app |

## Moving around

| Command | What it does |
| --- | --- |
| `z dot` | Jump to the folder you use most that matches "dot" |
| `zi` | Pick from your frequent folders |
| `wt` | Jump between git worktrees of this repo |
| `..` `...` | Up one or two folders |
| `take foo` | Make folder foo and cd into it |
| `dev`, `dl` | Shortcuts to Developer, Downloads |
| `ofd` | Open this folder in Finder |
| `cdf` | cd to the folder open in Finder |

## Looking at things

| Command | What it does |
| --- | --- |
| `l`, `ll` | List files with icons and git status (`ll` shows hidden) |
| `lt`, `ltt` | Tree view, 2 or 4 levels deep |
| `bat file` | `cat` with syntax highlighting |
| `fe` | Fuzzy find a file, open it in Cursor |
| `rge text` | Search inside files, open the hit in Cursor at that line |
| `fd name` | Find files by name (fast `find`) |
| `rg text` | Search inside files (fast `grep`) |
| `help tar` | Short examples for any command |
| `btop` | Activity monitor |

## Files

| Command | What it does |
| --- | --- |
| `y` | yazi file manager: arrows to move, Enter opens (text in Cursor), images preview, q quits into that folder |
| `disk` | What's taking up space in this folder |
| `md file.md` | Read Markdown nicely formatted |

In yazi: `space` selects, `y` copies, `p` pastes, `d` moves to Trash, `a` makes a file (end with `/` for a folder), `/` searches, `~` shows all keys.

## Git

| Command | What it does |
| --- | --- |
| `lg` | lazygit: stage, commit, branch, rebase with the keyboard |
| `prs` | Dashboard of your PRs and review requests (Enter for detail, `o` opens on GitHub, `?` for keys) |
| `fbr` | Fuzzy switch branch, newest first |
| `gst` | git status |
| `gco`, `gsw` | Checkout, switch |
| `gcm` | Switch to main |
| `ga`, `gaa` | Add, add all |
| `gcmsg "msg"` | Commit with message |
| `gp`, `gl` | Push, pull |
| `git lg` | Pretty history graph |
| `git recent` | Branches by last commit |
| `git undo` | Undo last commit, keep the changes |
| `git amend` | Add staged changes to the last commit |

Diffs open in delta: `n` and `N` jump between files. `alias | grep git` lists every git shortcut.
you-should-use prints a tip when you type a command that has a shortcut.

## Processes and ports

| Command | What it does |
| --- | --- |
| `ports` | Everything listening |
| `port 3000` | What's on 3000 |
| `killport 3000` | Stop it |
| `fkill` | Fuzzy pick processes to kill (Tab selects several) |

## Ghostty

| Key | What it does |
| --- | --- |
| `Cmd-Shift-P` | Command palette: search every Ghostty action |
| `Cmd-D`, `Cmd-Shift-D` | Split right, split down |
| `Cmd-Option-arrows` | Move between splits |
| `Cmd-Ctrl-arrows` | Resize a split (`Cmd-Ctrl-=` evens them out) |
| `Cmd-Shift-Enter` | Zoom a split |
| `Cmd-T`, `Cmd-W` | New tab, close |
| `Cmd-Shift-,` | Reload config |

A command that runs 30s or more in a tab you're not looking at sends a macOS notification when it finishes.
The cursor streaks when it jumps: `~/dotfiles/ghostty/shaders/cursor-trail.glsl` (change `DURATION` and `OPACITY` at the top).

## Upkeep

| Command | What it does |
| --- | --- |
| `update-all` | Upgrade Homebrew, Oh My Zsh, plugins, tldr pages |
| `extract file.zip` | Unpack any archive |
| `path` | Show PATH one entry per line |
| `ZPROF=1 zsh -i -c exit` | Find what makes the shell slow to start |

## Where things live

| File | What it is |
| --- | --- |
| `~/dotfiles/zsh/zshrc` | Oh My Zsh, plugins, history |
| `~/dotfiles/zsh/zshenv`, `zprofile` | PATH: mise shims and `~/.local/bin` ahead of Homebrew |
| `~/dotfiles/zsh/brew.zsh` | Homebrew upgrade every 3 days in the background |
| `~/dotfiles/zsh/aliases.zsh` | Shortcuts |
| `~/dotfiles/zsh/functions.zsh` | fe, rge, fbr, wt, fkill, port |
| `~/dotfiles/zsh/menu.zsh` | The `menu` launcher: add a row to add a button |
| `~/dotfiles/zsh/editing.zsh` | Selecting text on the command line |
| `~/dotfiles/starship/prompt-link` | The clickable folder and branch in the prompt |
| `~/dotfiles/zsh/tools.zsh` | Starship, zoxide, fzf |
| `~/dotfiles/zsh/toolchains.zsh` | mise, bun, LM Studio |
| `~/dotfiles/zsh/local.zsh` | Extras for this machine only (aliases, menu rows), not tracked by git |
| `~/dotfiles/starship/starship.toml` | Prompt |
| `~/dotfiles/ghostty/config.ghostty` | Terminal |
| `~/dotfiles/yazi/` | File manager |
| `~/dotfiles/git/gitconfig` | Git defaults and aliases |
| `~/.dotfiles-backup/20261029/` | Your config from before today |
