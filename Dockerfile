ARG PYTHON_VERSION=3.8
FROM python:${PYTHON_VERSION}

# ORACLE SETUP
# Variables
ARG ORACLE_VERSION=19.5.0.0.0dbru
ARG ORACLE_ZIP_INTERNAL_FOLDER=instantclient_19_5
ENV CLIENT_ZIP=instantclient-basiclite-linux.x64-${ORACLE_VERSION}.zip
ENV SDK_ZIP=instantclient-sdk-linux.x64-${ORACLE_VERSION}.zip
ENV ORACLE_HOME /opt/oracle
ENV TNS_ADMIN ${ORACLE_HOME}/network/admin
# Steps
RUN apt-get update \
	&& apt-get -yq install unzip \
	&& apt-get -yq install libaio1
WORKDIR /oracle_setup
COPY assets/oracle/${CLIENT_ZIP} .
COPY assets/oracle/${SDK_ZIP} .
RUN unzip ${CLIENT_ZIP}
RUN unzip ${SDK_ZIP}
RUN mv ${ORACLE_ZIP_INTERNAL_FOLDER} ${ORACLE_HOME}
VOLUME ["${TNS_ADMIN}"]
RUN echo ${ORACLE_HOME} > /etc/ld.so.conf.d/oracle.conf \
	&& mkdir -p ${TNS_ADMIN} \
	&& ldconfig

# SQL SERVER SETUP
# adding custom MS repository
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/19.04/prod.list > /etc/apt/sources.list.d/mssql-release.list
# install SQL Server depencencies
RUN apt-get update \
	&& apt-get install -yq curl apt-utils apt-transport-https debconf-utils gcc build-essential locales \
	&& ACCEPT_EULA=Y apt-get install -y msodbcsql17 unixodbc-dev mssql-tools 
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
RUN /bin/bash -c "source ~/.bashrc"
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen

# CLEAN UP
RUN apt-get -yq autoremove \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
