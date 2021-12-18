#!/usr/bin/env bash
set -e
git checkout "$(git branch -a --sort=committerdate | fzf| tr -d '[:space:]')"

