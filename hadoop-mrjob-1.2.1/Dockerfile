# Creates pseudo distributed hadoop 1.2.2 with MrJob 0.4.3-dev
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
RUN apt-get install -y curl tar sudo openssh-server openssh-client rsync software-properties-common vim git

# install pip and virtual-env
RUN apt-get install -y python-pip python-numpy python-scipy 

# install python virtualenv
RUN pip install virtualenv

# mrjob 0.4.2
RUN cd /root && virtualenv --system-site-packages mrjob0.4.2 && . ./mrjob0.4.2/bin/activate && pip install -I mrjob && deactivate

# mrjob 0.4.3-dev
RUN cd /root && git clone https://github.com/yelp/mrjob
RUN cd /root && virtualenv --system-site-packages mrjob0.4.3-dev && . ./mrjob0.4.3-dev/bin/activate && cd mrjob && python setup.py install && deactivate
RUN cd /root && rm -rf mrjob

# passwordless ssh
RUN test -f /etc/ssh/ssh_host_dsa_key || ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key
RUN test -f /etc/ssh/ssh_host_rsa_key || ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa
RUN cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys


# java

RUN apt-get purge -y openjdk*
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
RUN add-apt-repository -y ppa:webupd8team/java
RUN apt-get update
RUN apt-get install -y oracle-java7-installer

ENV JAVA_HOME /usr/lib/jvm/java-7-oracle
ENV PATH $PATH:$JAVA_HOME/bin


# hadoop
RUN curl -s https://archive.apache.org/dist/hadoop/core/hadoop-1.2.1/hadoop-1.2.1.tar.gz | tar -xz -C /usr/local/

RUN cd /usr/local && ln -s ./hadoop-1.2.1 hadoop

ENV HADOOP_PREFIX /usr/local/hadoop
ENV HADOOP_HOME /usr/local/hadoop
ENV HADOOP_COMMON_HOME /usr/local/hadoop
ENV HADOOP_HDFS_HOME /usr/local/hadoop
ENV HADOOP_MAPRED_HOME /usr/local/hadoop
ENV HADOOP_YARN_HOME /usr/local/hadoop
ENV HADOOP_CONF_DIR /usr/local/hadoop/conf
# ENV YARN_CONF_DIR $HADOOP_PREFIX/etc/hadoop

RUN sed -i '/^# export JAVA_HOME/ s:.*:export JAVA_HOME=/usr/lib/jvm/java-7-oracle\nexport HADOOP_PREFIX=/usr/local/hadoop\nexport HADOOP_HOME=/usr/local/hadoop\nexport HADOOP_CONF_DIR=/usr/local/hadoop/conf/\n:' $HADOOP_PREFIX/conf/hadoop-env.sh
# RUN sed -i '/^export HADOOP_CONF_DIR/ s:.*:export HADOOP_CONF_DIR=/usr/local/hadoop/conf/:' $HADOOP_PREFIX/conf/hadoop-env.sh
#RUN . $HADOOP_PREFIX/etc/hadoop/hadoop-env.sh

RUN mkdir $HADOOP_PREFIX/input
RUN cp $HADOOP_PREFIX/conf/*.xml $HADOOP_PREFIX/input

# pseudo distributed
ADD core-site.xml.template $HADOOP_PREFIX/conf/core-site.xml.template
RUN sed s/HOSTNAME/localhost/ /usr/local/hadoop/conf/core-site.xml.template > /usr/local/hadoop/conf/core-site.xml
ADD hdfs-site.xml $HADOOP_PREFIX/conf/hdfs-site.xml

ADD mapred-site.xml.template $HADOOP_PREFIX/conf/mapred-site.xml.template
RUN sed s/HOSTNAME/localhost/ /usr/local/hadoop/conf/mapred-site.xml.template > /usr/local/hadoop/conf/mapred-site.xml

# Disable IPv6
ADD system/sysctl.conf /etc/sysctl.conf
ADD system/start-dfs.sh $HADOOP_PREFIX/bin/start-dfs.sh
ADD system/.mrjob.conf /root/.mrjob.conf


# RUN $HADOOP_PREFIX/bin/hadoop namenode -format

ADD ssh_config /root/.ssh/config
RUN chmod 600 /root/.ssh/config
RUN chown root:root /root/.ssh/config

# Add bootstrap file
ADD bootstrap.sh /etc/bootstrap.sh
RUN chown root:root /etc/bootstrap.sh
RUN chmod 700 /etc/bootstrap.sh
ENV BOOTSTRAP /etc/bootstrap.sh

# workingaround docker.io build error
RUN ls -la /usr/local/hadoop/conf/*-env.sh
RUN chmod +x /usr/local/hadoop/conf/*-env.sh
RUN ls -la /usr/local/hadoop/conf/*-env.sh

# fix the 254 error code
RUN sed  -i "/^[^#]*UsePAM/ s/.*/#&/"  /etc/ssh/sshd_config
RUN echo "UsePAM no" >> /etc/ssh/sshd_config
RUN echo "Port 2122" >> /etc/ssh/sshd_config

CMD ["/etc/bootstrap.sh", "-d"]

EXPOSE 50020 50090 50070 50010 50075 8031 8032 8033 8040 8042 49707 22 8088 8030 54311 54310 9001 9000
