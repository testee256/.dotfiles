#!/usr/bin/env bash
set -e

FIND_DIR=$1
FIND_NAME=$2
if [ ! -z "$3" ]; then EXTRA_ARGS="${@:3}"; else EXTRA_ARGS="-n -r"; fi

find $FIND_DIR -name $FIND_NAME -printf "%Ty-%Tm-%Td %TH:%TM:%.2TS %12s %p\n" | sort $EXTRA_ARGS

