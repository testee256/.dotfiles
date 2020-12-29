#!/usr/bin/env bash
python -m timeit --setup "import subprocess; p = subprocess.Popen(['ssh', '$1', 'cat'], stdin=subprocess.PIPE, stdout=subprocess.PIPE, bufsize=0)" 'p.stdin.write(b"z"); assert p.stdout.read(1) == b"z"'

