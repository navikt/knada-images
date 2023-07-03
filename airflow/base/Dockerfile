FROM apache/airflow:2.6.2-python3.10
LABEL org.opencontainers.image.source https://github.com/navikt/knada-images

RUN apt-get update -yq && apt-get install -yq libpq-dev

COPY airflow/base/requirements.txt .
RUN pip install -r requirements.txt --user

RUN pip install dataverk-airflow==0.4.37 --user
