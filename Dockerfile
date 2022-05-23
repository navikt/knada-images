FROM jupyter/base-notebook:python-3.9.12
LABEL org.opencontainers.image.source = &quot;https://github.com/navikt/knada-images&quot;

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
    sudo \
    locales \
    fonts-humor-sans \
    cmake \
    ca-certificates \
    git \
    gnupg \
    graphviz \
    lsb-release \
    unzip \
    vim \
    nano \
    zip \
    emacs \
    tzdata \
    locales-all \
    unixodbc-dev \
    libarchive-tools \
    ssh-client \
    unrar \
    connect-proxy && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN dpkg-reconfigure locales

# Install oracle client
RUN curl https://download.oracle.com/otn_software/linux/instantclient/1915000/oracle-instantclient19.15-basic-19.15.0.0.0-1.x86_64.rpm -o /tmp/oracle-instantclient.rpm
RUN alien -i /tmp/oracle-instantclient.rpm && \
    rm -rf /var/cache/yum && \
    rm -f /mp/oracle-instantclient.rpm && \
    echo /usr/lib/oracle/19.15/client64/lib > /etc/ld.so.conf.d/oracle-instantclient19.15.conf && \
    ldconfig

ENV PATH=$PATH:/usr/lib/oracle/19.15/client64/bin
ENV NLS_LANG=NORWEGIAN_NORWAY.AL32UTF8
ENV SHELL /bin/bash

# Downloading gcloud package
RUN curl https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz > /tmp/google-cloud-sdk.tar.gz

# Installing the package
RUN mkdir -p /usr/local/gcloud \
    && tar -C /usr/local/gcloud -xvf /tmp/google-cloud-sdk.tar.gz \
    && /usr/local/gcloud/google-cloud-sdk/install.sh

# Adding the package path to local
ENV PATH $PATH:/usr/local/gcloud/google-cloud-sdk/bin

# Install base python requirements
COPY requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

# Switch back to jovyan
USER ${NB_UID}