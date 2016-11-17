#!/bin/bash

mkdir /kube
cd /kube

cat <<EOF > /etc/yum.repos.d/virt7-docker-common-release.repo
[virt7-docker-common-release]
name=virt7-docker-common-release
baseurl=http://cbs.centos.org/repos/virt7-docker-common-release/x86_64/os/
gpgcheck=0
EOF
yum -y install --enablerepo=virt7-docker-common-release kubernetes etcd flannel
echo "Enter the master ip"
read master

cat <<EOF > /etc/kubernetes/config
# Comma separated list of nodes in the etcd cluster
KUBE_ETCD_SERVERS="--etcd-servers=http://$master:2379"
# logging to stderr means we get it in the systemd journal
KUBE_LOGTOSTDERR="--logtostderr=true"
# journal message level, 0 is debug
KUBE_LOG_LEVEL="--v=0"
# Should this cluster be allowed to run privileged docker containers
KUBE_ALLOW_PRIV="--allow-privileged=false"
# How the replication controller and scheduler find the kube-apiserver
KUBE_MASTER="--master=http://$master:8080"
EOF

systemctl disable iptables-services firewalld
systemctl stop iptables-services firewalld



cat <<EOF > /etc/etcd/etcd.conf
# [member]
ETCD_NAME=default
ETCD_DATA_DIR="/var/lib/etcd/default.etcd"
ETCD_LISTEN_CLIENT_URLS="http://0.0.0.0:2379"
#[cluster]
ETCD_ADVERTISE_CLIENT_URLS="http://0.0.0.0:2379"
EOF

cat <<EOF > /etc/kubernetes/apiserver
# The address on the local server to listen to.
KUBE_API_ADDRESS="--address=0.0.0.0"
# The port on the local server to listen on.
KUBE_API_PORT="--port=8080"
# Port kubelets listen on
KUBELET_PORT="--kubelet-port=10250"
# Address range to use for services
KUBE_SERVICE_ADDRESSES="--service-cluster-ip-range=10.254.0.0/16"
# Add your own!
KUBE_API_ARGS=""
EOF

service etcd start
etcdctl mkdir /kube-centos/network
etcdctl mk /kube-centos/network/config "{ \"Network\": \"172.30.0.0/16\", \"SubnetLen\": 24, \"Backend\": { \"Type\": \"vxlan\" } }"

cat <<EOF > /etc/sysconfig/flanneld
# etcd url location.  Point this to the server where etcd runs
FLANNEL_ETCD="http://centos-master:2379"
# etcd config key.  This is the configuration key that flannel queries
# For address range assignment
FLANNEL_ETCD_KEY="/kube-centos/network"
# Any additional options that you want to pass
FLANNEL_OPTIONS=""
EOF

for SERVICES in etcd kube-apiserver kube-controller-manager kube-scheduler flanneld; do
	systemctl restart $SERVICES
	systemctl enable $SERVICES
	systemctl status $SERVICES
done

touch minion.sh
cat <<EOF > /kube/minion.sh
#!/bin/bash

cat <<DONE > /etc/yum.repos.d/virt7-docker-common-release.repo
[virt7-docker-common-release]
name=virt7-docker-common-release
baseurl=http://cbs.centos.org/repos/virt7-docker-common-release/x86_64/os/
gpgcheck=0
DONE

yum -y install --enablerepo=virt7-docker-common-release kubernetes etcd flannel

cat <<DONE > /etc/kubernetes/config
# Comma separated list of nodes in the etcd cluster
KUBE_ETCD_SERVERS="--etcd-servers=http://$master:2379"
# logging to stderr means we get it in the systemd journal
KUBE_LOGTOSTDERR="--logtostderr=true"
# journal message level, 0 is debug
KUBE_LOG_LEVEL="--v=0"
# Should this cluster be allowed to run privileged docker containers
KUBE_ALLOW_PRIV="--allow-privileged=false"
# How the replication controller and scheduler find the kube-apiserver
KUBE_MASTER="--master=http://$master:8080"
DONE

systemctl disable iptables-services firewalld
systemctl stop iptables-services firewalld

cat <<DONE > /etc/kubernetes/kubelet
# The address for the info server to serve on
KUBELET_ADDRESS="--address=0.0.0.0"
# The port for the info server to serve on
KUBELET_PORT="--port=10250"
# You may leave this blank to use the actual hostname
KUBELET_HOSTNAME="--hostname-override=$minion" # Check the node number!
# Location of the api-server
KUBELET_API_SERVER="--api-servers=http://$master:8080"
# Add your own!
KUBELET_ARGS=""
DONE

cat <<DONE > /etc/sysconfig/flanneld
# etcd url location.  Point this to the server where etcd runs
FLANNEL_ETCD="http://$master:2379"
# etcd config key.  This is the configuration key that flannel queries
# For address range assignment
FLANNEL_ETCD_KEY="/kube-centos/network"
# Any additional options that you want to pass
FLANNEL_OPTIONS=""
EOF
