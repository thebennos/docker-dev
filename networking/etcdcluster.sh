PUBLIC_IP=$(/usr/sbin/ip -o -4 addr list $1 | grep global | awk '{print $4}' | cut -d/ -f1 | head -1)
docker run -d -p 8001:8001 -p 5001:5001 quay.io/philipsoutham/etcd -peer-addr ${PUBLIC_IP}:8001 -addr ${PUBLIC_IP}:5001 -name etcd-node1
docker run -d -p 8002:8002 -p 5002:5002 quay.io/philipsoutham/etcd -peer-addr ${PUBLIC_IP}:8002 -addr ${PUBLIC_IP}:5002 -name etcd-node2 -peers ${PUBLIC_IP}:8001,${PUBLIC_IP}:8002,${PUBLIC_IP}:8003
docker run -d -p 8003:8003 -p 5003:5003 quay.io/philipsoutham/etcd -peer-addr ${PUBLIC_IP}:8003 -addr ${PUBLIC_IP}:5003 -name etcd-node3 -peers ${PUBLIC_IP}:8001,${PUBLIC_IP}:8002,${PUBLIC_IP}:8003
