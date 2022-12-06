FROM ghcr.io/navikt/knada-jupyterhub:2022-12-06-88bbcf9

USER root

COPY knada-gke/jupyterhub/nks-statistikk/requirements.txt requirements.txt

RUN pip install -r requirements.txt

USER ${NB_USER}
