#!/bin/bash

source ../setup/install_docker.sh

install_docker

# Mincraftのデータとホストを同期するディレクトリを作ります。

sudo mkdir /var/mc_official_data/

# Minecraftコンテナを起動します。

cd $(cd $(dirname -- $0); pwd)
docker-compose up -d
