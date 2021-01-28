#!/bin/bash

echo "HTTPS_PROXY=$HTTPS_PROXY" >> /usr/lib/R/etc/Renviron
echo "https_proxy=$https_proxy" >> /usr/lib/R/etc/Renviron
echo "NO_PROXY=$NO_PROXY" >> /usr/lib/R/etc/Renviron
echo "no_proxy=$no_proxy" >> /usr/lib/R/etc/Renviron

tini -g -- start-notebook.sh
