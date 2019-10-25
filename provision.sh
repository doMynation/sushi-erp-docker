#!/bin/bash

# How to run this script
# sh ./provision.sh GITHUB_TOKEN

# Create swap
echo "Creating swap..."
dd if=/dev/zero of=/swapfile bs=100M count=20
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo "/swapfile swap swap defaults 0 0" >> /etc/fstab
echo "Swap created."

# Install docker
apt-get update
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io

curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Install utilities
apt-get install -y \
    vim \
    unzip \
    composer \
    certbot \
    awscli

cd "$(dirname "$0")"
cp ./.env.sample ./.env

mkdir ./data

echo "Installing Sushi ERP..."
mkdir ./data/sushi
git clone https://$1@github.com/domynation/sushi-erp ./data/sushi
#chmod -R 0777 ./data/sushi/assets/uploads
composer install -d ./data/sushi --ignore-platform-reqs
echo "Done."

echo "Installing Inventory API..."
mkdir ./data/inventory-api
git clone https://$1@github.com/domynation/inventory-api ./data/inventory-api
chmod -R 0777 ./data/inventory-api/storage/logs
composer install -d ./data/inventory-api --ignore-platform-reqs
echo "Done."

# Build the PHP image
docker build ./php -t php7.3

# Build the stack
docker-compose build

# Set time zone to ET
timedatectl set-timezone America/New_York
