# Creates Globus Toolkit 6.0 building environment
#
# Taken inputs from sequenceiq/hadoop image

FROM ubuntu:14.04
MAINTAINER www.hpc.cineca.it (Giuseppe Fiameni)

USER root
#Setup build environment for libpam
# RUN apt-get update && apt-get -y build-dep pam

RUN apt-get update && apt-get upgrade -y

#Rebuild and istall libpam with --disable-audit option
# RUN export CONFIGURE_OPTS=--disable-audit && cd /root && apt-get -b source pam && dpkg -i libpam-doc*.deb libpam-modules*.deb libpam-runtime*.deb libpam0g*.deb

# install dev tools
RUN apt-get install -y curl tar sudo openssh-server openssh-client rsync software-properties-common vim git python-dev

# install postgresql
RUN apt-get install -y postgresql postgresql-contrib

# install gdebi-core

RUN apt-get install -y gdebi-core

# install iRODS

RUN apt-get install -y libfuse2 libssl0.9.8

RUN cd /root && curl -LO ftp://ftp.renci.org/pub/irods/releases/4.0.3/irods-icat-4.0.3-64bit.deb && yes | gdebi irods-icat-4.0.3-64bit.deb

RUN cd /root && curl -LO ftp://ftp.renci.org/pub/irods/releases/4.0.3-with-v1.4-database-plugins/irods-database-plugin-postgres-1.4.deb && yes | gdebi irods-database-plugin-postgres-1.4.deb

RUN cd /root && rm -rf *.deb

RUN apt-get autoclean

# Disable IPv6
ADD system/sysctl.conf /etc/sysctl.conf

# Add bootstrap file
ADD bootstrap.sh /etc/bootstrap.sh
RUN chown root:root /etc/bootstrap.sh
RUN chmod 700 /etc/bootstrap.sh
ENV BOOTSTRAP /etc/bootstrap.sh

# fix the 254 error code
RUN sed  -i "/^[^#]*UsePAM/ s/.*/#&/"  /etc/ssh/sshd_config
RUN echo "UsePAM no" >> /etc/ssh/sshd_config
RUN echo "Port 2122" >> /etc/ssh/sshd_config

# start PostgreSQL

ADD create_db.sql /tmp/create_db.sql
RUN service postgresql start && su - postgres -c 'psql < /tmp/create_db.sql'

CMD ["/etc/bootstrap.sh", "-d"]

EXPOSE 22 1247 5432 20000 20001 20002 20003 20004 20005 20006 20007 20008 20009 20010 20011 20012 20013 20014 20015 20016 20017 20018 20019 20020 20021 20022 20023 20024 20025 20026 20027 20028 20029 20030 20031 20032 20033 20034 20035 20036 20037 20038 20039 20040 20041 20042 20043 20044 20045 20046 20047 20048 20049 20050 20051 20052 20053 20054 20055 20056 20057 20058 20059 20060 20061 20062 20063 20064 20065 20066 20067 20068 20069 20070 20071 20072 20073 20074 20075 20076 20077 20078 20079 20080 20081 20082 20083 20084 20085 20086 20087 20088 20089 20090 20091 20092 20093 20094 20095 20096 20097 20098 20099 20100


