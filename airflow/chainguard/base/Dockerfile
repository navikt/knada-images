ARG AIRFLOW_FORK_BRANCH=v2-11-stable
ARG AIRFLOW_FORK_REPOSITORY=https://github.com/navikt/airflow-2-fork

FROM europe-north1-docker.pkg.dev/cgr-nav/pull-through/nav.no/node:24-dev as nodeBuilder

RUN git clone ${AIRFLOW_FORK_REPOSITORY} airflow-2-fork
WORKDIR /app/airflow-2-fork

RUN git checkout ${AIRFLOW_FORK_BRANCH} && \
    cd airflow/www && \
    npm install --force && \
    npm run build

FROM europe-north1-docker.pkg.dev/cgr-nav/pull-through/nav.no/python:3.12-dev as dev

ARG AIRFLOW_USER=airflow
ARG AIRFLOW_UID=50000
ARG AIRFLOW_USER_HOME_DIR=/home/airflow

USER root

RUN adduser --disabled-password "${AIRFLOW_USER}" --uid "${AIRFLOW_UID}" -g "0" --home "${AIRFLOW_USER_HOME_DIR}" && \
    mkdir -p "${AIRFLOW_USER_HOME_DIR}" && chown -R "${AIRFLOW_USER}:0" "${AIRFLOW_USER_HOME_DIR}"

ENV PATH="${AIRFLOW_USER_HOME_DIR}/.local/bin:${PATH}"
ENV PYTHONPATH="${AIRFLOW_USER_HOME_DIR}/.local/lib/python3.12/site-packages"
RUN pip config set global.prefix "${AIRFLOW_USER_HOME_DIR}/.local"

COPY airflow/chainguard/base/requirements.txt .
RUN pip3 install \ 
 --upgrade \
 -r requirements.txt

# Pathlib is part of the standard distro for python 3.12, and installing it from pip is
# meant for python versions < 3.4 and other dependencies that require it are incompatible with the non standard distro version.
# It is however included as a dependency for some of the packages we install which causes a conflict
# when it is imported (https://stackoverflow.com/questions/78780698/cannot-import-name-sequence-from-collections)
# Pip also breaks as it uses pathlib so below we need to remove the library manually.
RUN rm -rf ${PYTHONPATH}/pathlib-1.0.1.dist-info/ && \
    rm ${PYTHONPATH}/pathlib.py

RUN mkdir -p /opt/airflow && chown -R "${AIRFLOW_USER}:0" /opt/airflow

COPY airflow/chainguard/base/clean-logs.sh /clean-logs
COPY airflow/chainguard/base/entrypoint.sh /entrypoint

# Copy UI dist folder from nodeBuilder stage
COPY --from=nodeBuilder /app/airflow-2-fork/airflow/www/static/dist ${PYTHONPATH}/airflow/www/static/dist

USER ${AIRFLOW_UID}
WORKDIR /opt/airflow

CMD []
ENTRYPOINT []