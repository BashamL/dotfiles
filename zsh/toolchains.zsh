# Language toolchains. These lived in ~/.zshrc before Oh My Zsh replaced it
# (old copy: ~/.dotfiles-backup/20261029/.zshrc.pre-oh-my-zsh).

# mise: switch Node etc. per folder (.node-version, mise.toml)
eval "$(/opt/homebrew/bin/mise activate zsh)"

# mise's own precmd hook starts mise (about 20 ms) before every prompt. Its cd
# hook stays; past that, refresh only after a command that runs mise or git,
# which can change the versions a folder pins.
if (( $+functions[_mise_hook_precmd] && $+functions[_mise_hook] )); then
  add-zsh-hook -d precmd _mise_hook_precmd
  _mise_mark_refresh() {
    [[ " $2" == *[[:space:]\;\&\|\(](mise|git)([[:space:]]*|) ]] && _mise_refresh=1
  }
  _mise_refresh_precmd() {
    (( _mise_refresh )) || return 0
    _mise_refresh=0
    _mise_hook --reason precmd
  }
  add-zsh-hook preexec _mise_mark_refresh
  add-zsh-hook precmd _mise_refresh_precmd
fi

# bun
export BUN_INSTALL="$HOME/.bun"
path=("$BUN_INSTALL/bin" $path)
[[ -s "$BUN_INSTALL/_bun" ]] && source "$BUN_INSTALL/_bun"

# Ruby comes from mise too. Don't add `rbenv init`: with both on PATH and no
# version set, rbenv and mise hand `ruby` back and forth forever.

# libpq headers for native gem builds (sequel_pg)
export LDFLAGS="-L/opt/homebrew/opt/libpq/lib"
export CPPFLAGS="-I/opt/homebrew/opt/libpq/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/libpq/lib/pkgconfig"
path+=("/opt/homebrew/opt/libpq/bin")

# LM Studio CLI (lms)
path+=("$HOME/.lmstudio/bin")
