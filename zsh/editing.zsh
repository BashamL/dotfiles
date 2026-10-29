# Mac-style editing on the command line:
#   Shift+←/→ select by letter, Shift+Option+←/→ by word, Shift+Cmd+←/→ to start or end
#   Backspace or Delete removes the selection, typing or pasting replaces it
#   Cmd+X cuts it; a selection is copied to the clipboard as you make it (like mouse selection)
# Cmd+←/→, Option+←/→ and Cmd+Backspace come from Ghostty's defaults.
[[ -n $AGENT_SHELL ]] && return

zle_highlight=(region:bg=#45475a paste:none)

_sel_bounds() { reply=($(( MARK < CURSOR ? MARK : CURSOR )) $(( MARK > CURSOR ? MARK : CURSOR ))) }
_sel_copy() {
  (( REGION_ACTIVE )) || return 0
  local reply; _sel_bounds
  print -rn -- "${BUFFER[reply[1]+1,reply[2]]}" | pbcopy
}

# select-<motion>: start the selection if there isn't one, then move
for _m in backward-char forward-char backward-word forward-word beginning-of-line end-of-line; do
  eval "_select-$_m() { (( REGION_ACTIVE )) || { MARK=\$CURSOR; REGION_ACTIVE=1 }; zle .$_m; _sel_copy }"
  zle -N select-$_m _select-$_m
done
unset _m

# Any other key ends the selection, so a plain arrow just moves
_sel_end_on_other_keys() { [[ $LASTWIDGET == select-* ]] || REGION_ACTIVE=0 }
autoload -Uz add-zle-hook-widget
add-zle-hook-widget zle-line-pre-redraw _sel_end_on_other_keys

# Wrap whatever already handles these keys (Oh My Zsh quotes URLs as you type and paste)
_sel_wrap() {
  local name=$1 builtin=$2 prev=${widgets[$1]}
  if [[ $prev == user:* ]]; then
    eval "_sel_prev_$name() { ${prev#user:} \"\$@\" }"
  else
    eval "_sel_prev_$name() { zle .$builtin -- \"\$@\" }"
  fi
}
_sel_wrap self-insert self-insert
_sel_wrap bracketed-paste bracketed-paste

_sel_self_insert() { (( REGION_ACTIVE )) && zle .kill-region; _sel_prev_self-insert "$@" }
_sel_paste() { (( REGION_ACTIVE )) && zle .kill-region; _sel_prev_bracketed-paste "$@" }
_sel_backspace() { if (( REGION_ACTIVE )); then zle .kill-region; else zle .backward-delete-char; fi }
_sel_delete() { if (( REGION_ACTIVE )); then zle .kill-region; else zle .delete-char; fi }
_sel_cut() { (( REGION_ACTIVE )) || return 0; _sel_copy; zle .kill-region }

zle -N self-insert _sel_self_insert
zle -N bracketed-paste _sel_paste
zle -N backward-delete-char _sel_backspace
zle -N delete-char _sel_delete
zle -N select-cut _sel_cut

# ←/→ with a selection jump to its start or end, like any Mac text field
_sel_left() {
  if (( REGION_ACTIVE )); then local reply; _sel_bounds; CURSOR=$reply[1]; REGION_ACTIVE=0
  else zle backward-char; fi
}
_sel_right() {
  if (( REGION_ACTIVE )); then local reply; _sel_bounds; CURSOR=$reply[2]; REGION_ACTIVE=0
  else zle .forward-char; fi
}
ZSH_AUTOSUGGEST_ACCEPT_WIDGETS+=(sel-right)   # → still accepts the grey suggestion
zle -N sel-left _sel_left
zle -N sel-right _sel_right
bindkey '^[[D' sel-left
bindkey '^[OD' sel-left
bindkey '^[[C' sel-right
bindkey '^[OC' sel-right

bindkey '^[[1;2D' select-backward-char         # Shift+←
bindkey '^[[1;2C' select-forward-char          # Shift+→
bindkey '^[[1;4D' select-backward-word         # Shift+Option+←
bindkey '^[[1;4C' select-forward-word          # Shift+Option+→
bindkey '^[[1;10D' select-beginning-of-line    # Shift+Cmd+← (sent by Ghostty)
bindkey '^[[1;10C' select-end-of-line          # Shift+Cmd+→ (sent by Ghostty)
bindkey '^[[120;9u' select-cut                 # Cmd+X (sent by Ghostty)
