FROM mesosphere/mesos:0.21.1-1.1.ubuntu1404
MAINTAINER Jordan Li

RUN apt-get update && apt-get install -y wget supervisor unzip

RUN wget https://dl.bintray.com/mitchellh/serf/0.6.4_linux_amd64.zip -P /tmp
RUN unzip /tmp/0.6.4_linux_amd64.zip -d $SERF_HOME/bin && rm -f /tmp/0.6.4_linux_amd64.zip

COPY serf_init.sh $SERF_HOME/bin/serf_init.sh
RUN chmod +x $SERF_HOME/bin/*