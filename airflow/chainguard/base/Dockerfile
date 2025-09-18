FROM europe-north1-docker.pkg.dev/cgr-nav/pull-through/nav.no/airflow-core:2.11-dev as dev

USER root
RUN apk add --update --no-cache py3.12-pip

ENV PIP_TARGET=/home/airflow/.local/lib/python3.12/site-packages
ENV PYTHONPATH=$PIP_TARGET
COPY airflow/chainguard/base/requirements.txt .
RUN pip install \ 
 --upgrade \
 -r requirements.txt

FROM europe-north1-docker.pkg.dev/cgr-nav/pull-through/nav.no/airflow-core:2.11

RUN rm -rf /home/airflow/.local/lib/python3.12/site-packages

COPY --from=dev /home/airflow/.local/lib/python3.12/site-packages/ /home/airflow/.local/lib/python3.12/site-packages/
