#!/bin/bash

# Get the current DISPLAY from the SSH connection
CURRENT_DISPLAY=$(echo $DISPLAY)

# Store the current DISPLAY value for future use by shell startup files
echo "$CURRENT_DISPLAY" > ~/.tmux_display_cache

# This line updates the tmux environment for *tmux commands*, not necessarily shells
tmux set-environment -g DISPLAY "$CURRENT_DISPLAY"

