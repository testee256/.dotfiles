#!/bin/bash
# set -x # enable debug
set -e # stop on error

if grep -q ".dotfiles/bashrc" ~/.bashrc ; then
    echo ./bashrc was already updated
else
    echo updating ~/.bashrc
    echo source ~/.dotfiles/bashrc >> ~/.bashrc
fi

cp -i ~/.dotfiles/copy_to_home/.inputrc ~
cp -i ~/.dotfiles/copy_to_home/.tmux.conf ~
cp -i ~/.dotfiles/copy_to_home/.tmux.conf.local ~
cp -i ~/.dotfiles/copy_to_home/.vimrc ~

