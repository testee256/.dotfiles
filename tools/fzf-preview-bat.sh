#!/usr/bin/env bash
set -e
fzf --preview 'bat {-1} --color=always'
