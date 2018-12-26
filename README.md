# 構築メモ

## ansibleコンテナ用のDockerfileについて
|環境|バージョン|備考|
|---|---|---|
|Centos|7.4.1708| - |
|python|2.7.5|defaultでインストール済み|
|ansible|2.6.3|pip install|
|openssh-client|latest| - |


### ansible設定
- /etc/ansible/hostsでserversのホスト名を指定。
- .ansible.cfgで「host key checkingの無効化」と「秘密鍵指定」を設定。

## ssh設定（共通）
- ホスト側の./.sshに秘密鍵、公開鍵、configを準備。
- ホスト側の./.sshをコンテナの~/.sshに追加。
- 秘密鍵（ansible_rsa）のパーミッションは600。
- .sshフォルダのパーミッションは700。

## serversのコンテナ用のDockerfileについて
[SSH デーモン用サービスの Docker 化](http://docs.docker.jp/engine/examples/running_ssh_service.html)
を参考にansibleコンテナからssh接続できるように設定。

## docker-compose.ymlの設定
### ansible コンテナ
- ./Dockerfileに配置したDokerfileをbuildしてimageを作成・起動。
- `privileged: true`でコンテナ間のアクセスを可能にする。

### serversのコンテナ  
- serversに配置したDokerfileをbuildしてimageを作成・起動。
- `privileged: true`でコンテナ間のアクセスを可能にする。
- `expose - 22`で22ポートを解放してssh接続可能にする。

## コンテナ起動
```
$ docker-compose up -d
```

## 動作確認
ansible-studyコンテナで動作確認します。
```
$ docker container exec -it ansible-study /bin/bash
```
以下コマンドを入力し、「SUCCESS」で"ping": 「"pong"」が表示されれば、OKです。
```
[root@ansible-study /]# ansible ubuntu16 -m ping
ubuntu16.04-node | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
[root@ansible-study /]# ansible centos7 -m ping
centos7.4-node | SUCCESS => {
    "changed": false,
    "ping": "pong"
```

## playbooks
後は、このディレクトリにファイルを入れて、ansibleの勉強しましょう。

## 参考
- [Ansible  Docs](https://docs.ansible.com/ansible/2.6/installation_guide/intro_installation.html)
