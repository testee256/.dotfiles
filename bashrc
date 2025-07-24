export DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
export HISTTIMEFORMAT="%y/%m/%d %T "
export HISTFILESIZE=50000
export HISTSIZE=10000
# For vim-ctrl-q to work (interactive shell only)
[[ $- == *i* ]] && stty start undef 

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

prompt_command() {
    # Merge and reload history
    history -a ; history -n

    # PS1 is the actual prompt string used
    export PS1="\u@${HOSTNAME_ALIAS:-\h}:$PWD (\t) \[\e[1;32m\]$(parse_git_branch)\[\e[00m\] \n$ "
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

# Only run this if we are inside a tmux session and it's an interactive shell
if [ -n "$TMUX" ] && [[ $- =~ i ]]; then
    # Check if the cached display file exists and is not empty
    if [ -f ~/.tmux_display_cache ] && [ -s ~/.tmux_display_cache ]; then
        CACHED_DISPLAY=$(cat ~/.tmux_display_cache)
        if [ -n "$CACHED_DISPLAY" ] && [ "$DISPLAY" != "$CACHED_DISPLAY" ]; then
            export DISPLAY="$CACHED_DISPLAY"
            # Optional: Add a message if you want to confirm it's being set
            # echo "DISPLAY updated to $DISPLAY in tmux pane."
        fi
    fi
fi

# === Function Definitions for PATH Management ===

# Check if path_prepend function is not defined before defining it.
if ! type -t path_prepend > /dev/null 2>&1 || [[ "$(type -t path_prepend)" != "function" ]]; then
  path_prepend() {
      local IFS=':' # Set Internal Field Separator to colon for this function
      # Read the colon-delimited input string into an array
      read -ra new_dirs_array <<< "$1"

      # Iterate through the directories in reverse order to maintain desired precedence when prepending
      for (( i=${#new_dirs_array[@]}-1; i>=0; i-- )); do
          local new_dir="${new_dirs_array[i]}"
          # Expand ~ to $HOME, important for consistency
          new_dir=$(eval echo "$new_dir")
          
          # Check if the directory is NOT already in PATH
          if [[ ":$PATH:" != *":$new_dir:"* ]]; then
              # Prepend the new directory to PATH.
              PATH="$new_dir${PATH:+:$PATH}"
          fi
      done
  }
fi

# Check if path_append function is not defined before defining it.
if ! type -t path_append > /dev/null 2>&1 || [[ "$(type -t path_append)" != "function" ]]; then
  path_append() {
      local IFS=':' # Set Internal Field Separator to colon for this function
      # Read the colon-delimited input string into an array
      read -ra new_dirs_array <<< "$1"

      # Iterate through the directories in the array
      for new_dir in "${new_dirs_array[@]}"; do
          # Expand ~ to $HOME, important for consistency
          new_dir=$(eval echo "$new_dir")

          # Check if the directory is NOT already in PATH
          if [[ ":$PATH:" != *":$new_dir:"* ]]; then
              # Append the new directory to PATH.
              PATH="${PATH:+"$PATH:"}$new_dir"
          fi
      done
  }
fi

path_prepend "~/.dotfiles/tools:~/bin:~/.cargo/bin"
