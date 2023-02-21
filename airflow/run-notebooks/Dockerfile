FROM python:3.10-slim

USER root

RUN apt-get update && apt-get install -yq --no-install-recommends \
    build-essential \
    curl \
    alien \
    libaio1 \
    libaio-dev \
    libpq-dev \
    wget \
    bzip2 \
    ca-certificates \
    locales \
    fonts-humor-sans \
    cmake \
    ca-certificates \
    git \
    gnupg \
    lsb-release \
    unzip \
    zip \
    tzdata \
    locales-all \
    unixodbc-dev \
    libarchive-tools && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install oracle client
RUN curl https://download.oracle.com/otn_software/linux/instantclient/1915000/oracle-instantclient19.15-basic-19.15.0.0.0-1.x86_64.rpm -o /tmp/oracle-instantclient.rpm
RUN alien -i /tmp/oracle-instantclient.rpm && \
    rm -rf /var/cache/yum && \
    rm -f /mp/oracle-instantclient.rpm && \
    echo /usr/lib/oracle/19.15/client64/lib > /etc/ld.so.conf.d/oracle-instantclient19.15.conf && \
    ldconfig

# Add TDV ODBC driver and set env
COPY TDV/driver/libcomposite86_x64.so /opt/TDV/driver/libcomposite86_x64.so
ENV TDV_ODBC_DRIVER /opt/TDV/driver/libcomposite86_x64.so

COPY airflow/requirements.txt /requirements.txt
RUN pip3 install -r /requirements.txt

COPY airflow/run-notebooks/scripts/. .

ENV PYTHONPATH "/workspace"

CMD ["/bin/bash", "/execute_python.sh"]

USER ${NB_USER}
