#!/bin/bash
set -e

cd $NOTEBOOK_PATH

if [ "$LOG_ENABLED" = "true" ]
then
  papermill --log-output $NOTEBOOK_NAME /workspace/output.ipynb
else
  papermill $NOTEBOOK_NAME /workspace/output.ipynb
fi
