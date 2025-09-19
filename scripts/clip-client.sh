#!/usr/bin/env bash
(
cd "$(dirname "$0")"
source venv/bin/activate
python -u clip-client.py $@
)

