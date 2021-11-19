# ~/.bash_logout: executed by bash(1) when login shell exits.

# when leaving the console clear the screen to increase privacy

if [ "$SHLVL" = 1 ]; then
    [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
fi
echo -n "SESSION [" $USER_SESSION "] logout from " `pwd` " at ">> ~/.session.log
date >> ~/.session.log
if [ ! -z "${USER_SESSION}" ]; then
    export HISTFILE=~/.bash_history.${USER_SESSION}
    # history -n
    # history -w
    # echo "history saved to " ${HISTFILE} >> ~/.session.log
    if [ -f ~/.bash_logout.${USER_SESSION} ]; then
        source ~/.bash_logout.${USER_SESSION}
    fi
    echo cd $(pwd) > ~/.bash_login.${USER_SESSION}
    chmod +x ~/.bash_login.${USER_SESSION}
fi

