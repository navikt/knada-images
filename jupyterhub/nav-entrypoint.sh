#!/bin/bash

set -e

mkdir -p /home/jovyan/.local/share/code-server/extensions/
cp -r /home/ms-python.python/* /home/${NB_USER}/.local/share/code-server/extensions/ms-python.python

exec "$@"
