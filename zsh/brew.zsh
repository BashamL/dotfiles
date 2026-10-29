# Homebrew: refresh its package list at most every 3 days, and once every
# 3 days upgrade what's installed, in the background when a shell starts.
# Log: ~/Library/Logs/brew-auto-upgrade.log. Delete the stamp to run it now.
export HOMEBREW_AUTO_UPDATE_SECS=259200
[[ -n $AGENT_SHELL ]] && return

() {
  local stamp="$HOME/.cache/brew-auto-upgrade.stamp"
  local log="$HOME/Library/Logs/brew-auto-upgrade.log"
  local fresh=( $stamp(Nmm-4320) )
  (( $#fresh )) && return
  mkdir -p "${stamp:h}" && touch "$stamp"
  {
    print "=== $(date '+%Y-%m-%d %H:%M')"
    /opt/homebrew/bin/brew update && /opt/homebrew/bin/brew upgrade && /opt/homebrew/bin/brew cleanup
  } </dev/null >>"$log" 2>&1 &!
}
