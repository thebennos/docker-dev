FROM twistedogic/spark-hdfs-base
MAINTAINER Jordan Li

COPY start.sh /
COPY supervisord.conf /etc/supervisord.conf

ENV HDFS_DATANODE_ROOT_DIR /var/hdfs/datanode

ADD conf/core-site.xml	/etc/hadoop/etc/hadoop/core-site.xml
ADD conf/hdfs-site.xml	/etc/hadoop/etc/hadoop/hdfs-site.xml

ADD start-hdfs-dn /usr/local/sbin/start-hdfs-dn

VOLUME ["/var/hdfs/datanode"]

# TCP	50010	dfs.datanode.address		port for data transfer
# TCP	50020	dfs.datanode.ipc.address	ipc server
# TCP	50075	dfs.datanode.http.address	http server
# TCP	50475	dfs.datanode.https.address	https server

EXPOSE 50010 50020 50075 50475

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
