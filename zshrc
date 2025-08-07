bindkey "\e[A" history-search-backward
bindkey "\e[B" history-search-forward

# Function to parse Git branch name
parse_git_branch() {
    git branch 2>/dev/null | sed -n '/\* /s/\* \(.*\)/(\1)/p'
}

# Set the prompt
autoload -Uz add-zsh-hook

# Function to be run before the prompt
precmd() {
    # Merge and reload history
    fc -R

    # Set PS1 (prompt string)
    # export PS1="%n@%m:%~ ($(date +'%H:%M:%S')) %F{green}$(parse_git_branch)%f
    export PS1="%n@mac-jun:%~ ($(date +'%H:%M:%S')) %F{green}$(parse_git_branch)%f
~ "
}

# Optional: You can limit the depth of directories shown in the prompt
# This is equivalent to PROMPT_DIRTRIM in bash
# Uncomment the line below to trim the path
# export PROMPT_DIRTRIM=3

# Set the history file location
HISTFILE=~/.zsh_history

# Set the maximum number of commands to remember
HISTSIZE=10000
SAVEHIST=10000

# Share history across all sessions
setopt SHARE_HISTORY

function fzf_open_persistent() {
    local cmd="$1"
    shift
    while true; do
        local selection=$($cmd "$@" | fzf --multi --preview 'eza -l --color=always {}' --bind 'ctrl-o:execute(open {})+reload($cmd '"$@"')')
        if [[ -z "$selection" ]]; then
            break
        fi
        echo "Opening: $selection"
        open "$selection"
    done
}

alias ezo='fzf_open_persistent eza'
alias fdo='fzf_open_persistent fd'
alias ctags="/opt/homebrew/bin/ctags"

