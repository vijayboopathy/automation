#!/bin/bash
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF > /etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update -y
apt-get install -y docker.io kubelet kubeadm kubectl kubernetes-cni
touch /master.sh
cat <<EOF > /master.sh
#!/bin/bash
touch adm
touch minion.sh
echo '#!/bin/bash' >> minion.sh
kubeadm init >> adm
tail adm -n 1 >> minion.sh
echo "Master configuration is done!"
sleep 3
clear
echo "Run the following command on all the node which you need to configure it as an minion"
cat minion.sh
sleep 5
EOF
