#!/usr/bin/env bash
set -e

[[ -z "$1" ]] && { 
    echo "usage: $(basename $0) BRANCH [REMOTE=origin]";
    echo "- reset to $REMOTE/$BRNCH"
    exit 1;
}
BRANCH=$1
REMOTE=$2
[[ -z "$REMOTE" ]] && REMOTE="origin"

echo "The following operations will be performed:"
echo "  git checkout $BRANCH"
echo "  git fetch $REMOTE"
echo "  git reset --hard $REMOTE/$BRANCH"
echo "  git clean -fdx"

# wait for one char (-n 1) and accept back slashes (-r)
read -p "Do you want to continue (y/n)? " -n 1 -r
echo REPLY=$REPLY
if [[ "$REPLY" != "y" ]]; then
    echo "aborted"
    exit 1
fi

git checkout $BRANCH
git fetch $REMOTE
git reset --hard $REMOTE/$BRANCH
git clean -fdx

