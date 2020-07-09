echo -n "SESSION [" $USER_SESSION "] logging out from " `pwd` " on ">> ~/.session.log
date >> ~/.session.log
if [ ! -z "${USER_SESSION}" ]; then
    export HISTFILE=~/.bash_history.${USER_SESSION}
    # history -n
    # history -w
    # echo "history saved to " ${HISTFILE} >> ~/.session.log
    if test -f "~/.bash_logout.${USER_SESSION}"; then
        echo Loading "~/.bash_logout${USER_SESSION}"
        source "~/.bash_logout.${USER_SESSION}"
    fi
fi

