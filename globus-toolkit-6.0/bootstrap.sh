#!/bin/bash


echo "###################################"
echo " The system is being inizialized..."
echo "###################################"

rm /tmp/*.pid > /dev/null 2>&1

service ssh start > /dev/null 2>&1

if [[ $1 == "-d" ]]; then
  while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
    /bin/bash
fi
