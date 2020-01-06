ARG PYTHON_VERSION=3.8
FROM python:${PYTHON_VERSION}
RUN apt-get update \
	&& apt-get -yq install unzip \
	&& apt-get -yq install libaio1 \
	&& apt-get -yq autoremove \
	&& apt-get clean

# ORACLE SETUP
# Variables
ARG ORACLE_VERSION=19.5.0.0.0dbru
ARG ORACLE_ZIP_INTERNAL_FOLDER=instantclient_19_5
ENV CLIENT_ZIP=instantclient-basiclite-linux.x64-${ORACLE_VERSION}.zip
ENV SDK_ZIP=instantclient-sdk-linux.x64-${ORACLE_VERSION}.zip
ENV ORACLE_HOME /opt/oracle
ENV TNS_ADMIN ${ORACLE_HOME}/network/admin
# Steps
WORKDIR /oracle_setup
COPY assets/oracle/${CLIENT_ZIP} .
COPY assets/oracle/${SDK_ZIP} .
RUN unzip ${CLIENT_ZIP}
RUN unzip ${SDK_ZIP}
RUN mv ${ORACLE_ZIP_INTERNAL_FOLDER} ${ORACLE_HOME}
VOLUME ["${TNS_ADMIN}"]
RUN echo ${ORACLE_HOME} > /etc/ld.so.conf.d/oracle.conf \
	&& mkdir -p ${TNS_ADMIN} \
	&& ldconfig \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
# Python
RUN pip install cx_oracle

