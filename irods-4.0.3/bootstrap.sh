#!/bin/bash


cat << EOF 

 The container is being inizialized...

 -----------------------------------
    _   _   _   __          _    _  
 o |_) / \ | \ (_    |_|_  / \   _) 
 | | \ \_/ |_/ __)     | o \_/ o _) 

 -----------------------------------


EOF

rm /tmp/*.pid > /dev/null 2>&1

service ssh start > /dev/null 2>&1
service postgresql start > /dev/null 2>&1

echo " -------------------------------------"
echo " PostgreSQL DB => ICAT"
echo "            Port => 5432"
echo "            Host => 127.0.0.1"
echo "            User => irods"
echo "            Pass => irods"
echo " -------------------------------------"
echo " iRODS                                "
echo "            Range => 20000 - 20100"
echo " -------------------------------------"

echo " * Launch /var/lib/irods/packaging/setup_irods.sh to configure iRODS * "
echo " ----------------------------------------------------------------------"

if [[ $1 == "-d" ]]; then
  while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
    /bin/bash
fi
