#!/bin/bash
location=$(pwd)
CID=$(docker run -h master --name mesos -m=104857600 -d -p 5050:5050 -p 8080:8081 -p 9002:22 -p 2181:2181 -p 8500:8500 mesos-master)
MIP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${CID})
cp ${location}/template.conf ${location}/supervisor_conf/supervisord.conf
sed -i "s|CHANGEME|${MIP}|" ${location}/supervisor_conf/supervisord.conf
S1=$(docker run -h slave1 --name mesos-slave1 -d -v ${location}/supervisor_conf:/etc/supervisor/conf.d/ -m=104857600 mesos-slave)
S3IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${S3})
echo ${MIP}
echo ${S1IP}
docker ps -a
