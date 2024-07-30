ARG python_version

FROM python:${python_version}

ARG AIRFLOW_USER=airflow
ARG AIRFLOW_UID="50000"
ARG AIRFLOW_USER_HOME_DIR=/home/airflow

RUN apt-get update && apt-get install -yq --no-install-recommends \
    alien \
    build-essential \
    ca-certificates \
    cmake \
    curl \
    jq \
    libaio-dev \
    libaio1 \
    libarchive-tools \
    libpq-dev \
    locales \
    locales-all \
    lsb-release \
    tzdata \
    unixodbc-dev \
    wget && \
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

# Install latest quarto cli
RUN cd /opt && \
    QUARTO_VERSION=$(curl https://api.github.com/repos/quarto-dev/quarto-cli/releases/latest | jq '.tag_name' | sed -e 's/[\"v]//g') && \
    wget https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-amd64.tar.gz && \
    tar -zxvf quarto-${QUARTO_VERSION}-linux-amd64.tar.gz && \
    rm -rf quarto-${QUARTO_VERSION}-linux-amd64.tar.gz && \
    mv /opt/quarto-${QUARTO_VERSION} /opt/quarto

RUN adduser --disabled-password --quiet "${AIRFLOW_USER}" --uid "${AIRFLOW_UID}" --gid "0" --home "${AIRFLOW_USER_HOME_DIR}" && \
    mkdir -p "${AIRFLOW_USER_HOME_DIR}" && chown -R "${AIRFLOW_USER}:0" "${AIRFLOW_USER_HOME_DIR}"

COPY airflow/dataverk/requirements.txt /requirements.txt
RUN pip install -r /requirements.txt --no-cache-dir

# Configure pypi proxy
RUN echo $'[global]\nindex-url = https://europe-north1-python.pkg.dev/knada-dev/pypiproxy/simple/' > /opt/pip.conf
ENV PIP_CONFIG_FILE=/opt/pip.conf

USER ${AIRFLOW_USER}
WORKDIR ${AIRFLOW_USER_HOME_DIR}

# Quarto envs
ENV DENO_DIR="${AIRFLOW_USER_HOME_DIR}/deno"
ENV XDG_CACHE_HOME="${AIRFLOW_USER_HOME_DIR}/cache"
ENV XDG_DATA_HOME="${AIRFLOW_USER_HOME_DIR}/share"

ENV PATH=${PATH}:/opt/quarto/bin:"${AIRFLOW_USER_HOME_DIR}/.local/bin"
ENV PYTHONPATH "/workspace"
