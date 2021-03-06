#!/usr/bin/env bash
set -e

yum install -y wget > /dev/null
REPO_URL="http://yum.puppetlabs.com/el/6/products/x86_64/puppetlabs-release-6-6.noarch.rpm"

if [ "$EUID" -ne "0" ]; then
    echo "This script must be run as root." >&2
      exit 1
    fi

    if which puppet > /dev/null 2>&1; then
        echo "Puppet is already installed"
          exit 0
        fi

        # Install puppet labs repo
        echo "Configuring PuppetLabs repo..."
        repo_path=$(mktemp)
        wget --output-document=${repo_path} ${REPO_URL} 2>/dev/null
        rpm -i ${repo_path} >/dev/null

        # Install Puppet...
        echo "Installing puppet"
        yum install -y puppet-server vim > /dev/null
        sed -i 's/\[main\]/\[main\]\ndns_alt_names = puppet,master.puppetlabs.vm/g' /etc/puppet/puppet.conf
        echo "192.168.33.10 puppet master.puppetlabs.vm" >> /etc/hosts
        /etc/init.d/puppetmaster start
        echo "Puppet master installed!"
