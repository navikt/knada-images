FROM ghcr.io/navikt/jupyterlab:2022-05-23-5a558a3

USER root

# Add TDV ODBC driver and set env
COPY TDV/driver/libcomposite82_x64.so /opt/TDV/driver/libcomposite82_x64.so
RUN chown -R jovyan:users  /opt/TDV
ENV TDV_ODBC_DRIVER /opt/TDV/driver/libcomposite82_x64.so

COPY requirements.txt /requirements.jkbl.txt
RUN pip install -r /requirements.jkbl.txt

USER ${NB_UID}
