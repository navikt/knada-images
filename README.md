# KNADA images

Samling av Docker images til tjenester vi tilbyr i KNADA.

## Imager vi tilbyr

### Jupyter

- Image: [ghcr.io/navikt/knada-images/jupyter](https://github.com/navikt/knada-images/pkgs/container/knada-images%2Fjupyter)
- [Dockerfile](https://github.com/navikt/knada-images/blob/main/jupyter/Dockerfile)

Vi installerer ingen python dependencies utover det som følger med [base imaget](https://hub.docker.com/r/jupyter/base-notebook) vi bygger på. Brukerne er ment å installere pakkene de trenger selv i sine egne jupytermiljøer.

[![Build Jupyter image](https://github.com/navikt/knada-images/actions/workflows/jupyter.yaml/badge.svg)](https://github.com/navikt/knada-images/actions/workflows/jupyter.yaml)

Vi følger [Python Release Cycle](https://devguide.python.org/versions/) for Jupyter notebooks, det betyr at vi lager et image per Python-versjon som ikke har status end-of-life.
Dessverre kan vi ikke tilby det nyeste da vi må følge det [Jupyter notebooks tilbyr](https://hub.docker.com/r/jupyter/base-notebook/tags).

### Airflow
For airflow tilbyr vi to imager:

- Et [base image](#base-image) som brukes av de ulike Airflow komponentene og som default image for vanlige airflow workers.
- Et dedikert [default image](#dataverk-airflow-image) for airflow workers som er laget med [dataverk-airflow](https://github.com/navikt/dataverk-airflow).

#### Base image
Base imaget vi tilbyr for Airflow er imaget som brukes av alle Airflow komponentene som kjører i clusteret. 
Det vil også være default imaget som blir brukt for Airflow workers dersom man ikke bruker [dataverk-airflow](https://github.com/navikt/dataverk-airflow).

- Image: [ghcr.io/navikt/knada-images/airflow](https://github.com/navikt/knada-images/pkgs/container/knada-images%2Fairflow)
- [Dockerfile](https://github.com/navikt/knada-images/blob/main/airflow/base/Dockerfile)
- [requirements.txt](https://github.com/navikt/knada-images/blob/main/airflow/base/requirements.txt)

[![Build Airflow image](https://github.com/navikt/knada-images/actions/workflows/airflow.yaml/badge.svg)](https://github.com/navikt/knada-images/actions/workflows/airflow.yaml)

#### dataverk-airflow image
Vi tilbyr også et default image for airflow workers som er laget med [dataverk-airflow](https://github.com/navikt/dataverk-airflow). Dette imaget inneholder svært få python biblioteker og tanken er at de som bruker dette imaget selv skal installere pakkene de trenger for hver task ved å sende med sti til en requirementsfil som skal installeres som parameter til [dataverk-airflow](https://github.com/navikt/dataverk-airflow#felles-argumenter).

- Image: [ghcr.io/navikt/knada-images/dataverk-airflow](https://github.com/navikt/knada-images/pkgs/container/knada-images%2Fdataverk-airflow)
- [Dockerfile](https://github.com/navikt/knada-images/blob/main/airflow/dataverk/Dockerfile)
- [requirements.txt](https://github.com/navikt/knada-images/blob/main/airflow/dataverk/requirements.txt)

[![Build Airflow image](https://github.com/navikt/knada-images/actions/workflows/dataverk-airflow.yaml/badge.svg)](https://github.com/navikt/knada-images/actions/workflows/dataverk-airflow.yaml)

## Internal repo

Dette repoet er lukket da vi har lagret TDV-driveren som vi ikke kan dele offentlig.
