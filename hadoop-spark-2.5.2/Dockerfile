# Creates pseudo distributed hadoop 2.5.2
#

FROM cineca/hadoop:2.5.2
MAINTAINER www.hpc.cineca.it

USER root

RUN curl -s http://apache.fis.uniroma2.it/spark/spark-1.1.0/spark-1.1.0-bin-hadoop2.4.tgz | tar -xz -C /usr/local/
RUN cd /usr/local && ln -s spark-1.1.0-bin-hadoop2.4 spark
RUN mkdir /usr/local/spark/yarn-remote-client
ADD yarn-remote-client /usr/local/spark/yarn-remote-client

RUN service ssh start && $HADOOP_PREFIX/etc/hadoop/hadoop-env.sh && $HADOOP_PREFIX/sbin/start-dfs.sh && $HADOOP_PREFIX/bin/hdfs dfsadmin -safemode leave && $HADOOP_PREFIX/bin/hdfs dfs -put /usr/local/spark-1.1.0-bin-hadoop2.4/lib /spark

ENV YARN_CONF_DIR $HADOOP_PREFIX/etc/hadoop
ENV SPARK_JAR hdfs:///spark/spark-assembly-1.1.0-hadoop2.4.0.jar
ENV SPARK_HOME /usr/local/spark
ENV PATH $PATH:$SPARK_HOME/bin:$HADOOP_PREFIX/bin

CMD ["/etc/bootstrap.sh", "-d"]
