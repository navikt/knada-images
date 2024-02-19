ARG python_version

FROM jupyter/base-notebook:python-${python_version}

USER root

RUN apt-get update && apt-get install -yq --no-install-recommends \
    alien \
    build-essential \
    bzip2 \
    ca-certificates \
    cmake \
    connect-proxy \
    curl \
    emacs \
    fonts-humor-sans \
    git \
    gnupg \
    graphviz \
    jq \
    libaio-dev \
    libaio1 \
    libarchive-tools \
    libpq-dev \
    locales \
    locales-all \
    lsb-release \
    nano \
    ssh-client \
    sudo \
    tzdata \
    unixodbc-dev \
    unrar \
    unzip \
    vim \
    wget \
    zip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN dpkg-reconfigure locales

# Install oracle client
RUN curl https://download.oracle.com/otn_software/linux/instantclient/2111000/oracle-instantclient-basic-21.11.0.0.0-1.x86_64.rpm -o /tmp/oracle-instantclient.rpm
RUN alien -i /tmp/oracle-instantclient.rpm && \
    rm -rf /var/cache/yum && \
    rm -f /tmp/oracle-instantclient.rpm && \
    echo /usr/lib/oracle/21/client64/lib > /etc/ld.so.conf.d/oracle-instantclient21.conf && \
    ldconfig

ENV PATH=$PATH:/usr/lib/oracle/21/client64/bin
ENV NLS_LANG=NORWEGIAN_NORWAY.AL32UTF8
ENV SHELL /bin/bash
ENV PATH $PATH:/home/jovyan/.local/bin

# Downloading gcloud package
RUN curl https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz > /tmp/google-cloud-sdk.tar.gz

# Installing gcloud package
RUN mkdir -p /usr/local/gcloud \
    && tar -C /usr/local/gcloud -xvf /tmp/google-cloud-sdk.tar.gz \
    && /usr/local/gcloud/google-cloud-sdk/install.sh

# Adding the package path to local
ENV PATH ${PATH}:/usr/local/gcloud/google-cloud-sdk/bin

# Install quarto cli 
RUN cd /opt && \
    QUARTO_VERSION=$(curl https://api.github.com/repos/quarto-dev/quarto-cli/releases/latest | jq '.tag_name' | sed -e 's/[\"v]//g') && \
    wget https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-amd64.tar.gz && \
    tar -zxvf quarto-${QUARTO_VERSION}-linux-amd64.tar.gz && \
    rm -rf quarto-${QUARTO_VERSION}-linux-amd64.tar.gz && \
    echo "export PATH=${PATH}:/opt/quarto-${QUARTO_VERSION}/bin" >> /etc/profile

# set jovyan as user
USER $NB_USER
