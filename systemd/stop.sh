docker stop chronos
docker stop mesos_slave
docker stop mesos_master
docker stop zookeeper
docker rm -v chronos
docker rm -v mesos_slave
docker rm -v mesos_master
docker rm -v zookeeper