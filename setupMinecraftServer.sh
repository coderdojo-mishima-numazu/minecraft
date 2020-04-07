#!/bin/bash

# Dockerをインストールします。

yes | sudo apt update
yes | sudo DEBIAN_FRONTEND=noninteractive apt upgrade

yes | sudo apt install vim \
apt-transport-https \
ca-certificates \
curl \
software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

yes | sudo apt update
yes | sudo apt install -y docker-ce

sudo gpasswd -a $USER docker

sudo chmod 766 /var/run/docker.sock

# Docker-Composeをインストールします。
COMPOSE_VERSION='1.25.4'
sudo curl -L "https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo chmod 755 /usr/local/bin/docker-compose

# Mincraftのデータをホストに保存します。

sudo mkdir /var/mc_official_data/

# FWで25565番ポートを許可します。

sudo iptables -A INPUT -p tcp --dport 25565 -j ACCEPT
sudo /etc/init.d/netfilter-persistent save

# Minecraftコンテナを起動します。

cd $(cd $(dirname $0); pwd)
docker-compose up -d

