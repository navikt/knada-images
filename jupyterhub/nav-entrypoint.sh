#!/bin/bash

set -e

mkdir -p /home/jovyan/.local/share/code-server/extensions/
mv /home/ms-python.python /home/jovyan/.local/share/code-server/extensions/ms-python.python

exec "$@"
