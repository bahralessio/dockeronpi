#!/bin/bash

echo "This script will install docker from its official apt repository."
echo "Script source: https://docs.docker.com/engine/install/debian/"

# check if the user has sudo priviledges
if [[ "$(id -u)" -ne 0 ]]; then
    echo "Permissions denied. This script must be run with sudo!" >&2
    exit 1
fi

# Preparing the APT docker repository
# Add Docker's official GPG key:
    echo "Adding the official Docker APT repository..."
    echo "Updating repositories..."
    apt-get update > /dev/null
    echo "Installing necessary packages: ca-certificates, curl"
    apt-get install ca-certificates curl -y > /dev/null
    install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
    chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
echo "Re-updating repositories..."
apt-get update > /dev/null

# Install the latest version of Docker
echo "Installing necessary packagess..."
apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y > /dev/null
echo "Installation completed without issues!"
