#!/bin/bash

set -e

mkdir -p /home/jovyan/.local/share/code-server/extensions/ms-python.python
cp -r ../ms-python.python/* /home/${NB_USER}/.local/share/code-server/extensions/ms-python.python

tini -g start-notebook.sh