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
fi

