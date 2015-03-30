# Creates Globus Toolkit 6.0 building environment
#
# Taken inputs from sequenceiq/hadoop image

FROM ubuntu:14.04
MAINTAINER www.hpc.cineca.it (Giuseppe Fiameni)

USER root
#Setup build environment for libpam
RUN apt-get update && apt-get -y build-dep pam

#Rebuild and istall libpam with --disable-audit option
RUN export CONFIGURE_OPTS=--disable-audit && cd /root && apt-get -b source pam && dpkg -i libpam-doc*.deb libpam-modules*.deb libpam-runtime*.deb libpam0g*.deb

# install dev tools
RUN apt-get install -y curl tar sudo openssh-server openssh-client rsync software-properties-common vim git python-dev

# install globus repository
RUN cd /root && wget http://toolkit.globus.org/ftppub/gt6/installers/repo/globus-toolkit-repo_latest_all.deb && dpkg -i globus-toolkit-repo_latest_all.deb

RUN apt-get update && apt-get -y install globus-gridftp globus-gram5 globus-gsi globus-data-management-server globus-data-management-client globus-data-management-sdk globus-resource-management-server globus-resource-management-client globus-resource-management-sdk

RUN rm -rf /root/globus-toolkit-repo_latest_all.deb
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

CMD ["/etc/bootstrap.sh", "-d"]

EXPOSE 8088
