# KNADA images

Samling av Docker images til tjenester vi tilbyr i KNADA.

## Byggestatus

Vi følger [Python Release Cycle](https://devguide.python.org/versions/) for Jupyter notebooks, det betyr at vi lager et image per Python-versjon som ikke har status end-of-life.
Dessverre kan vi ikke tilby det nyeste da vi må følge det [Jupyter notebooks tilbyr](https://hub.docker.com/r/jupyter/base-notebook/tags).

### Jupyter

[![Build Jupyter image](https://github.com/navikt/knada-images/actions/workflows/jupyter.yaml/badge.svg)](https://github.com/navikt/knada-images/actions/workflows/jupyter.yaml)

### Airflow base

[![Build Airflow image](https://github.com/navikt/knada-images/actions/workflows/airflow.yaml/badge.svg)](https://github.com/navikt/knada-images/actions/workflows/airflow.yaml)

### Airflow run notebooks

[![Build Airflow notebooks image](https://github.com/navikt/knada-images/actions/workflows/airflow_notebooks.yaml/badge.svg)](https://github.com/navikt/knada-images/actions/workflows/airflow_notebooks.yaml)

## Internal repo

Dette repoet er lukket da vi har lagret TDV-driveren som vi ikke kan dele offentlig.
