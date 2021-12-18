#!/usr/bin/env bash
set -e
git diff $@ --name-only --diff-filter=d | xargs bat --diff
