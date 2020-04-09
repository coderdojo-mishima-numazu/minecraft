# マインクラフトサーバー構築方法(CoderDojoのさくらレンタルサーバー向け)

「さくらのクラウド」にマインクラフトサーバー(以下マイクラサーバー)構築方法を記述します。
マイクラサーバーを初めて建てる方は以下のライセンス条項を確認してください。
[MINECRAFT エンド ユーザー ライセンス条項](https://account.mojang.com/documents/minecraft_eula)

## サーバー構成

Dockerでマイクラサーバーを立てます。
Ubuntu(ホスト)サーバーの80番ポートが、マイクラサーバーに25565番ポートにマッピングされます。
設定ファイルは/var/mc_Official_data/にあります。

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

そうすると、minecraftというディレクトリができます。その中の、officailディレクトに移動します。

```sh
ubuntu@ubuntu:~$ cd minecraft/official
```

official_build.shというシェルスクリプトを実行してマイクラサーバーを構築、起動します。デフォルトでは公式の最新バージョンのマイクラサーバーが起動します。

```sh
ubuntu@ubuntu:~$ . official_build.sh
```

クライアントで接続確認します。接続できるのは製品版のみです。

![title](https://user-images.githubusercontent.com/62791055/78687916-9fd23a00-792f-11ea-94b4-4d588273dd95.png)

![multi](https://user-images.githubusercontent.com/62791055/78687940-a660b180-792f-11ea-8069-1ac6b1bd9dfb.png)

![server](https://user-images.githubusercontent.com/62791055/78688134-e6c02f80-792f-11ea-9638-8c7243f119d8.png)

サーバーアドレスに「サーバーのIPアドレス:80」を入力します。サーバー名は任意です。

## サーバーの再起動

```sh
ubuntu@ubuntu:~$ cd minecraft/official
ubuntu@ubuntu:~$ docker-compose restart
```

## サーバーの設定ファイル

設定ファイルは/var/mc_Official_data/にあります。
ここのファイルを修正するとサーバー側に同期されます。設定後サーバーの再起動が必要です。