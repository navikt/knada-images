# Base image for Jupyter Notebooks on-prem

## Lag ditt eget image

Finn siste versjon av [ghcr.io/navikt/jupyterlab](https://github.com/navikt/knada-images/pkgs/container/jupyterlab).

````dockerfile
FROM ghcr.io/navikt/jupyterlab:<tag>

USER root

COPY requirements.txt /requirements.txt
RUN pip3 install -r /requirements.txt

USER ${NB_USER}
````
