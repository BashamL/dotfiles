# Git's file counts in the prompt, filled in after it draws. `git status` takes
# most of the prompt's time in a big repo, so Starship draws without it and
# `starship module git_status` runs in the background; its result redraws the
# prompt through PROMPT_GIT_STATUS. The last counts for the same repo show
# until then.

_prompt_git_fd=0

_prompt_git_cancel() {
  (( _prompt_git_fd )) || return 0
  zle -F $_prompt_git_fd 2>/dev/null
  exec {_prompt_git_fd}<&-
  _prompt_git_fd=0
}

_prompt_git_start() {
  _prompt_git_cancel
  if [[ -z $_prompt_repo ]]; then
    unset PROMPT_GIT_STATUS _prompt_git_repo
    return
  fi
  [[ $_prompt_repo == ${_prompt_git_repo-} ]] || unset PROMPT_GIT_STATUS
  _prompt_git_repo=$_prompt_repo
  exec {_prompt_git_fd}< <(STARSHIP_SHELL= starship module git_status 2>/dev/null)
  zle -F $_prompt_git_fd _prompt_git_done
}

_prompt_git_done() {
  local fd=$1 out
  # Starship prints the module in one write; waiting for EOF instead can stall
  # the line editor for a few hundred ms
  sysread -i $fd out 2>/dev/null
  zle -F $fd
  exec {fd}<&-
  (( fd == _prompt_git_fd )) || return 0
  _prompt_git_fd=0
  [[ ${+PROMPT_GIT_STATUS} == 1 && $out == $PROMPT_GIT_STATUS ]] && return
  export PROMPT_GIT_STATUS=$out
  zle reset-prompt
}

zmodload -F zsh/system b:sysread
autoload -Uz add-zsh-hook
add-zsh-hook precmd _prompt_git_start
add-zsh-hook preexec _prompt_git_cancel
