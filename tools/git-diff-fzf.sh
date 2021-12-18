#!/usr/bin/env bash
set -e
git diff $@ --name-only | fzf -m --ansi --preview "git diff $@ --color=always -- {-1}"
