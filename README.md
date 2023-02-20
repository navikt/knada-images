# KNADA images

Samling av Docker images til tjenester vi tilbyr i KNADA.

## Byggestatus

### GCP

Vi følger [Python Release Cycle](https://devguide.python.org/versions/) for Jupyter notebooks, det betyr at vi lager et image per Python-versjon som ikke har status end-of-life.
Dessverre kan vi ikke tilby det nyeste da vi må følge det [Jupyter notebooks tilbyr](https://hub.docker.com/r/jupyter/base-notebook/tags).

#### Jupyterhub

[![Knada GKE: Build Jupyter image](https://github.com/navikt/knada-images/actions/workflows/knada_gke_jupyter.yaml/badge.svg)](https://github.com/navikt/knada-images/actions/workflows/knada_gke_jupyter.yaml)

#### Airflow

[![Knada GKE: Build Airflow image](https://github.com/navikt/knada-images/actions/workflows/knada_gke_airflow.yaml/badge.svg)](https://github.com/navikt/knada-images/actions/workflows/knada_gke_airflow.yaml)

### On-prem

#### Airflow

[![Build Airflow image](https://github.com/navikt/knada-images/actions/workflows/airflow_base_image.yaml/badge.svg)](https://github.com/navikt/knada-images/actions/workflows/airflow_base_image.yaml)
