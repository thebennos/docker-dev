#!/usr/bin/env bash

# Accept listen_address
IP=${LISTEN_ADDRESS:-`hostname --ip-address`}

BIP=${BROADCAST_ADDRESS:-`hostname --ip-address`}

# Accept seeds via docker run -e SEEDS=seed1,seed2,...
SEEDS=${SEEDS:-$IP}

# Backwards compatibility with older scripts that just passed the seed in
if [ $# == 1 ]; then SEEDS="$1,$SEEDS"; fi

#if this container was linked to any other cassandra nodes, use them as seeds as well.
if [[ `env | grep _PORT_9042_TCP_ADDR` ]]; then
  SEEDS="$SEEDS,$(env | grep _PORT_9042_TCP_ADDR | sed 's/.*_PORT_9042_TCP_ADDR=//g' | sed -e :a -e N -e 's/\n/,/' -e ta)"
fi

echo Configuring Cassandra to listen at $IP with seeds $SEEDS and broadcast at $BIP

# Setup Cassandra
# DEFAULT=${DEFAULT:-/etc/cassandra/default.conf}
# CONFIG=/etc/cassandra/conf

# rm -rf $CONFIG && cp -r $DEFAULT $CONFIG
sed -i -e "s/^listen_address.*/listen_address: $IP/"            $CASSANDRA_CONFIG/cassandra.yaml
sed -i -e "s/^rpc_address.*/rpc_address: 0.0.0.0/"              $CASSANDRA_CONFIG/cassandra.yaml
sed -i -e "s/# broadcast_address.*/broadcast_address: $BIP/"              $CASSANDRA_CONFIG/cassandra.yaml
sed -i -e "s/# broadcast_rpc_address.*/broadcast_rpc_address: $IP/"              $CASSANDRA_CONFIG/cassandra.yaml
sed -i -e "s/^commitlog_segment_size_in_mb.*/commitlog_segment_size_in_mb: 64/"              $CASSANDRA_CONFIG/cassandra.yaml
sed -i -e "s/- seeds: \"127.0.0.1\"/- seeds: \"$SEEDS\"/"       $CASSANDRA_CONFIG/cassandra.yaml
sed -i -e "s/# JVM_OPTS=\"$JVM_OPTS -Djava.rmi.server.hostname=<public name>\"/ JVM_OPTS=\"$JVM_OPTS -Djava.rmi.server.hostname=$IP\"/" $CASSANDRA_CONFIG/cassandra-env.sh

if [[ $SNITCH ]]; then
  sed -i -e "s/endpoint_snitch: SimpleSnitch/endpoint_snitch: $SNITCH/" $CASSANDRA_CONFIG/cassandra.yaml
fi
if [[ $DC && $RACK ]]; then
  echo "dc=$DC" > $CASSANDRA_CONFIG/cassandra-rackdc.properties
  echo "rack=$RACK" >> $CASSANDRA_CONFIG/cassandra-rackdc.properties
fi

# Start process
echo Starting Cassandra on $IP...
cassandra -f
