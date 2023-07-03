FROM apache/airflow:2.6.2-python3.10
LABEL org.opencontainers.image.source https://github.com/navikt/knada-images

COPY requirements.txt .
RUN pip install -r requirements.txt --user
