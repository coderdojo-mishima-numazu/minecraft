#!/bin/bash

source ../setup/install_docker.sh
source ../setup/usedPort.sh

d_cmd=$(type -P docker)
d_com_cmd=$(type -P docker-compose)

if [ -z "$d_cmd" ]; then
    install_docker
else
    echo "dockerは既にインストールされています。"
fi

if [ -z "$d_com_cmd" ]; then
    install_docker_compose
else
    echo "docker-composeは既にインストールされています。"
fi

sudo apt -y autoremove

docker-compose rm -fs

isUsedPort 80
if [ $? -ne 0 ]; then
    echo "80番ポートが使用中のため、インストール中止しました。"
    exit 1
fi

# Minecraftコンテナを起動します。

cd $(cd $(dirname -- $0); pwd)
docker-compose up -d
