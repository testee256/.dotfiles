#!/usr/bin/env bash
# Reference: https://stackoverflow.com/questions/5188320/how-can-i-get-a-list-of-git-branches-ordered-by-most-recent-commit
set -e
if [[ $(git branch -a | grep "origin/mainline") ]]; then 
    refbr='origin/mainline'
elif [[ $(git branch -a | grep "origin/master") ]]; then
    refbr='origin/master'
else
    refbr=${DEFAULT_REF_BR}
fi
git for-each-ref --sort=-committerdate refs/remotes refs/heads \
    --format='%(refname:short)|%(HEAD)%(color:yellow)%(refname:short)|%(color:bold green)%(committerdate:relative)|%(color:blue)%(subject)|%(color:magenta)%(authorname)%(color:reset)' \
    $* | \
    while read line; do \
        branch=$(echo "${line}" | awk 'BEGIN { FS = "|" }; { print $1 }' | tr -d '*'); \
        ahead=$(git rev-list --count ${refbr}..${branch}); \
        behind=$(git rev-list --count ${branch}..${refbr}); \
        colorline=$(echo "${line}" | sed 's/^[^|]*|//');  \
        echo "${ahead}|${behind}|${colorline}" | \
        awk -F'|' -vOFS='|' '{$5=substr($5,1,70)}1' ; \
    done | \
    ( echo "Ahead|Behind||Branch|Lastcommit|Message|Author" && cat) | column -ts'|';

