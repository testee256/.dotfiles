#!/bin/bash

set -e

(
cd ~/.dotfiles
git fetch -a
git reset --hard origin/master
source ~/.dotfiles/docs/inst_dotfiles.sh
)

