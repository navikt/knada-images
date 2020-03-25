# Base image for naisflow images

## Lag ditt eget kubeflow image

Finn siste versjon av navikt/naisflow:jupyterlab og navikt/naisflow:jupyterhub 
på [dockerhub](https://hub.docker.com/r/navikt/naisflow/tags)

### Jupyterlab
````dockerfile
FROM navikt/naisflow:jupyterlab-<tag>

USER root

COPY requirements.txt /requirements.txt
RUN pip3 install -r /requirements.txt

USER ${NB_USER}
````

### Jupyterhub
````dockerfile
FROM navikt/naisflow:jupyterhub-<tag>

USER root

COPY requirements.txt /requirements.txt
RUN pip3 install -r /requirements.txt

USER ${NB_USER}
````
