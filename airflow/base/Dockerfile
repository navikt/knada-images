ARG base_image_tag

FROM apache/airflow:base_image_tag

COPY airflow/base/requirements.txt /requirements.txt
RUN pip install -r /requirements.txt
