# Editors, pagers and colours

export EDITOR="cursor --wait"
export VISUAL="$EDITOR"
# less shows git log, diffs, man pages and `cheat`: colours, skip it when the text
# fits one screen, smart-case search, Ctrl-C closes it, and the bottom line says how
export LESS='-R -F -i -K -Ps q or Ctrl-C to close, trackpad or arrows to scroll ?pB(%pB\%).$'
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export BAT_THEME="Catppuccin Mocha"
export HOMEBREW_NO_ENV_HINTS=1
export HOMEBREW_NO_ASK=1                 # install/upgrade without a y/n prompt

if [[ -n $AGENT_SHELL ]]; then
  export PAGER=cat GIT_PAGER=cat GH_PAGER=cat MANPAGER=cat AWS_PAGER=""
  export BAT_PAGING=never
  export EDITOR=true VISUAL=true GIT_EDITOR=true   # merges and rebases take the default message
fi
