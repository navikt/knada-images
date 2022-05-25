FROM jupyter/base-notebook:python-3.9.12

USER root

RUN apt-get update -y && apt-get install -y software-properties-common && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9 && \
    add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran40/' && \
    apt-get install -yq --no-install-recommends \
    fonts-dejavu \
    unixodbc \
    unixodbc-dev \
    gdebi-core \
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
    gdebi-core \ 
    psmisc \
    libclang-dev \
    libblas-dev \
    libudunits2-dev \
    libgdal-dev \
    libv8-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN ln -s /bin/tar /bin/gtar

# Install oracle client
RUN curl https://download.oracle.com/otn_software/linux/instantclient/1915000/oracle-instantclient19.15-basic-19.15.0.0.0-1.x86_64.rpm -o /tmp/oracle-instantclient.rpm
RUN alien -i /tmp/oracle-instantclient.rpm && \
    rm -rf /var/cache/yum && \
    rm -f /mp/oracle-instantclient.rpm && \
    echo /usr/lib/oracle/19.15/client64/lib > /etc/ld.so.conf.d/oracle-instantclient19.15.conf && \
    ldconfig
ENV PATH=$PATH:/usr/lib/oracle/19.15/client64/bin

# Install Rstudio
RUN wget https://download2.rstudio.org/server/xenial/amd64/rstudio-server-1.4.1106-amd64.deb
RUN apt-get update -yq && apt-get install -y ./rstudio-server-1.4.1106-amd64.deb && \
    rm rstudio-server-1.4.1106-amd64.deb
# Siste image nedenfor
#RUN wget https://download2.rstudio.org/server/bionic/amd64/rstudio-server-2022.02.2-485-amd64.deb && \
#    sudo gdebi rstudio-server-2022.02.2-485-amd64.deb


ENV TZ="Europe/Oslo"

COPY requirements.txt /requirements.txt
COPY install_packages.R /install_packages.R
COPY install_nav_packages.R /install_nav_packages.R

# Install Python packages
RUN pip install -r /requirements.txt

# Install packages from cran
RUN Rscript /install_packages.R

# Install NAV packages
RUN git clone https://github.com/navikt/dataverkr
RUN Rscript /install_nav_packages.R

## Set Rstudio environment variables
COPY envs /home/envs
RUN cat /home/envs >> /usr/lib/R/etc/Renviron && \
    rm /home/envs

# Give joyvan rights to write to Renviron
RUN chown -R ${NB_UID}:${NB_UID} /usr/lib/R/etc
RUN chmod 666 /usr/lib/R/etc/Renviron

USER ${NB_UID}

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
