#!/bin/bash

echo "HTTPS_PROXY=$HTTPS_PROXY" >> /opt/conda/lib/R/etc/Renviron
echo "https_proxy=$https_proxy" >> /opt/conda/lib/R/etc/Renviron
echo "NO_PROXY=$NO_PROXY" >> /opt/conda/lib/R/etc/Renviron
echo "no_proxy=$no_proxy" >> /opt/conda/lib/R/etc/Renviron

tini -g -- start-notebook.sh
