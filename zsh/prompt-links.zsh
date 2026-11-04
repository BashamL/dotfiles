# The folder and git branch in the prompt as OSC 8 links, so Cmd-click in Ghostty
# opens them: the folder in Finder, the branch on GitHub. Built before each prompt
# in zsh, reading .git directly, so they start no process. Starship shows them
# through its env_var modules (PROMPT_LINK_DIR, PROMPT_LINK_BRANCH).
#
# Starship marks each escape code as zero-width for zsh by reading from ESC up to
# the next "m". So each link code here is followed by a colour code (which ends in
# "m"), and URLs carry no lowercase "m": hosts are upper-cased, and paths write
# it as %6D. Both still open the same place.

# _prompt_link <url> <text> <colour sgr>, into $REPLY
_prompt_link() {
  local url=${1//\%/%25}
  url=${url// /%20}
  url=${url//m/%6D}
  REPLY=$'\e]8;;'$url$'\e\\\e['$3m$2$'\e]8;;\e\\\e[0m'
}

_prompt_links() {
  local blue='1;38;2;137;180;250' green='1;38;2;166;227;161'
  local top=$PWD start rest gitdir common head branch remote line origin=0
  local -a parts mtime
  while [[ -n $top && ! -e $top/.git ]]; do top=${top%/*}; done
  _prompt_repo=$top   # for prompt-git.zsh

  if [[ -n $top ]]; then
    # Inside a repo: repo name, then the path below it
    start=${top:t} rest=${PWD#"$top"}
  elif [[ $PWD == $HOME(|/*) ]]; then
    start='~' rest=${PWD#"$HOME"}
  else
    start= rest=$PWD
  fi
  # Long paths keep where they start and the last 2 folders
  parts=(${(s:/:)rest})
  (( $#parts > 3 )) && rest="/…/$parts[-2]/$parts[-1]"
  _prompt_link "file://$PWD" "$start$rest" $blue
  export PROMPT_LINK_DIR=$REPLY

  unset PROMPT_LINK_BRANCH
  [[ -n $top ]] || return

  # A worktree's or submodule's .git is a file naming its git dir
  gitdir=$top/.git
  if [[ -f $gitdir ]]; then
    gitdir=${"$(<$gitdir)"#gitdir: }
    [[ $gitdir == /* ]] || gitdir=$top/$gitdir
  fi
  [[ -r $gitdir/HEAD ]] || return
  head=$(<$gitdir/HEAD)
  if [[ $head != 'ref: refs/heads/'* ]]; then
    export PROMPT_LINK_BRANCH=$'\e['${green}m$(git rev-parse --short HEAD 2>/dev/null)$'\e[0m'   # detached HEAD
    return
  fi
  branch=${head#ref: refs/heads/}

  # origin's url from the config the repo's worktrees share
  common=$gitdir
  if [[ -r $gitdir/commondir ]]; then
    common=$(<$gitdir/commondir)
    [[ $common == /* ]] || common=$gitdir/$common
  fi
  # A repo with many worktrees has a long config, so keep the url until it changes
  if [[ -r $common/config ]] && zstat -A mtime +mtime $common/config 2>/dev/null; then
    if [[ ${_prompt_origin_seen[$common]} == $mtime ]]; then
      remote=${_prompt_origin_url[$common]}
    else
      for line in "${(@f)"$(<$common/config)"}"; do
        line=${line//[[:space:]]/}
        if [[ $line == '['* ]]; then
          [[ $line == '[remote"origin"]' ]] && origin=1 || origin=0
        elif (( origin )) && [[ $line == url=* ]]; then
          remote=${line#url=}
          break
        fi
      done
      _prompt_origin_seen[$common]=$mtime
      _prompt_origin_url[$common]=$remote
    fi
  fi

  case $remote in
    git@github.com:*) remote=${remote#git@github.com:} ;;
    https://github.com/*) remote=${remote#https://github.com/} ;;
    *)
      export PROMPT_LINK_BRANCH=$'\e['${green}"m $branch"$'\e[0m'
      return
      ;;
  esac
  _prompt_link "HTTPS://GITHUB.COM/${remote%.git}/tree/$branch" " $branch" $green
  export PROMPT_LINK_BRANCH=$REPLY
}

zmodload -F zsh/stat b:zstat
typeset -gA _prompt_origin_seen _prompt_origin_url
autoload -Uz add-zsh-hook
add-zsh-hook precmd _prompt_links
