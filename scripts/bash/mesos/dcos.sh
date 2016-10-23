#!/bin/bash
mkdir -p /script
cd /script
echo "give the name for the Installation the Prerequisites. Note that there must not be any file of that name."
read name
touch $name.sh
chmod 777 $name.sh
tee $name.sh <<-'DONE'
#!/bin/bash
echo "updating centos"
sleep 1
yum upgrade -y
echo "updated"
echo "turning off the firewall"
sleep 2
systemctl stop firewalld && sudo systemctl disable firewalld
echo "turned off firewall"
echo "adding the repo for docker"
sleep 2
tee /etc/yum.repos.d/docker.repo <<-'EOF'
[dockerrepo]
name=Docker Repository
baseurl=https://yum.dockerproject.org/repo/main/centos/$releasever/
enabled=1
gpgcheck=1
gpgkey=https://yum.dockerproject.org/gpg
EOF
echo
echo
echo
echo "added the repo"
echo "editing visudo"
sleep 2
echo  "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
echo "visudo is done"
echo "installing the depended package"
sleep 2
yum install -y tar xz unzip curl ipset ntp docker-engine-1.11.1
echo
echo "Great!! We configured the Prerequisites"
DONE
echo
echo
echo

echo "Enter the Number of master"
read masternumb
for ((i=1; i<=$masternumb; i++))
do
echo "Please give the $i master ip:"
read masterip
ssh root@$masterip /script/$name.sh
echo "Prerequisites isntalled  $i master."
done

echo
echo
echo

echo "Enter the Number of agents"
read agentnumb
for ((i=1; i<=$agentnumb; i++))
do
echo "Please give the $i agent ip:"
read agentip
ssh root@$agentip /script/$name.sh
echo "Prerequisites isntalled  $i master."
done
echo
echo
echo
echo "ALL the prereq are installed. now we can install the DCOS"
mkdir -p /dcos
mkdir -p /dcos/genconf
cd /dcos
touch genconf/ip-detect
tee genconf/ip-detect <<-'EOF'
#!/bin/sh
# Example ip-detect script using an external authority
# Uses the AWS Metadata Service to get the node's internal
# ipv4 address
curl -fsSL http://169.254.169.254/latest/meta-data/local-ipv4
EOF

tee genconf/config.yaml <<-'EOF'
---
agent_list:
- <agent-private-ip-1>
- <agent-private-ip-2>
# Use this bootstrap_url value unless you have moved the DC/OS installer assets.
bootstrap_url: file:///opt/dcos_install_tmp
cluster_name: <cluster-name>
exhibitor_storage_backend: <storage-backend>
master_discovery: static
master_list:
- <master-private-ip-1>
resolvers:
- 8.8.4.4
- 8.8.8.8
ssh_port: 22
ssh_user: root
EOF
echo
echo
echo
echo
echo "Please give the master ip:"
read masterip
sed -i 's/<master-private-ip-1>/'$masterip'/g' /dcos/genconf/config.yaml
echo "Master has been added to config file"
sleep 2
echo
echo
echo
echo
echo "Please give the 1st agent ip:"
read agentip
sed -i 's/<agent-private-ip-1>/'$agentip'/g' /dcos/genconf/config.yaml
echo
echo
echo
echo "Please give the 2nd agent ip:"
read agentip2
sed -i 's/<agent-private-ip-2>/'$agentip2'/g' /dcos/genconf/config.yaml
echo
echo
echo
echo "Agnets has been added to config file"
cp ~/.ssh/authorized_keys /dcos/genconf/
mv /dcos/genconf/authorized_keys /dcos/genconf/ssh_key
chmod 0600 genconf/ssh_key
clear
echo "downloading DCOS please wait"
echo
echo
echo
curl -O https://downloads.dcos.io/dcos/stable/dcos_generate_config.sh
echo
echo
echo
echo "Downloaded the DCOS."
echo
echo "First setup in Installation."
bash dcos_generate_config.sh --genconf
echo
echo "Second step in Installation - install-prereqs"
bash dcos_generate_config.sh --install-prereqs
clear
echo "Third step in Installation - preflight"
bash dcos_generate_config.sh --preflight
clear
echo "Third step in Installation - Deploy"
bash dcos_generate_config.sh --deploy
clear
echo "Fourth step in Installation - postflight"
bash dcos_generate_config.sh --postflight
clear
echo "Congrats We installed DCOS in the nodes."
echo
echo "To see the zookeeper"
echo "http://<master-public-ip>:8181/exhibitor/v1/ui/index.html"
echo
echo "To see the DCOS homepage"
echo "http://<public-master-ip>/"
echo
echo
echo "Have fun with DCOS!!! Cya"
