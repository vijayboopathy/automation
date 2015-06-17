#!/bin/bash
wget https://apt.puppetlabs.com/puppetlabs-release-precise.deb
sudo dpkg -i puppetlabs-release-precise.deb
sudo apt-get update
sudo apt-get install puppet -yq
sudo sed -i 's/no/yes/g' /etc/default/puppet
cat << EOF >> /etc/puppet/puppet.conf
[agent]

    report        = true
    pluginsync    = true
    masterport    = 8140
    environment   = production
    server        = $PUPPET_MASTER
    listen        = false
    splay         = false
    runinterval   = 1800
    noop          = false
    configtimeout = 120
EOF

/etc/init.d/puppet restart
sudo puppet agent -t

