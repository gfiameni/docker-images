#!/bin/bash

: ${HADOOP_PREFIX:=/usr/local/hadoop}

$HADOOP_PREFIX/conf/hadoop-env.sh
export PATH=$PATH:$HADOOP_PREFIX/bin:$JAVA_HOME/bin

echo "###################################"
echo " The system is being inizialized..."
echo "###################################"
echo ""
echo "-> Type show-exercises to view some" 
echo "   job submission commands."

rm /tmp/*.pid > /dev/null 2>&1

# installing libraries if any - (resource urls added comma separated to the ACP system variable)
# cd $HADOOP_PREFIX/share ; for cp in ${ACP//,/ }; do  echo == $cp; curl -LO $cp ; done; cd -

# altering the core-site configuration
sed s/HOSTNAME/$HOSTNAME/ /usr/local/hadoop/conf/core-site.xml.template > /usr/local/hadoop/conf/core-site.xml
sed s/HOSTNAME/$HOSTNAME/ /usr/local/hadoop/conf/mapred-site.xml.template > /usr/local/hadoop/conf/mapred-site.xml


service ssh start > /dev/null 2>&1
$HADOOP_PREFIX/bin/hadoop namenode -format > /dev/null 2>&1
$HADOOP_PREFIX/bin/start-all.sh > /dev/null 2>&1

if [[ $1 == "-d" ]]; then
  while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
  cd /exercises && /bin/bash
fi
