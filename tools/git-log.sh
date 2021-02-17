#!/usr/bin/env bash
set -e
git log --graph --pretty=format:'%<|(20)%C(magenta)%h%Creset %C(dim green)%cd %C(cyan)%<(15,trunc)%an%Creset %s %C(red)%d%Creset' --date=format:'%y-%m-%d %H:%M:%S' $*

