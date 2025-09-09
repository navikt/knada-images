ARG PYTHON_VERSION

FROM europe-north1-docker.pkg.dev/cgr-nav/pull-through/nav.no/python:${PYTHON_VERSION}-dev

ARG PYTHON_VERSION
ARG AIRFLOW_USER=airflow
ARG AIRFLOW_UID=50000
ARG AIRFLOW_USER_HOME_DIR=/home/airflow

USER root

RUN apk add --update \
      curl \
      jq \
      shadow \
      libaio \
      libnsl \
      "py${PYTHON_VERSION}-pip" \
      wget && \
      rm -rf /var/cache/apk/*

# Install Oracle Instant Client
RUN cd /tmp && \
    curl https://download.oracle.com/otn_software/linux/instantclient/2119000/instantclient-basic-linux.x64-21.19.0.0.0dbru.zip -o instantclient-basic.zip -SL && \
    unzip instantclient-basic.zip && \
    mv instantclient*/ /opt/instantclient && \
    rm instantclient-basic.zip

ENV LD_LIBRARY_PATH="/opt/instantclient"

# Install latest quarto cli
RUN cd /opt && \
    QUARTO_VERSION=$(curl https://api.github.com/repos/quarto-dev/quarto-cli/releases/latest | jq '.tag_name' | sed -e 's/[\"v]//g') && \
    wget https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-amd64.tar.gz && \
    tar -zxvf quarto-${QUARTO_VERSION}-linux-amd64.tar.gz && \
    rm -rf quarto-${QUARTO_VERSION}-linux-amd64.tar.gz && \
    mv /opt/quarto-${QUARTO_VERSION} /opt/quarto

RUN adduser --disabled-password "${AIRFLOW_USER}" --uid "${AIRFLOW_UID}" -g "0" --home "${AIRFLOW_USER_HOME_DIR}" && \
    mkdir -p "${AIRFLOW_USER_HOME_DIR}" && chown -R "${AIRFLOW_USER}:0" "${AIRFLOW_USER_HOME_DIR}"

COPY airflow/chainguard/dataverk/requirements.txt /requirements.txt
RUN pip install -r /requirements.txt --no-cache-dir

# Quarto envs
ENV DENO_DIR="${AIRFLOW_USER_HOME_DIR}/deno"
ENV XDG_CACHE_HOME="${AIRFLOW_USER_HOME_DIR}/cache"
ENV XDG_DATA_HOME="${AIRFLOW_USER_HOME_DIR}/share"

ENV PATH=${PATH}:/opt/quarto/bin:"${AIRFLOW_USER_HOME_DIR}/.local/bin"
ENV PYTHONPATH "/workspace"

USER airflow
