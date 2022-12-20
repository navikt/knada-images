# Knada images

Samling av images til tjenester vi tilbyr i Knada.

## Byggestatus

### GCP

Vi følger [Python Release Cycle](https://devguide.python.org/versions/) for Jupyterhub, det betyr at vi lager et image per Python-versjon som ikke har status end-of-life. Dessverre kan vi ikke tilby det nyeste da vi må følge det [Jupyterhub tilbyr](https://hub.docker.com/r/jupyter/base-notebook/tags).

#### Jupyterhub

[![Knada GKE: Build jupyterhub image](https://github.com/navikt/knada-images/actions/workflows/knada_gke_jupyter.yaml/badge.svg)](https://github.com/navikt/knada-images/actions/workflows/knada_gke_jupyter.yaml)

#### Airflow

[![Knada GKE: Build airflow image](https://github.com/navikt/knada-images/actions/workflows/knada_gke_airflow.yaml/badge.svg)](https://github.com/navikt/knada-images/actions/workflows/knada_gke_airflow.yaml)

### On-prem

#### Jupyterhub

[![Build base image](https://github.com/navikt/knada-images/actions/workflows/jupyterhub_base_image.yaml/badge.svg)](https://github.com/navikt/knada-images/actions/workflows/jupyterhub_base_image.yaml)

[![Build JKBL image](https://github.com/navikt/knada-images/actions/workflows/jupyterhub_jkbl_image.yaml/badge.svg)](https://github.com/navikt/knada-images/actions/workflows/jupyterhub_jkbl_image.yaml)

[![Jupyterhub: Update secondary images](https://github.com/navikt/knada-images/actions/workflows/jupyterhub_update_secondary_images.yaml/badge.svg)](https://github.com/navikt/knada-images/actions/workflows/jupyterhub_update_secondary_images.yaml)

#### Airflow

[![Build base image](https://github.com/navikt/knada-images/actions/workflows/airflow_base_image.yaml/badge.svg)](https://github.com/navikt/knada-images/actions/workflows/airflow_base_image.yaml)
