#!/bin/bash
set -e

mkdir -p /home/jovyan/.local/share/code-server/extensions/ms-python.python
cp -r ../ms-python.python/* /home/${NB_USER}/.local/share/code-server/extensions/ms-python.python

export APPLICATION_NAME=$(cat "${K8S_SERVICEACCOUNT_PATH}/namespace")

jupyter lab --notebook-dir=/home/${NB_USER} --ip=0.0.0.0 --no-browser --allow-root --port=8888 --NotebookApp.token='' --NotebookApp.password='' --NotebookApp.allow_origin='*' --NotebookApp.base_url=${NB_PREFIX}
