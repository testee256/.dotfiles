export PATH=~/bin:$HOME/.cargo/bin:$PATH
export DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
export HISTTIMEFORMAT="%d/%m/%y %T "
stty start undef # for vim-ctrl-q to work

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

function prompt_command {
    # Merge and reload history
    history -a ; history -n

    # PS1 is the actual prompt string used
    export PS1='\u@\h:$PWD (\t) \[\e[1;32m\]$(parse_git_branch)\[\e[00m\] \n$ '
}
# PROMPT_DIRTRIM=3

# PROMPT_COMMAND is a command that is executed just before the prompt
export PROMPT_COMMAND=prompt_command

