FROM jupyter/base-notebook:python-3.7.4

USER root

RUN apt-get update -y && apt-get install -yq --no-install-recommends \
    fonts-dejavu \
    unixodbc \
    unixodbc-dev \
    r-cran-rodbc \
    r-base \
    gfortran \
    gcc \
    build-essential \
    curl \
    alien \
    libaio1 \
    libaio-dev \
    libpq-dev \
    libxml2-dev \
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
    make \
    fonts-dejavu \
    gfortran \
    connect-proxy && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN ln -s /bin/tar /bin/gtar

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

# Install basic R packages
RUN conda install --quiet --yes \
    'r-devtools=2.3*' \
    'r-hexbin=1.28*' \
    'r-htmltools=0.4*' \
    'r-htmlwidgets=1.5*' \
    'r-irkernel=1.1*' \
    'r-rmarkdown=2.2*' \
    'r-rodbc=1.3*' \
    'r-rsqlite=2.2*' \
    'r-shiny=1.4*' \
    'unixodbc=2.3.*' \
    'r-essentials' \
    'r-reticulate' \
    'r-tidyverse' \
    && \
    conda clean --all -f -y && \
    fix-permissions "${CONDA_DIR}"

# Install Rstudio
RUN wget https://download2.rstudio.org/server/bionic/amd64/rstudio-server-1.2.1335-amd64.deb
RUN apt-get update -yq && apt-get install -y ./rstudio-server-1.2.1335-amd64.deb && \
    rm rstudio-server-1.2.1335-amd64.deb

# Install Jupyterlab R extension
RUN pip install jupyter-server-proxy jupyter-rsession-proxy
RUN jupyter labextension install @jupyterlab/server-proxy && \
    jupyter serverextension enable --sys-prefix jupyter_server_proxy

# Install Python packages
COPY jupyterhub-r/requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

# Clone dataverkr library
RUN git clone https://github.com/navikt/dataverkr

# Install custom R packages
COPY jupyterhub-r/install_packages.R /install_packages.R
RUN Rscript /install_packages.R

# Set dataverk and python environment variables
ENV REQUESTS_CA_BUNDLE /etc/pki/tls/certs/ca-bundle.crt
ENV SSL_CERT_FILE /etc/pki/tls/certs/ca-bundle.crt
ENV DATAVERK_BUCKET_ENDPOINT https://dv-resource-rw-api.nais.adeo.no/storage
ENV DATAVERK_API_ENDPOINT https://data.adeo.no/api
ENV DATAVERK_ES_HOST=https://dv-resource-rw-api.nais.adeo.no/index/write/dcat

# Set Rstudio environment variables
COPY jupyterhub-r/envs /home/envs
RUN cat /home/envs >> /opt/conda/lib/R/etc/Renviron && \
    rm /home/envs

USER ${NB_UID}
