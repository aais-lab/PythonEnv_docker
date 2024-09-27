# PythonEnv_docker
## Overview
千葉工業大学 先進工学部 知能メディア工学科の第2セメスター及び第4セメスター講義を担当するTAのうち、ローカルに指定のpython環境を構築できないTA(教育補助員)用のDocker環境構築スクリプト群です。
環境構築の手間を削減する、また、統一的な環境を簡便に使用できるようにすることを目的として作成されました。

## Requirement
### 必要環境
- MacOS
    - Windowsでの挙動は確認していません
    - Intelチップでは音声が再生されない場合がありますが、M1では動作確認済みです

### setupによってローカルに導入される環境
- Homebrew
    - Mac用のパッケージ管理ソフトウェア
    - 実行時点のlastest
- DockerDesktop
    - コンテナ仮想化アプリケーション
    - 実行時点のlastest
- XQuartz
    - Mac用 X Window System
    - 実行時点のlastest
- PulseAudio
    - サウンドサーバ
    - 実行時点のlastest

### コンテナ上の環境
- Python 3.11.9-slim
- git
- python3-tk
- mpv
- pulseaudio
- fonts-noto-cjk

## Usage
### ローカル環境の構築
#### gitからクローン
```
git clone https://github.com/aais-lab/PythonEnv_docker.git
```

#### setup.commandへの権限付与
```
xattr -d com.apple.quarantine ./PythonEnv_docker/setup.command
```

#### setup.commandをダブルクリックで実行
ターミナルが立ち上がり、ローカル環境に導入する必要のあるHomebrew、Docker、XQuartz、PulseAudioがインストールされていない場合インストールされます。
途中でPCのパスワード等を入力する必要があるため、ターミナルの指示に従ってください。

#### DockerDesktop、XQuartzの設定を行う
setup.commandを実行終了後、[プロセスが終了しました]という表記がターミナルに出た後の処理です。
##### DockerDesktopの設定
ログインを行なってください。
アカウントを作成していない場合はGoogleアカウント等でログイン可能です。
##### XQuartzの設定
1. アプリケーションの選択
Dockに起動したアプリケーションがあると思うのでクリックしてください。
ない場合は以下のコマンドを実行してください。
```
open /Applications/Utilities/XQuartz.app
```

2. 設定の変更
設定 > セキュリティ > ネットワーク・クライアントからの接続を許可へチェックを入れてください。
<img width="400" alt="setting place" src="https://github.com/user-attachments/assets/7421bf8a-35fe-4558-9289-d21f33c2233f">
<img width="600" alt="setting" src="https://github.com/user-attachments/assets/554da3d6-08d8-4cb4-bd7b-015ffc4c88a5">

4. XQuartzアプリケーションを再起動
メニューからアプリケーションを終了させて、起動コマンドを実行してください。
<img width="400" alt="setting place" src="https://github.com/user-attachments/assets/213d128f-85b5-4883-a3b3-feee125532ec">

```
open /Applications/Utilities/XQuartz.app
```

#### ログアウト
一度現在のアカウントからログアウトしてください。
環境の変数の設定が行われます。

#### 再度setup.commandをダブルクリックして実行
DockerDesktopが実行されていることを確認してください。
再度実行すると、dockerイメージが作成されます。
出力が停止し、
```
[python-IP]〜
```

と最後の行に表示されたのち、control + Cを押下してください。
Dockerコンテナが落ちます。

### DockerへのアクセスとPythonの実行
#### python_run.shを実行
ターミナルでpython_run.shがある場所まで移動し、以下のコマンドを実行してください。
```
./python_run.sh
```

dockerコンテナが動いていない場合、コンテナを起動させてコンテナへログインします。
dockerコンテナが動いている場合、コンテナをstopさせます。

#### pythonの実行
```
root@[数字とアルファベット列]:~/src# 
```

上記がターミナルに表示された状態の場合、dockerコンテナへログインされています。
ホストPC（Mac）内の/Document/IPに、docker内の/root/srcが接続されています。
/Document/IP内に存在するファイルの実行は一般的なpythonの実行コマンドで可能です。
```
python [path/to/file].py
```

#### 環境の終了
docker環境からexitでログアウトし、再度python_run.shを実行してください。

### Uninstall all
uninstall.shを実行してください。
ローカルに導入されたbrewを含めた環境がアンインストールされます。

## Author
[Nao Yamanouchi](https://github.com/ClairdelunaEve)

## License
3-Clause BSD
