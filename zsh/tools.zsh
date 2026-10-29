# Prompt, jumping, fuzzy finding

# Starship prompt (~/.config/starship.toml); agents get a plain one
if [[ -n $AGENT_SHELL ]]; then
  PROMPT='%~ %# '
else
  eval "$(starship init zsh)"
fi

# zoxide: `z proj` jumps to the most-used folder matching "proj", `zi` picks interactively
eval "$(zoxide init zsh)"

# fzf: Ctrl-R history, Ctrl-T files, Option-C folders
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --exclude node_modules'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git --exclude node_modules'
export FZF_DEFAULT_OPTS="
  --height 60% --layout reverse --border rounded --info inline-right
  --prompt '❯ ' --pointer '▶' --marker '✓'
  --color=bg+:#313244,bg:-1,spinner:#f5e0dc,hl:#f38ba8
  --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc
  --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
  --color=selected-bg:#45475a,border:#6c7086,label:#cdd6f4"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=numbers --line-range :300 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --level 2 --color=always --icons {}'"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:wrap"
source <(fzf --zsh)

# fzf-tab: Tab opens a fuzzy menu with previews
zstyle ':completion:*' menu no
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab:*' switch-group '<' '>'
zstyle ':fzf-tab:complete:(cd|__zoxide_z):*' fzf-preview 'eza -1 --color=always --icons $realpath'
zstyle ':fzf-tab:complete:(cat|bat|less|cursor|code):*' fzf-preview 'bat --color=always --style=numbers --line-range :200 $realpath 2>/dev/null || eza -1 --color=always --icons $realpath'
