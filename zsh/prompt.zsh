# Starship prompt (~/.config/starship.toml); agents get a plain one
if [[ -n $AGENT_SHELL ]]; then
  PROMPT='%~ %# '
  return
fi

_cached_init starship $commands[starship] starship init zsh --print-full-init
source "$DOTFILES/zsh/prompt-links.zsh"
source "$DOTFILES/zsh/prompt-git.zsh"

# The clock on the right, drawn by zsh: `starship prompt --right` would start a
# second Starship before every prompt just for it.
RPROMPT=$'%{\e[38;2;127;132;156m%}%D{%H:%M}%{\e[0m%}'
