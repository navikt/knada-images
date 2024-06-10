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
    jq \
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
RUN ARCH=$(uname -m) && \
    echo "Arch is: $ARCH" && \
    if [ "$ARCH" = "aarch64" ]; then \
        RPM_URL=https://download.oracle.com/otn_software/linux/instantclient/instantclient-basic-linux-arm64.rpm; \
    else \
      RPM_URL=https://download.oracle.com/otn_software/linux/instantclient/2111000/oracle-instantclient-basic-21.11.0.0.0-1.x86_64.rpm; \
    fi && \
    curl -L -o /tmp/oracle-instantclient.rpm $RPM_URL && \
    alien -i /tmp/oracle-instantclient.rpm && \
    rm -rf /var/cache/yum && \
    rm -f /tmp/oracle-instantclient.rpm && \
    echo /usr/lib/oracle/21/client64/lib > /etc/ld.so.conf.d/oracle-instantclient21.conf && \
    ldconfig
ENV PATH=$PATH:/usr/lib/oracle/21/client64/bin

# Install quarto cli
RUN ARCH=$(uname -m) && \
    if [ "$ARCH" = "aarch64" ]; then \
        ARCH="arm64"; \
    else \
        ARCH="amd64"; \
    fi && \
    cd /opt && \
    QUARTO_VERSION=$(curl https://api.github.com/repos/quarto-dev/quarto-cli/releases/latest | jq '.tag_name' | sed -e 's/[\"v]//g') && \
    echo "Quarto version is: $QUARTO_VERSION" && \
    echo "Arch is: $ARCH" && \
    curl -L "https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-${ARCH}.tar.gz" -o /opt/quarto.tar.gz && \
    tar -zxvf /opt/quarto.tar.gz && \
    rm -rf /opt/quarto.tar.gz && \
    mv /opt/quarto-${QUARTO_VERSION} /opt/quarto

USER ${AIRFLOW_UID}

# install requirements
COPY airflow/base/requirements.txt /requirements.txt
COPY airflow/base/requirements-arm64.txt /requirements-arm64.txt
RUN ARCH=$(uname -m) && \
        if [ "$ARCH" = "aarch64" ]; then \
            pip install -r /requirements-arm64.txt --no-cache-dir; \
        else \
            pip install -r /requirements.txt --no-cache-dir; \
        fi

ENV PATH=${PATH}:/opt/quarto/bin
ENV PYTHONPATH "/workspace"
