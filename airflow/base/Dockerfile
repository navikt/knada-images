FROM apache/airflow:2.6.2-python3.10
LABEL org.opencontainers.image.source https://github.com/navikt/knada-images

USER root

RUN apt-get update -yq && apt-get install -yq build-essential libpq-dev

USER ${AIRFLOW_UID}

COPY airflow/base/requirements.txt .
RUN pip install -r requirements.txt --user

RUN pip install dataverk-airflow==0.4.37 --user
