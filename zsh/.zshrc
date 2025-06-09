# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# # Set the directory we want to store zinit and plugins
# ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
#
# # Download zinit, if it is not installed yet
# if [ ! -d "$ZINIT_HOME" ]; then
#   mkdir -p "$(dirname $ZINIT_HOME)"
#   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
# fi
#
# # Load zinit
# source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
# zinit ice lucid wait'0'
zinit light joshskidmore/zsh-fzf-history-search
zinit light Aloxaf/fzf-tab

# Keybinding (run 'cat' to determin the code)
bindkey "^[[1;3D" backward-word # Move one word left with Option-left
bindkey "^[[1;3C" forward-word # Move one word right with Option-right
bindkey "^[[1;3A" history-search-backward # Search history for the same command backward with Option-up
bindkey "^[[1;3B" history-search-forward # Search history for the same command forward with Option-down

# History
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase # Duplicates will be erased from History
setopt appendhistory # Append commands to the history file
setopt sharehistory # Share history between shells
setopt hist_ignore_space # Ignore commandlines that start with space
setopt hist_ignore_all_dups # Ignore all duplicates in historical searches
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # Completion macthes both upper and lower cases
zstyle ':completion:*' list-colors '${(s.:.)LS_COLORS}' # Add colors to completion lists
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# Add in snippets from oh-my-zshell
zinit snippet OMZP::git
zinit snippet OMZP::python
zinit snippet OMZP::command-not-found

# Load zsh-completions
autoload -U compinit && compinit

zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Aliases
alias ls='ls --color'
alias l="eza -lah"
alias cat="bat --color=always"
alias fb="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
alias lz="lazygit"
alias occ="sudo -u www-data php /var/www/html/nextcloud/occ"
# alias raspi="/usr/bin/git --git-dir=$HOME/.raspi/ --work-tree=$HOME"

# fzf costumizations
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse'
# export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

# Additions to PATH
# export PATH=$HOME/bin:/usr/local/bin:$HOME/.local/bin:$PATH

# Zoxide
eval "$(zoxide init --cmd cd zsh)"

# yazi
# function yy() {
# 	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
# 	yazi "$@" --cwd-file="$tmp"
# 	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
# 		cd -- "$cwd"
# 	fi
# 	rm -f -- "$tmp"
# }


. "$HOME/.local/bin/env"
