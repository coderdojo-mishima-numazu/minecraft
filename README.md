# マインクラフトサーバー構築方法 (CoderDojoの[DojoPaaS](https://github.com/coderdojo-japan/dojopaas)利用者向け)

CoderDojo Japan が提供する [DojoPaaS](https://github.com/coderdojo-japan/dojopaas) を使って、<br>
マインクラフトサーバー (以下マイクラサーバー) をカンタンに構築するスクリプトです。

マイクラサーバーを初めて構築する方は、以下のライセンス条項を確認してください。<br>
[MINECRAFT エンド ユーザー ライセンス条項](https://account.mojang.com/documents/minecraft_eula)

> *私はサーバーはもちろん、マイクラ自体も初心者のため、不備があればご指摘ください。*

## 本スクリプト使ったマイクラサーバー構築の流れ

**よくわからなければ読み飛ばして結構です。スクリプトを実行するだけ

本スクリプトでは次の流れでマイクラサーバーを立てます。

1. Docker でマイクラサーバーを立てます
   - 使用する Docker イメージは [itzg/minecraft-server](https://hub.docker.com/r/itzg/minecraft-server/) です。
   - ドキュメントを読むとパラメータを変えるだけで色々なタイプのマイクラサーバーが起動できるようです。感謝。
1. Ubuntu (ホスト) 8の0番ポートを、マイクラサーバー用の25565番ポートにマッピングします
   - 詳細は [official](https://github.com/coderdojo-mishima-numazu/minecraft/tree/master/official) ディレクトリと [setup](https://github.com/coderdojo-mishima-numazu/minecraft/tree/master/setup) ディレクトリでご確認できます。
1. マイクラサーバーの設定ファイルは `/var/mc_official_data/` にあります (Docker ボリュームとしてマウントされています)
   - 設定ファイルについてはあとで説明します。

今のところ公式版のみです。今後、色々な派生サーバーを試せたらなと思います。<br>

## 構築手順

CoderDojo 向けに提供されている DojoPaaS を使って、まずはサーバーを作っておきます。<br>
DojoPaaS の使い方は [coderdojo-japan/dojopaas](https://github.com/coderdojo-japan/dojopaas) をご参照ください。

サーバーが無事作れたら、SSH でサーバーにログインします。

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

以下のコマンドを実行します。実行する場所は任意ですが、よくわからなければログインした場所 (`home`ディレクトリ) 大丈夫です。

```sh
ubuntu@ubuntu:~$ git clone https://github.com/coderdojo-mishima-numazu/minecraft.git

```

そうすると `minecraft` というディレクトリができます。その中の `officail` ディレクトリに移動します。

```sh
ubuntu@ubuntu:~$ cd minecraft/official
```

`official_build.sh` というシェルスクリプトを実行します。するとマイクラサーバーのインストールと起動が行われます。<br>
デフォルトでは公式の最新バージョンです。数分待って、最後に **『Creating minecraft ... done』** と表示されれば成功です。

```sh
ubuntu@ubuntu:~$ . official_build.sh
Get:1 http://security.ubuntu.com/ubuntu xenial-security InRelease [109 kB]
Hit:2 http://jp.archive.ubuntu.com/ubuntu xenial InRelease

...

Digest: sha256:ce18748c8657dc9ae25e334e27182ad64706ebc73aa0c092e95fb6112c4d3386
Status: Downloaded newer image for itzg/minecraft-server:latest
Creating minecraft ... done
```

最後に Minecraft アプリ (クライアント) を立ち上げ、接続確認します。接続できるのは製品版のみです。

![title](https://user-images.githubusercontent.com/62791055/78687916-9fd23a00-792f-11ea-94b4-4d588273dd95.png)

![multi](https://user-images.githubusercontent.com/62791055/78687940-a660b180-792f-11ea-8069-1ac6b1bd9dfb.png)

![server](https://user-images.githubusercontent.com/62791055/78688134-e6c02f80-792f-11ea-9638-8c7243f119d8.png)

サーバーアドレスに『`サーバーのIPアドレス:80`』を入力します。サーバー名は任意です。

以上でマイクラサーバーの立ち上げは終了です。お疲れ様でした!

## マイクラサーバーの

マイクラサーバーの設定ファイルや、起動・停止コマンドなどについてまとめてます。<br>


### マイクラサーバーの設定ファイル

設定ファイルは `/var/mc_official_data/`にあります。<br>
ここのファイルを修正し、マイクラサーバーを再起動すると反映されます。<br>
バックアップしたい場合は `scp` コマンドなどでダウンロードしてください。

### マイクラサーバーの再起動

```sh
ubuntu@ubuntu:~$ cd ~/minecraft/official;docker-compose restart
```

### マイクラサーバーの停止

```sh
ubuntu@ubuntu:~$ cd ~/minecraft/official;docker-compose stop
```

### マイクラサーバーの全削除

マイクラサーバーを全部消したい時

```sh
ubuntu@ubuntu:~$ cd ~/minecraft/official;docker-compose down --rmi all
```

### 他、やった方がいいかなと思う設定

- ホワイトリストの有効化
