FROM jupyter/base-notebook:python-3.9.6

USER root

RUN apt-get update -y && apt-get install -y software-properties-common && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9 && \
    add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran40/' && \
    apt-get install -yq --no-install-recommends \
    fonts-dejavu \
    unixodbc \
    unixodbc-dev \
    gdebi \
    r-cran-rodbc \
    r-base \
    gfortran \
    gcc \
    build-essential \
    curl \
    alien \
    libcurl4-gnutls-dev \
    libxml2-dev \
    libssl-dev \
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
    connect-proxy \
    libblas-dev \
    libudunits2-dev \
    libgdal-dev \
    libv8-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN ln -s /bin/tar /bin/gtar

# Install oracle client
ADD jupyterhub-r/oracle_client/oracle-instantclient* /tmp/
RUN alien -i /tmp/oracle-instantclient* && \
    rm -rf /var/cache/yum && \
    rm -f /mp/oracle-instantclient* && \
    echo /usr/lib/oracle/19.9/client64/lib > /etc/ld.so.conf.d/oracle-instantclient19.9.conf && \
    ldconfig

ENV PATH=$PATH:/usr/lib/oracle/19.9/client64/bin

# Install Rstudio
RUN wget https://download2.rstudio.org/server/bionic/amd64/rstudio-server-1.2.1335-amd64.deb
RUN apt-get update -yq && apt-get install -y ./rstudio-server-1.2.1335-amd64.deb && \
    rm rstudio-server-1.2.1335-amd64.deb
#
# Install Jupyterlab R extension
RUN pip install jupyter-server-proxy jupyter-rsession-proxy
RUN jupyter labextension install @jupyterlab/server-proxy && \
    jupyter serverextension enable --sys-prefix jupyter_server_proxy

ENV TZ="Europe/Oslo"

COPY jupyterhub-r/requirements.txt /requirements.txt
COPY jupyterhub-r/install_packages.R /install_packages.R
COPY jupyterhub-r/install_nav_packages.R /install_nav_packages.R

# Install Python packages
RUN pip install -r /requirements.txt

# Install packages from cran
RUN Rscript /install_packages.R

# Install NAV packages
RUN git clone https://github.com/navikt/dataverkr
RUN Rscript /install_nav_packages.R

## Set Rstudio environment variables
COPY jupyterhub-r/envs /home/envs
RUN cat /home/envs >> /usr/lib/R/etc/Renviron && \
    rm /home/envs

USER ${NB_UID}

COPY jupyterhub-r/entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
