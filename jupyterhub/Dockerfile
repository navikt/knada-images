FROM jupyter/base-notebook:python-3.7.4

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
    locales-all \
    unixodbc-dev \
    libarchive-tools \
    ssh-client \
    connect-proxy && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN dpkg-reconfigure locales

# Install oracle client
ADD oracle_client/oracle-instantclient18.3-basic-18.3.0.0.0-1.x86_64.rpm /tmp/
RUN alien -i /tmp/oracle-instantclient18.3-basic-18.3.0.0.0-1.x86_64.rpm && \
    rm -rf /var/cache/yum && \
    rm -f /mp/oracle-instantclient18.3-basic-18.3.0.0.0-1.x86_64.rpm && \
    echo /usr/lib/oracle/18.3/client64/lib > /etc/ld.so.conf.d/oracle-instantclient18.3.conf && \
    ldconfig

ENV PATH=$PATH:/usr/lib/oracle/18.3/client64/bin

# Copy ca-bundle and font
COPY ca_bundles/ca-bundle.crt /etc/pki/tls/certs/ca-bundle.crt
COPY ca_bundles/ca-bundle.crt /etc/ssl/certs/ca-certificates.crt
COPY ca_bundles/ca-bundle.crt /usr/local/lib/python3.7/site-packages/certifi/cacert.pem
COPY fonts/xkcd-script.ttf /home/xkcd-script.ttf

# Install base python requirements
COPY jupyter/requirements_base.txt /requirements_base.txt
RUN pip install -r /requirements_base.txt

# Install jupyterlab extensions
RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager --no-build && \
    jupyter labextension install jupyter-leaflet --no-build && \
    jupyter labextension install plotlywidget --no-build && \
    jupyter labextension install jupyterlab-plotly --no-build && \
    jupyter labextension install jupyterlab-jupytext --no-build && \
    jupyter labextension install @aquirdturtle/collapsible_headings --no-build && \
    jupyter labextension install @jupyterlab/toc --no-build && \
    jupyter labextension install dask-labextension --no-build

RUN jupyter lab build --dev-build=False --minimize=False

RUN jupyter nbextension enable --py --sys-prefix ipyleaflet && \
    jupyter serverextension enable --sys-prefix dask_labextension

# Set system envs
ENV NLS_LANG=NORWEGIAN_NORWAY.AL32UTF8
ENV SHELL /bin/bash
ENV REQUESTS_CA_BUNDLE /etc/pki/tls/certs/ca-bundle.crt
ENV SSL_CERT_FILE /etc/pki/tls/certs/ca-bundle.crt
ENV DATAVERK_SECRETS_FROM_API "true"

# Set vault envs
ENV VKS_VAULT_ADDR https://vault.adeo.no
ENV VKS_AUTH_PATH auth/kubernetes/prod/kubeflow/login
ENV VKS_KV_PATH kv/prod/kubeflow
ENV VKS_SECRET_DEST_PATH /var/run/secrets/nais.io/vault
ENV K8S_SERVICEACCOUNT_PATH /var/run/secrets/kubernetes.io/serviceaccount

# Install python packages
COPY jupyterhub/requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

# Install spacy models
RUN python -m spacy download en_core_web_sm && \
    python -m spacy download nb_core_news_sm

# Switch back to jovyan
USER ${NB_UID}
