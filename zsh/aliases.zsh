# Aliases. Built-in names (ls, cat, grep, cd) are left alone on purpose:
# Claude Code and Cursor reuse this shell, and their scripts expect the originals.

# Listing (eza)
alias l='eza -lh --icons=auto --git --group-directories-first'
alias ll='eza -lah --icons=auto --git --group-directories-first'
alias la='ll'
alias lt='eza --tree --level=2 --icons=auto --git-ignore'
alias ltt='eza --tree --level=4 --icons=auto --git-ignore'

# Places
alias dev='cd ~/Developer'
alias dl='cd ~/Downloads'

# Config
alias dots='cursor ~/dotfiles'
alias reload='exec zsh'

# Tools
alias lg='lazygit'
alias p='pnpm'
alias cl='claude'
alias help='tldr'
alias prs='gh dash'          # your PRs and review requests
alias disk='dust -r -n 25'   # what's taking up space here

# System
alias ports='lsof -iTCP -sTCP:LISTEN -n -P'
alias path='print -l $path'
alias flushdns='sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder'
