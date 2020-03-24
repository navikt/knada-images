FROM navikt/python:3.7

USER root

RUN apt-get update && apt-get install -yq --no-install-recommends \
  build-essential \
  curl \
  sudo \
  wget \
  alien \
  libaio1 \
  libaio-dev \
  libpq-dev \
  fonts-humor-sans \
  cmake \
  && apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# Install Tini - used as entrypoint for container
RUN cd /tmp && \
    wget --quiet https://github.com/krallin/tini/releases/download/v0.18.0/tini && \
    echo "12d20136605531b09a2c2dac02ccee85e1b874eb322ef6baf7561cd93f93c855 *tini" | sha256sum -c - && \
    mv tini /usr/local/bin/tini && \
    chmod +x /usr/local/bin/tini

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
COPY fonts/xkcd-script.ttf /home/xkcd-script.ttf

# Install nodejs + npm
RUN apt-get update && \
    apt-get install -y nodejs && \
    curl -L https://npmjs.org/install.sh | sh

# Install jupyter
RUN pip3 install jupyter==1.0.0

RUN pip3 install ipyleaflet && \
    jupyter nbextension enable --py --sys-prefix ipyleaflet

# Set system envs
ENV NLS_LANG=NORWEGIAN_NORWAY.AL32UTF8
ENV SHELL /bin/bash
ENV REQUESTS_CA_BUNDLE /etc/pki/tls/certs/ca-bundle.crt
ENV SSL_CERT_FILE /etc/pki/tls/certs/ca-bundle.crt

# Set vault envs
ENV VKS_VAULT_ADDR https://vault.adeo.no
ENV VKS_AUTH_PATH auth/kubernetes/prod/kubeflow/login
ENV VKS_KV_PATH kv/prod/kubeflow
ENV VKS_SECRET_DEST_PATH /var/run/secrets/nais.io/vault
ENV K8S_SERVICEACCOUNT_PATH /var/run/secrets/kubernetes.io/serviceaccount

RUN apt-get update && apt-get install -yq --no-install-recommends \
    bzip2 \
    ca-certificates \
    git \
    gnupg \
    graphviz \
    locales \
    lsb-release \
    unzip \
    vim \
    nano \
    zip \
    emacs \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV NB_USER jovyan
ENV NB_UID 1000
ENV HOME /home/$NB_USER
ENV NB_PREFIX /

# Create NB_USER user with UID=1000 and in the 'users' group
# but allow for non-initial launches of the notebook to have
# $HOME provided by the contents of a PV
RUN useradd -M -s /bin/bash -N -u $NB_UID $NB_USER && \
    chown -R ${NB_USER}:users /usr/local/bin && \
    mkdir -p $HOME && \
    chown -R jovyan:users /home/*

COPY jupyterhub/docker-entrypoint.sh /home/entrypoint.sh
RUN chmod +x /home/entrypoint.sh

EXPOSE 8888
USER jovyan
ENTRYPOINT ["tini", "--", "/home/entrypoint.sh"]