#!/usr/bin/env bash
if [ -n "$TMUX" ]; then
    TMUX_DISPLAY=$(tmux show-environment | grep '^DISPLAY=')
    if [ -n "$TMUX_DISPLAY" ]; then
        export DISPLAY=$(echo "$TMUX_DISPLAY" | cut -d '=' -f2)
    fi
fi


if [ -z "$1" ]; then
    # $ is empty
    xclip -selection clipboard
else
    xclip -selection clipboard < $1
fi

