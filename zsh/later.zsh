# zsh_later <file...>: source the files once the first prompt is on screen, the
# first time the line editor is idle, then run the precmd hooks they added and
# redraw the prompt. Keys typed meanwhile wait and are handled after.
#
# The files run inside a function: `typeset` without -g at their top level makes
# a local. Oh My Zsh and the plugins here only do that for load-time scratch.

zsh_later() {
  _zsh_later_files+=("$@")
  local fd
  exec {fd}</dev/null   # always readable, so zle calls the handler when idle
  zle -F $fd _zsh_later_run
}

_zsh_later_run() {
  local _zsh_later_fd=$1 _zsh_later_file _zsh_later_hook
  local -a _zsh_later_hooks=($precmd_functions)
  zle -F $_zsh_later_fd
  exec {_zsh_later_fd}<&-

  for _zsh_later_file in $_zsh_later_files; do
    source "$_zsh_later_file" >/dev/null 2>&1
  done
  _zsh_later_files=()

  # Only the new hooks: one that starts zle -F work from here (prompt-git.zsh)
  # wouldn't be polled until the next key
  for _zsh_later_hook in ${precmd_functions:|_zsh_later_hooks}; do
    $_zsh_later_hook
  done
  zle reset-prompt
  zle -R
}

typeset -ga _zsh_later_files
