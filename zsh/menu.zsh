# menu: a clickable launcher. Click a row (or type to filter, Enter) to run it.
# Rows marked edit: put the command on your prompt to finish typing instead.
# Add your own: one _menu_row call below, then `reload`. Rows for this machine
# only go in a _menu_rows_local function in zsh/local.zsh (not tracked by git).

# _menu_row <colour> <icon codepoint> <label> <command> <description>
# Colours: work, git, files, system. Icons: Nerd Font codepoints (nerdfonts.com/cheat-sheet)
_menu_row() {
  local -A rgb=(work '203;166;247' git '166;227;161' files '137;180;250' system '250;179;135')
  printf '\e[38;2;%sm%s\e[0m  %s\t%s\t%s\n' "${rgb[$1]}" "$(print -n "\\U$2")" "$3" "$4" "$5"
}

_menu_rows() {
  (( $+functions[_menu_rows_local] )) && _menu_rows_local
  _menu_row git   0000e725 'Switch branch'             'fbr'                 'Pick a branch, newest first, with its recent commits as a preview.'
  _menu_row git    0000f407 'My PRs and reviews'        'gh dash'             'Dashboard of your pull requests and review requests. o opens one on GitHub, q quits.'
  _menu_row git    0000f09b 'Open this repo on GitHub'  'gh browse'           'Opens the current repository in your browser.'
  _menu_row git    0000e702 'lazygit'                   'lazygit'             'Stage, commit, push and branch with the keyboard. ? lists keys, q quits.'
  _menu_row files  0000f07c 'Browse files'              'y'                   'yazi file manager with previews. q quits into the folder you were in.'
  _menu_row files  0000f0f6 'Open a file in Cursor'     'fe'                  'Fuzzy-find a file here and open it in Cursor.'
  _menu_row files  0000f002 'Search code'               'edit:rge '           'Puts rge on your prompt: type what to search for, then pick a hit to open it at that line.'
  _menu_row files  0000f0a0 'What is taking up space'   'disk'                'Biggest files and folders under here.'
  _menu_row system 000f06a9 'Claude Code here'          'claude'              'Starts Claude Code in this folder.'
  _menu_row system 0000f1e6 'What is listening on ports' 'ports'              'Every program with an open port.'
  _menu_row system 0000f05e 'Stop whatever is on a port' 'edit:killport '     'Puts killport on your prompt: type the port number.'
  _menu_row system 0000f0e4 'Activity monitor'          'btop'                'CPU, memory and processes. q quits.'
  _menu_row system 0000f019 'Update everything'         'update-all'          'Homebrew, Oh My Zsh, plugins and tldr pages.'
  _menu_row system 0000f02d 'Cheat sheet'               'cheat'               'Every shortcut in this setup. q closes it.'
  _menu_row system 0000f013 'Edit dotfiles'             'dots'                'Opens ~/dotfiles in Cursor.'
  _menu_row system 0000f01e 'Reload shell'              'reload'              'Applies changes to your shell config.'
}

menu() {
  local row cmd
  row=$(_menu_rows | fzf --ansi --delimiter '\t' --with-nth 1 --no-sort \
      --height 80% --border-label ' Menu ' --border-label-pos 3 \
      --header 'click to run, or type to filter' --header-first \
      --no-info --pointer '▌' \
      --preview 'printf "%s\n\n\033[2m%s\033[0m" {3} {2}' \
      --preview-window 'down,4,wrap,border-top' \
      --bind 'left-click:accept') || return 0
  cmd=${${(ps:\t:)row}[2]}
  if [[ $cmd == edit:* ]]; then
    print -z -- "${cmd#edit:}"
    return
  fi
  print -s -- "$cmd"   # so Up-arrow can repeat it
  eval "$cmd"
}
