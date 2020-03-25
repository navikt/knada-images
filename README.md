# Base image for naisflow images

## Lag ditt eget kubeflow image

### Jupyterlab
````dockerfile
FROM navikt/naisflow:jupyterlab-<tag>

USER root

COPY requirements.txt /requirements.txt
RUN pip3 install /requirements.txt

USER ${NB_USER}
````

### Jupyterhub
````dockerfile
FROM navikt/naisflow:jupyterhub-<tag>

USER root

COPY requirements.txt /requirements.txt
RUN pip3 install /requirements.txt

USER ${NB_USER}
````
