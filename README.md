# マインクラフトサーバー構築方法(CoderDojoのさくらレンタルサーバー向け)

「さくらのクラウド」にマインクラフトサーバー(以下マイクラサーバー)構築方法を記述します。<br>
マイクラサーバーを初めて建てる方は以下のライセンス条項を確認してください。<br>
[MINECRAFT エンド ユーザー ライセンス条項](https://account.mojang.com/documents/minecraft_eula)

> 私はサーバーはもちろん、マイクラ自体も初心者のため、不備があればご指摘ください。

## マイクラサーバーについて

**よくわからなければ読み飛ばして結構です。

Dockerでマイクラサーバーを立てます。<br>
Ubuntu(ホスト)の80番ポートが、マイクラサーバーに25565番ポートにマッピングされます。<br>
設定ファイルは/var/mc_official_data/にあり、Dockerのボリュームに設定されています。

今の所公式版のみです。今後、色々な派生サーバーを試せたらなと思います。<br>

### 使用したDockerイメージ

itzg/minecraft-server(https://hub.docker.com/r/itzg/minecraft-server/)

ドキュメントを読むとパラメータを変えるだけで色々なタイプのマイクラサーバーが起動できるようです。感謝。

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

以下のコマンドを実行します。実行する場所は任意ですが、よくわからなければログインした場所(homeディレクトリ)で行って構いません。

```sh
ubuntu@ubuntu:~$ git clone https://github.com/coderdojo-mishima-numazu/minecraft.git

```

そうすると、minecraftというディレクトリができます。その中の、officailディレクトに移動します。

```sh
ubuntu@ubuntu:~$ cd minecraft/official
```

official_build.shというシェルスクリプトを実行してマイクラサーバーをインストール、起動します。デフォルトでは公式の最新バージョンです。<br>
数分待つと最後に、「Creating minecraft ... done」と表示されれば成功です。

```sh
ubuntu@ubuntu:~$ . official_build.sh
Get:1 http://security.ubuntu.com/ubuntu xenial-security InRelease [109 kB]
Hit:2 http://jp.archive.ubuntu.com/ubuntu xenial InRelease

...

Digest: sha256:ce18748c8657dc9ae25e334e27182ad64706ebc73aa0c092e95fb6112c4d3386
Status: Downloaded newer image for itzg/minecraft-server:latest
Creating minecraft ... done
```

クライアントで接続確認します。接続できるのは製品版のみです。

![title](https://user-images.githubusercontent.com/62791055/78687916-9fd23a00-792f-11ea-94b4-4d588273dd95.png)

![multi](https://user-images.githubusercontent.com/62791055/78687940-a660b180-792f-11ea-8069-1ac6b1bd9dfb.png)

![server](https://user-images.githubusercontent.com/62791055/78688134-e6c02f80-792f-11ea-9638-8c7243f119d8.png)

サーバーアドレスに「サーバーのIPアドレス:80」を入力します。サーバー名は任意です。

## マイクラサーバーの設定ファイル

設定ファイルは/var/mc_official_data/にあります。<br>
ここのファイルを修正し、マイクラサーバーを再起動すると反映されます。<br>
バックアップしたい場合は、SCPなどでダウンロードしてください。

## マイクラサーバーの再起動

```sh
ubuntu@ubuntu:~$ cd ~/minecraft/official;docker-compose restart
```

## マイクラサーバーの停止

```sh
ubuntu@ubuntu:~$ cd ~/minecraft/official;docker-compose stop
```

## マイクラサーバーの全削除

マイクラサーバーを全部消したい時

```sh
ubuntu@ubuntu:~$ cd ~/minecraft/official;docker-compose down --rmi all
```

## やった方がいいかなと思う設定

 - ホワイトリストの有効化
