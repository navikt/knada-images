#!/bin/bash

set -e

bsdtar -xvf vspackage - extension
mkdir -p /home/jovyan/.local/share/code-server/extensions/
mv extension /home/jovyan/.local/share/code-server/extensions/ms-python.python

exec "$@"
