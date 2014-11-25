#!/bin/bash

: ${HADOOP_PREFIX:=/usr/local/hadoop}

$HADOOP_PREFIX/etc/hadoop/hadoop-env.sh
export PATH=$PATH:$HADOOP_PREFIX/bin:$JAVA_HOME/bin

echo "###################################"
echo " The system is being inizialized..."
echo "###################################"
echo ""
echo "  > Hadoop 2.5.2 <"
echo ""
echo "- Type show-exercises to view some" 
echo "  job submission commands."

rm /tmp/*.pid > /dev/null 2>&1

# installing libraries if any - (resource urls added comma separated to the ACP system variable)
# cd $HADOOP_PREFIX/share/hadoop/common ; for cp in ${ACP//,/ }; do  echo == $cp; curl -LO $cp ; done; cd -

# altering the core-site configuration
sed s/HOSTNAME/$HOSTNAME/ /usr/local/hadoop/etc/hadoop/core-site.xml.template > /usr/local/hadoop/etc/hadoop/core-site.xml


service ssh start > /dev/null 2>&1
$HADOOP_PREFIX/sbin/start-dfs.sh > /dev/null 2>&1
$HADOOP_PREFIX/sbin/start-yarn.sh > /dev/null 2>&1

if [[ $1 == "-d" ]]; then
  while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
  cd / && git clone https://github.com/gfiameni/course-exercises > /dev/null 2>&1
  echo "alias show-exercises=\"cat /course-exercises/README\"" >> /root/.bashrc
  cd /course-exercises && /bin/bash
fi

