# KNADA images

Samling av Docker images til tjenester vi tilbyr i KNADA.

## Imager vi tilbyr

### Jupyter
[![Build Jupyter image](https://github.com/navikt/knada-images/actions/workflows/jupyter.yaml/badge.svg)](https://github.com/navikt/knada-images/actions/workflows/jupyter.yaml)

- Image: [ghcr.io/navikt/knada-images/jupyter](https://github.com/navikt/knada-images/pkgs/container/knada-images%2Fjupyter)
- [Dockerfile](https://github.com/navikt/knada-images/blob/main/jupyter/Dockerfile)

Vi installerer ingen python dependencies utover det som følger med [base imaget](https://quay.io/repository/jupyter/base-notebook) vi bygger på. Brukerne er ment å installere pakkene de trenger selv i sine egne jupytermiljøer. Python versjon i imaget er 3.11.

### Airflow
For airflow tilbyr vi to imager:

- Et [base image](#base-image) som brukes av de ulike Airflow komponentene og som default image for vanlige airflow workers.
- Et dedikert [default image](#dataverk-airflow-image) for airflow workers som er laget med [dataverk-airflow](https://github.com/navikt/dataverk-airflow).

#### Base image
[![Build Airflow image](https://github.com/navikt/knada-images/actions/workflows/airflow.yaml/badge.svg)](https://github.com/navikt/knada-images/actions/workflows/airflow.yaml)

Base imaget vi tilbyr for Airflow er imaget som brukes av alle Airflow komponentene som kjører i clusteret. 
Det vil også være default imaget som blir brukt for Airflow workers dersom man ikke bruker [dataverk-airflow](https://github.com/navikt/dataverk-airflow).

- Image: [ghcr.io/navikt/knada-images/airflow](https://github.com/navikt/knada-images/pkgs/container/knada-images%2Fairflow)
- [Dockerfile](https://github.com/navikt/knada-images/blob/main/airflow/base/Dockerfile)
- [requirements.txt](https://github.com/navikt/knada-images/blob/main/airflow/base/requirements.txt)

#### dataverk-airflow image
[![Build Airflow image](https://github.com/navikt/knada-images/actions/workflows/dataverk-airflow.yaml/badge.svg)](https://github.com/navikt/knada-images/actions/workflows/dataverk-airflow.yaml)

Vi tilbyr også et default image for airflow workers som er laget med [dataverk-airflow](https://github.com/navikt/dataverk-airflow). Dette imaget inneholder svært få python biblioteker og tanken er at de som bruker dette imaget selv skal installere pakkene de trenger for hver task ved å sende med sti til en requirementsfil som skal installeres som parameter til [dataverk-airflow](https://github.com/navikt/dataverk-airflow#felles-argumenter). Det bygges et image for alle Python versjoner som ikke er end of life i henhold til [Python Release Cycle](https://devguide.python.org/versions/).

- Imager: 
    - Python 3.8: [ghcr.io/navikt/knada-images/dataverk-airflow-python-3.8](https://github.com/navikt/knada-images/pkgs/container/knada-images%2Fdataverk-airflow-python-3.8)
    - Python 3.9: [ghcr.io/navikt/knada-images/dataverk-airflow-python-3.9](https://github.com/navikt/knada-images/pkgs/container/knada-images%2Fdataverk-airflow-python-3.9)
    - Python 3.10: [ghcr.io/navikt/knada-images/dataverk-airflow-python-3.10](https://github.com/navikt/knada-images/pkgs/container/knada-images%2Fdataverk-airflow-python-3.10)
    - Python 3.11: [ghcr.io/navikt/knada-images/dataverk-airflow-python-3.11](https://github.com/navikt/knada-images/pkgs/container/knada-images%2Fdataverk-airflow-python-3.11)
    - Python 3.12: [ghcr.io/navikt/knada-images/dataverk-airflow-python-3.12](https://github.com/navikt/knada-images/pkgs/container/knada-images%2Fdataverk-airflow-python-3.12)
- [Dockerfile](https://github.com/navikt/knada-images/blob/main/airflow/dataverk/Dockerfile)
- [requirements.txt](https://github.com/navikt/knada-images/blob/main/airflow/dataverk/requirements.txt)
