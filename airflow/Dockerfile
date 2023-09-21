ARG base_image_tag

FROM apache/airflow:${base_image_tag}

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
RUN curl https://download.oracle.com/otn_software/linux/instantclient/2111000/oracle-instantclient-basic-21.11.0.0.0-1.x86_64.rpm -o /tmp/oracle-instantclient.rpm
RUN alien -i /tmp/oracle-instantclient.rpm && \
    rm -rf /var/cache/yum && \
    rm -f /tmp/oracle-instantclient.rpm && \
    echo /usr/lib/oracle/21/client64/lib > /etc/ld.so.conf.d/oracle-instantclient21.conf && \
    ldconfig

ENV PATH=$PATH:/usr/lib/oracle/21/client64/bin
ENV TDV_ODBC_DRIVER /opt/TDV/driver/libcomposite86_x64.so

USER ${AIRFLOW_UID}

COPY airflow/requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

ENV PYTHONPATH "/workspace"
