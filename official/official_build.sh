#!/bin/bash

source ../setup/install_docker.sh
source ../setup/usedPort.sh

MC_ROOT=/var/mc_official_data

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

yes | sudo apt autoremove

docker-compose rm -fs

isUsedPort 80
if [ $? -ne 0 ]; then
    echo "80番ポートが使用中のため、インストール中止しました。"
    exit 1
fi

sudo mkdir -p $MC_ROOT

script_dir=$(cd $(dirname -- $0); pwd)

python ${script_dir}/../setup/operator.py $MC_ROOT .

if [ $? -ne 0 ]; then
    echo "Minecraftサーバーの起動を中止しました。"
    exit 1
fi

# Minecraftコンテナを起動します。

cd $script_dir
docker-compose up -d
