#!/bin/bash
PUPPET_MASTER= 
CERTNAME= 

SCRIPT=`basename ${BASH_SOURCE[0]}`
PUPPET_MASTER= 
CERTNAME= 
function USAGE {
  echo -e "\\n-------------------------------------------------------------"\\n
  echo -e "Usage:$SCRIPT -m master_hostname -c certname_to_register"\\n
  echo "Command line switches are must. The following switches are recognized."
  echo "-m  --puppet master fqdn/hostname "
  echo "-c  --name to register this node with puppet master as e.g. node1.example.org "
  echo -e "-h  --Displays this help message. No further functions are performed."\\n
  echo -e "Example: $SCRIPT -m puppet.example.org  -c node1.example.org "\\n
  echo -e "\\n-------------------------------------------------------------"\\n
  exit 1
}

NUMARGS=$#
if [ $NUMARGS -lt 2 ]; then
  USAGE
fi

while getopts mc: OPTION; do
  case $OPTION in
    m)
      PUPPET_MASTER=$OPTARG
      ;;
    c)  
      CERTNAME=$OPTARG
      ;;
    h) 
      USAGE
      ;;
  esac
done

echo "I: Setting up APT Repository for Puppet..."
wget https://apt.puppetlabs.com/puppetlabs-release-precise.deb
sudo dpkg -i puppetlabs-release-precise.deb
sudo apt-get update
echo "I: Installing Puppet..."
sudo apt-get install puppet -yq

echo"I: Generate puppet configurations..."
cat << EOF > /etc/puppet/puppet.conf
[agent]

    report        = true
    pluginsync    = true
    masterport    = 8140
    environment   = production
    server        = $PUPPET_MASTER
    certname      = $CERTNAME
    listen        = false
    splay         = false
    runinterval   = 1800
    noop          = false
    configtimeout = 120
EOF

echo "I: Enable Puppet as a Service..."
sudo sed -i 's/no/yes/g' /etc/default/puppet

echo "I: Starting Puppet Agent after enabling...."
/etc/init.d/puppet start

echo "I: Launching first run of Puppet Agent...."
sudo puppet agent -t --waitforcert 10


