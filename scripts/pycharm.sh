#!/bin/bash

source ./init.sh

if [ ! -n "$archive_dir" ]; then
    echo "archive directory not set!"
    exit 1
fi

install_pycharm() {


    sudo apt-get install -qq -y \
         libxrender1 \
         libxtst6 \
        --no-install-recommends

    fileName="ibus-1.5.11.tar.gz"

    if [ ! -f ${archive_dir}${fileName} ]; then
       wget -q -O ${archive_dir}${fileName} https://github.com/ibus/ibus/releases/download/1.5.11/ibus-1.5.11.tar.gz
    fi

    sudo mkdir -p /tmp/ibus
    sudo cp ${script_dir}${fileName} -C /tmp/ibus --stirp-components 1
    cd /tmp/ibus
    ./configure --prefix=/usr --sysconfdir=/etc && make
    sudo make install


    if [ ! -f ${archive_dir}pycharm.tar.gz ]; then

        wget -q -O ${archive_dir}pycharm.tar.gz  https://download.jetbrains.com/python/pycharm-community-2016.1.2.tar.gz

    fi

    mkdir /etc/pycharm
    tar -xzf ${archive_dir}pycharm.tar.gz -C /etc/pycharm --strip-components 1

    sudo cp ${scripts_dir}pycharm.desktop /usr/share/applications/
    sudo chmod +x /usr/share/applications/pycharm.desktop

    echo 'export PYCHARM_HOME=/etc/pycharm' | sudo tee -a  /etc/profile.d/pycharm.sh
    echo 'export PATH=$PATH:$PYCHARM_HOME/bin' | sudo tee -a  /etc/profile.d/pycharm.sh

    sudo ln -s /etc/pycharm/bin/pycharm.sh /usr/bin/pycharm
}


if [[ $0 == "$BASH_SOURCE" ]]; then
    #not souce so execute
    install_pycharm
fi
