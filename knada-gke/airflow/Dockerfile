FROM apache/airflow:2.5.1-python3.10
LABEL org.opencontainers.image.source https://github.com/navikt/knada-images

USER root

RUN apt-get update && \
    apt-get install -y libpq-dev alien libicu-dev libaio1

# Install oracle client
RUN curl https://download.oracle.com/otn_software/linux/instantclient/1915000/oracle-instantclient19.15-basic-19.15.0.0.0-1.x86_64.rpm -o /tmp/oracle-instantclient.rpm
RUN alien -i /tmp/oracle-instantclient.rpm && \
    rm -rf /var/cache/yum && \
    rm -f /mp/oracle-instantclient.rpm && \
    echo /usr/lib/oracle/19.15/client64/lib > /etc/ld.so.conf.d/oracle-instantclient19.15.conf && \
    ldconfig

ENV PATH=$PATH:/usr/lib/oracle/19.15/client64/bin

USER ${AIRFLOW_UID}

COPY ./knada-gke/airflow/requirements.txt requirements.txt
RUN pip install -r requirements.txt --user

RUN pip install dataverk-airflow==0.4.16 --user
