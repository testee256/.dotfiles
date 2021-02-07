#!/usr/bin/env bash
chmod +x $*
git add $*
git update-index --chmod=+x $*

