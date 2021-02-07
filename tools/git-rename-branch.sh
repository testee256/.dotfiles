#!/usr/bin/env bash
set -e

[[ -z "$1" ]] && { 
    echo "usage: $(basename $0) BR_OLD BR_NEW [REMOTE=origin]";
    echo "- rename BR_OLD to BR_NEW, and push to REMOTE"
    exit 1;
}
BR_OLD=$1
BR_NEW=$2
REMOTE=$3
[[ -z "$REMOTE" ]] && REMOTE="origin"

echo "The following operations will be performed:"
echo "    git checkout $BR_OLD"
echo "    git branch -m $BR_NEW"
echo "    git push $REMOTE -u $BR_NEW"
echo "    git push $REMOTE --delete $BR_OLD"

# wait for one char (-n 1) and accept back slashes (-r)
read -p "Do you want to continue (y/n)? " -n 1 -r
echo REPLY=$REPLY
if [[ "$REPLY" != "y" ]]; then
    echo "aborted"
    exit 1
fi

git checkout $BR_OLD
git branch -m $BR_NEW
git push $REMOTE -u $BR_NEW
git push $REMOTE --delete $BR_OLD

