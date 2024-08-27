#!/bin/bash

function check_installed(){
    # 指定したコマンドがインストールされているかを確認
    # インストール済み：10, 未インストール：20
    command="$1 --$2 &> /dev/null"
    eval $command
    if [ $? -ne 0 ] ; then
        echo $1
        return 20
    else
        return 10
    fi
}
function check_fileExists(){
    # 指定したファイルが存在するかを確認
    # 存在：10, 存在しない：20
    if [ -e $1 ]; then
        return 10
    else
        return 20
    fi
}

cp /dev/null ./config.conf

# 状況チェック
echo "checking installed applications..."

check_installed brew version
if [ $? -eq 10 ]; then
    echo "HOMEBREW=already" >> ./config.conf
else
    echo "HOMEBREW=not" >> ./config.conf
fi
check_installed docker version
if [ $? -eq 10 ]; then
    echo "DOCKER=already" >> ./config.conf
else
    echo "DOCKER=not" >> ./config.conf
fi
check_installed pulseaudio version
if [ $? -eq 10 ]; then
    echo "AUDIO=already" >> ./config.conf
else
    echo "AUDIO=not" >> ./config.conf
fi
check_fileExists /Applications/Utilities/XQuartz.app
if [ $? -eq 10 ]; then
    echo "X11=already" >> ./config.conf
else
    echo "X11=not" >> ./config.conf
fi

# 状況の読み出し
source ./config.conf

# ~/.zprofile が存在しない場合に作成
check_fileExists ~/.zprofile
if [ $? -eq 20 ]; then
    touch ~/.zprofile
fi

# Homebrewのインストールと設定
if [ $HOMEBREW = "not" ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    echo 'export PATH="$PATH:/opt/homebrew/bin"' >> ~/.zprofile
    source ~/.zprofile
    check_installed brew version
    if [ $? -eq 10 ]; then
        echo "Homebrew install Complete!"
    else
        echo "Not Completed Homebrew install process"
    fi
else
    echo "Homebrew already installed!"
fi

# Dockerのインストールと設定
if [ $DOCKER = "not" ]; then
    brew uninstall --cask docker --force
    brew install --cask docker
    check_installed docker version
    if [ $? -eq 10 ]; then
        echo "Docker install Complete!"
        open /Applications/Docker.app
    else
        echo "Not Completed Docker install process"
    fi
else
    echo "Docker already installed!"
fi

# pulseaudioのインストールと設定
if [ $AUDIO = "not" ]; then
    brew install pulseaudio
    pulseaudio --load=module-native-protocol-tcp --exit-idle-time=-1 --daemon
    brew services restart pulseaudio
    check_installed pulseaudio version
    if [ $? -eq 10 ]; then
        echo "pulseaudio install Complete!"
    else
        echo "Not Completed pulseaudio install process"
    fi
else
    echo "pulseaudio already installed!"
fi

# xquartzのインストール
if [ $X11 = "not" ]; then
    brew install xquartz
    echo 'export "PATH=$PATH/usr/X11/bin"' >> ~/.zprofile
    source ~/.zprofile
    open /Applications/Utilities/XQuartz.app
    echo "メニューバーの設定 > セキュリティ > 「ネットワーク・クライアントからの接続を許可」にチェック"
    echo "設定反映のため、現在のユーザからログアウトし、再ログインしてください"
else
    echo "Xquartz already installed!"
    # DISPLAY変数の設定確認
    echo $DISPLAY
    if [ $? != "" ]; then
        xhost -
        xhost + localhost
        open /Applications/Docker.app
        wait $!
        sleep 10
        if [ -d "~/Documents/IP" ]; then
            echo "作業用フォルダを生成します"
            mkdir ~/Documents/IP
        fi
        cd "$(dirname "$0")"
        docker compose up --menu=false
        docker stop python-IP
    fi
fi
