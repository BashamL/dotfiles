# _cached_init <name> <file> <command...>: source what <command> prints, kept in
# ~/.cache/zsh/init/<name>.zsh until <file> (the tool's binary) is newer. Saves
# starting each tool on every new shell. Only for output that doesn't capture
# PATH or other state: `mise activate` does, so it isn't cached.
_cached_init() {
  local name=$1 stamp=$2; shift 2
  local cache="$HOME/.cache/zsh/init/$name.zsh"
  if [[ ! -s $cache || $stamp -nt $cache ]]; then
    mkdir -p "${cache:h}"
    if "$@" >| "$cache.$$" 2>/dev/null; then
      mv -f "$cache.$$" "$cache"
    else
      rm -f "$cache.$$"
      eval "$("$@")"
      return
    fi
  fi
  source "$cache"
}
