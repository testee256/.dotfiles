export PATH=~/.dotfiles/tools:~/bin:$HOME/.cargo/bin:$PATH
export DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
export HISTTIMEFORMAT="%d/%m/%y %T "

# For vim-ctrl-q to work (interactive shell only)
[[ $- == *i* ]] && stty start undef 

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

prompt_command() {
    # Merge and reload history
    # history -a ; history -n

    # PS1 is the actual prompt string used
    export PS1="\u@\h:$PWD (\t) \[\e[1;32m\]$(parse_git_branch)\[\e[00m\] \n$ "
}
# PROMPT_DIRTRIM=3

# PROMPT_COMMAND is a command that is executed just before the prompt
export PROMPT_COMMAND=prompt_command

session_start () {
    export USER_SESSION=$1
    echo Session $USER_SESSION is started
    echo -n "SESSION [" $USER_SESSION "] login at " >> ~/.session.log
    date >> ~/.session.log
    if [ ! -z "${USER_SESSION}" ]; then
        echo Loading history from ~/.bash_history.${USER_SESSION}
        # clear history
        export HISTFILE=~/.bash_history.${USER_SESSION}
        history -c
        # load history from session history
        history -r
        if [ -f ~/.bash_login.${USER_SESSION} ]; then
            echo Loading "~/.bash_login.${USER_SESSION}"
            source ~/.bash_login.${USER_SESSION}
        fi
        echo -n "SESSION [" $USER_SESSION "] logging in on ">> ~/.session.log.${USER_SESSION}
        date >> ~/.session.log.${USER_SESSION}
    fi
}

gch() {
    git checkout "$(git branch --all | fzf | tr -d '[:space:]')"
}
