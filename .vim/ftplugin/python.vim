python3 << EOF
import os
import sys

paths = []
paths.append(os.path.expanduser("/home/nemu_sou/.anyenv/envs/pyenv/versions/3.6.1/lib/python3.6/site-packages"))
for path in paths:
  if not path in sys.path:
    sys.path.append(path)
EOF
