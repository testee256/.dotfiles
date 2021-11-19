#!/usr/bin/env bash
set -e

[[ -z "$1" ]] && { 
    echo "usage: $(basename $0) feat [base]";
    exit 1;
}
BR_FEAT=$1
BR_BASE=$2
[[ -z "$BR_BASE" ]] && BR_BASE="mainline"

echo "The following operations will be performed:"
echo "- archive branch '$BR_FEAT' to branch 'archive/$BR_FEAT'"
echo "- reset '$BR_FEAT' to the commit in '$BR_BASE' where it branched from"
echo "- squash merge 'archive/$BR_FEAT' into '$BR_FEAT'"

# wait for one char (-n 1) and accept back slashes (-r)
read -p "Do you want to continue (y/n)? " -n 1 -r
echo REPLY=$REPLY
if [[ "$REPLY" != "y" ]]; then
    echo "aborted"
    exit 1
fi

git checkout $BR_FEAT
git clean -fdx
git checkout -B archive/$BR_FEAT # make a copy in archive
git push origin archive/$BR_FEAT # push archive to origin
git checkout $BR_FEAT

# sync to $BR_BASE

# Method 2 (find where you branch from)
git reset $(git merge-base $BR_BASE $(git rev-parse --abbrev-ref HEAD))
git reset --hard
git clean -fdx
git merge --squash archive/$BR_FEAT
# git commit
# git push origin $BR_FEAT -f

