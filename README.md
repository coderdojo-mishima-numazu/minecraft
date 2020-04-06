# マインクラフトサーバー構築方法(CoderDojoのさくらレンタルサーバー向け)

「さくらのクラウド」にマインクラフトサーバー(以下マイクラサーバー)を構築方法を記述します。
マイクラサーバーを初めて建てる方は以下のライセンス条項を確認してください。
[MINECRAFT エンド ユーザー ライセンス条項](https://account.mojang.com/documents/minecraft_eula)

## サーバー構成

UbuntuにDocker

## 構築手順

SSHでログインします。

```sh
Welcome to Ubuntu 16.04.6 LTS (GNU/Linux 4.4.0-142-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage
New release '18.04.4 LTS' available.
Run 'do-release-upgrade' to upgrade to it.

Last login: Sat Apr  4 07:50:39 2020 from 123.1.58.13
ubuntu@ubuntu:~$
```

以下のコマンドを実行します。

```sh
ubuntu@ubuntu:~$ git clone https://github.com/coderdojo-mishima-numazu/minecraft.git

```

そうすると、minecraftというディレクトリができるので、移動します。

```sh
ubuntu@ubuntu:~$ cd minecraft
```

setupMinecraftServer.shというシェルスクリプトを実行してマイクラサーバーを構築、起動します。デフォルトでは最新バージョンのマイクラサーバーが起動します。

```sh
ubuntu@ubuntu:~$ . setupMinecraftServer.sh
```

クライアントで接続確認します。接続できるのは製品版のみです。

サーバーのIPアドレス


## 運用について

- 1日に1回再起動します。
- データのバックアップを行います。