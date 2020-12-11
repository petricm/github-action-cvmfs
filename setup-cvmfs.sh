#!/bin/bash

# Install cvmfs
wget -q https://ecsft.cern.ch/dist/cvmfs/cvmfs-release/cvmfs-release-latest_all.deb
sudo dpkg -i cvmfs-release-latest_all.deb
sudo apt-get -q update
sudo apt-get -q -y install cvmfs cvmfs-config-default
rm -f cvmfs-release-latest_all.deb

# Setup default.local
sudo mkdir -p /etc/cvmfs
echo "CVMFS_DNS_MIN_TTL='${CVMFS_DNS_MIN_TTL}'"   | sudo tee -a /etc/cvmfs/default.local
echo "CVMFS_QUOTA_LIMIT='${CVMFS_QUOTA_LIMIT}'"   | sudo tee -a /etc/cvmfs/default.local
echo "CVMFS_HTTP_PROXY='${CVMFS_HTTP_PROXY}'"     | sudo tee -a /etc/cvmfs/default.local
echo "CVMFS_CACHE_BASE='/var/lib/cvmfs'"          | sudo tee -a /etc/cvmfs/default.local
echo "CVMFS_REPOSITORIES='${CVMFS_REPOSITORIES}'" | sudo tee /etc/cvmfs/default.local
echo "CVMFS_USE_CDN='${CVMFS_USE_CDN}'"           | sudo tee -a /etc/cvmfs/default.local
sudo cvmfs_config setup
