FROM ghcr.io/navikt/knada-jupyterhub:2022-12-06-5c1876e
LABEL org.opencontainers.image.source https://github.com/navikt/knada-images

USER root

COPY knada-gke/jupyterhub/nks-statistikk/requirements.txt requirements.txt

RUN pip install -r requirements.txt

USER ${NB_USER}
