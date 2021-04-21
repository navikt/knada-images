FROM jupyter/base-notebook:python-3.7.6

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

# Several of the jupyterlab extensions require newer version of nodejs
RUN conda install -c conda-forge nodejs=15.3.0

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
COPY jupyterhub/requirements_base.txt /requirements_base.txt
RUN pip install -r /requirements_base.txt
RUN pip install jupytext
RUN pip install nbresuse==0.3.3
RUN pip install jupyter-resource-usage
RUN pip install jupyter-kite<2.0.0


# Install jupyterlab extensions
RUN jupyter labextension install wit-widget --no-build && \
    jupyter labextension install @jupyter-widgets/jupyterlab-manager --no-build && \
    jupyter labextension install jupyter-leaflet --no-build && \
    jupyter labextension install plotlywidget --no-build && \
    jupyter labextension install jupyterlab-plotly --no-build && \
    jupyter labextension install @aquirdturtle/collapsible_headings --no-build && \
    jupyter labextension install @jupyterlab/toc --no-build && \
    jupyter labextension install dask-labextension --no-build && \
    jupyter labextension install jupyterlab-topbar-extension --no-build && \
    jupyter labextension install jupyterlab-system-monitor --no-build && \
    jupyter labextension install @kiteco/jupyterlab-kite --no-build 

RUN jupyter lab build --dev-build=False --minimize=False --debug

RUN jupyter nbextension enable --py --sys-prefix ipyleaflet && \
    jupyter serverextension enable --sys-prefix dask_labextension && \
    jupyter nbextension install --py --symlink --sys-prefix witwidget && \
    jupyter nbextension enable --py --sys-prefix witwidget

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

RUN pip install great-expectations

# Install spacy models
RUN python -m spacy download en_core_web_sm && \
    python -m spacy download nb_core_news_sm && \
    python -m spacy download nb_core_news_md && \
    python -m spacy download nb_core_news_lg

# Downloading gcloud package
RUN curl https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz > /tmp/google-cloud-sdk.tar.gz

# Installing the package
RUN mkdir -p /usr/local/gcloud \
  && tar -C /usr/local/gcloud -xvf /tmp/google-cloud-sdk.tar.gz \
  && /usr/local/gcloud/google-cloud-sdk/install.sh

# Adding the package path to local
ENV PATH $PATH:/usr/local/gcloud/google-cloud-sdk/bin

# Switch back to jovyan
USER ${NB_UID}
