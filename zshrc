# Basic setup
# zmodload zsh/zprof
typeset -U PATH
autoload colors; colors;

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"


ZSH_THEME="robbyrussell"

plugins=(git zsh-autosuggestions asdf)

source $ZSH/oh-my-zsh.sh


#########
# Aliases
#########

# Edit/Source bash config
alias ez='vim ~/.zshrc'
alias sz='source ~/.zshrc'
# Git
alias gst='git status'
alias s='git status'
alias gaa='git add -A'
alias gc='git commit'
alias gcmai='git checkout main'
alias gcmas='git checkout master'
alias gd='git diff'
alias gdc='git diff --cached'

# Branch checkout with fuzzy search (Ensure fzf is installed)
# [f]uzzy check[o]ut
fo() {
  git branch --no-color --sort=-committerdate --format='%(refname:short)' | fzf --header 'git checkout' | xargs git checkout
}

alias up='git push'
alias upf='git push --force'
alias pu='git pull'
alias pur='git pull --rebase'
alias fe='git fetch'
alias re='git rebase'
alias lr='git l -30'
alias cdr='cd $(git rev-parse --show-toplevel)' # cd to git root

# Go
alias got='go test ./...'

# golang
export GOROOT="/usr/local/go"
export GOPATH="$HOME/.go"
export GOBIN="$GOPATH/bin"
export PATH="$PATH:$GOROOT/bin:$GOBIN"

# fzf
if type fzf &> /dev/null && type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*" --glob "!vendor/*"'
  export FZF_CTRL_T_COMMAND='rg --files --hidden --follow --glob "!.git/*" --glob "!vendor/*"'
  export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
fi
# Find a file with fzf and pipe its output to nvim
vf() {
  nvim "$(fzf)"
}

# Use find + fzf + batcat to give a quickk preview of files in the dir in search
searchdir() {
    # Default to current directory if no argument provided
    local dir="${1:-.}"
    local ext="${2:-}"
    
    # Construct the find command with file extension support
    if [ -n "$ext" ]; then
        # If extension is provided, search for files with that extension
        find "$dir" -type f \
            ! -path '*/\.*git/*' \
            ! -path '*/\node_modules/*' \
            ! -path '*/\venv/*' \
            -name "*.$ext" \
        | fzf --preview 'batcat --style=numbers --color=always {} 2>/dev/null || cat {}' \
            --preview-window=right:60% \
            --bind 'ctrl-/:change-preview-window(down|hidden|)' \
            --height=80%
    else
        # If no extension provided, search all files
        find "$dir" -type f \
            ! -path '*/\.*git/*' \
            ! -path '*/\node_modules/*' \
            ! -path '*/\venv/*' \
        | fzf --preview 'batcat --style=numbers --color=always {} 2>/dev/null || cat {}' \
            --preview-window=right:60% \
            --bind 'ctrl-/:change-preview-window(down|hidden|)' \
            --height=80%
    fi
}

# tmux
alias tma='tmux attach -t'
alias tmn='tmux new -s'
alias tms='tmux source ~/.tmux.conf'
alias tmm='tmux new -s main'
alias tmr='pgrep -vx tmux > /dev/null && \
        tmux new -d -s delete-me && \
        tmux run-shell ~/.tmux/plugins/tmux-resurrect/scripts/restore.sh && \
        tmux kill-session -t delete-me && \
        tmux attach || tmux attach'

if type nvim &> /dev/null; then
  alias vim="nvim"
  export EDITOR="nvim"
  export PSQL_EDITOR="nvim -c"set filetype=sql""
  export GIT_EDITOR="nvim"
else
  export EDITOR='vim'
  export PSQL_EDITOR='vim -c"set filetype=sql"'
  export GIT_EDITOR='vim'
fi

# Speed up completion init, see: https://gist.github.com/ctechols/ca1035271ad134841284
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

mkdircd() {
  mkdir -p $1 && cd $1
}

# PROMPT
# Allow zsh to evaluate commands in PROMPT variable dynamically
setopt prompt_subst

# Provide information about the current git repo
git_prompt_info() {
  local dirstatus=" OK"
  local dirty="%{$fg_bold[red]%} X%{$reset_color%}"

  if [[ ! -z $(git status --porcelain 2> /dev/null | tail -n1) ]]; then
    dirstatus=$dirty
  fi

  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  echo " %{$fg_bold[green]%}${ref#refs/heads/}$dirstatus%{$reset_color%} "
}

local dir_info_color="%B"

local dir_info_color_file="${HOME}/.zsh.d/dir_info_color"
if [ -r ${dir_info_color_file} ]; then
  source ${dir_info_color_file}
fi

# Display the cwd and shorten it if it is too long
local dir_info="%{$dir_info_color%}%(5~|%-1~/.../%2~|%4~)%{$reset_color%}"
local promptnormal="φ %{$reset_color%}"
local promptjobs="%{$fg_bold[red]%}φ %{$reset_color%}"

PROMPT='${dir_info}$(git_prompt_info) ${nix_prompt}%(1j.$promptjobs.$promptnormal)'

simple_prompt() {
  local prompt_color="%B"
  export PROMPT="%{$prompt_color%}$promptnormal"
}

# zprof

. "$HOME/.atuin/bin/env"
if type atuin &> /dev/null; then
  eval "$(atuin init zsh)"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export ZED_ALLOW_EMULATED_GPU=1
export COLORTERM=truecolor
PATH="$PATH":"$HOME/.local/scripts/"


