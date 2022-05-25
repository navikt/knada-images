#!/bin/bash

echo "HTTPS_PROXY=$HTTPS_PROXY" >> /usr/lib/R/etc/Renviron
echo "https_proxy=$https_proxy" >> /usr/lib/R/etc/Renviron
echo "NO_PROXY=$NO_PROXY" >> /usr/lib/R/etc/Renviron
echo "no_proxy=$no_proxy" >> /usr/lib/R/etc/Renviron
echo "DATAVERK_BUCKET_ENDPOINT=$DATAVERK_BUCKET_ENDPOINT" >> /usr/lib/R/etc/Renviron
echo "DATAVERK_API_ENDPOINT=$DATAVERK_API_ENDPOINT" >> /usr/lib/R/etc/Renviron
echo "DATAVERK_ES_HOST=$DATAVERK_ES_HOST" >> /usr/lib/R/etc/Renviron
echo "DATAVERK_HOST=$DATAVERK_HOST" >> /usr/lib/R/etc/Renviron
echo "DATAVERK_ENVIRONMENT=$DATAVERK_ENVIRONMENT" >> /usr/lib/R/etc/Renviron
echo "TZ=$TZ" >> /usr/lib/R/etc/Renviron

tini -g -- start-notebook.sh
