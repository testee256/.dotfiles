#!/usr/bin/env bash
# source: https://serverfault.com/questions/807910/measure-total-latency-of-ssh-session
python -m timeit --setup "import subprocess; p = subprocess.Popen(['ssh', '$1', 'cat'], stdin=subprocess.PIPE, stdout=subprocess.PIPE, bufsize=0)" 'p.stdin.write(b"z"); assert p.stdout.read(1) == b"z"'

