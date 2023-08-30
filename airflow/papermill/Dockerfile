ARG base_image_tag

FROM apache/airflow:base_image_tag

USER root

RUN apt-get update && apt-get install -yq --no-install-recommends \
    alien \
    build-essential \
    bzip2 \
    ca-certificates \
    cmake \
    curl \
    fonts-humor-sans \
    git \
    gnupg \
    libaio-dev \
    libaio1 \
    libarchive-tools \
    libpq-dev \
    locales \
    locales-all \
    lsb-release \
    tzdata \
    unixodbc-dev \
    unzip \
    wget \
    zip && \
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

USER ${AIRFLOW_UID}

COPY airflow/papermill/requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

ENV PYTHONPATH "/workspace"
