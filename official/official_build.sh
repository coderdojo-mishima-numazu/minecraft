#!/bin/bash

source ../setup/install_docker.sh
source ../setup/usedPort.sh

d_cmd=$(type -P docker)
d_com_cmd=$(type -P docker-compose)

if [ -n "$d_cmd" ]; then
    install_docker
else
    echo "dockerは既にインストールされています。"
fi

if [ -n "$d_com_cmd" ]; then
    install_docker_compose
else
    echo "docker-composeは既にインストールされています。"
fi

docker-compose stop
docker-compose rm -fs

isUsedPort 80
if [ $? -ne 0 ]; then
    echo "80番ポートが使用中のため、インストール中止しました。"
fi

# Mincraftのデータとホストを同期するディレクトリを作ります。

sudo mkdir -p /var/mc_official_data/

# Minecraftコンテナを起動します。

cd $(cd $(dirname -- $0); pwd)
docker-compose up -d
