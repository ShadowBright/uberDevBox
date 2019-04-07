#!/bin/bash

source ./init.sh

if [ ! -n "$archive_dir" ]; then
    echo "archive directory not set!"
    exit 1
fi

install_dropbox() {

    fileName="dropbox-linux-x86_64.tar.gz"

    if [ ! -f ${archive_dir}${fileName} ]; then
        echo "downloading dropbox binary..."
        sudo wget -q -O ${archive_dir}${fileName} https://www.dropbox.com/download?plat=lnx.x86_64
    fi

    if [ -d /opt/dropbox ]; then
        sudo rm -r /opt/dropbox
    fi

    sudo mkdir -p /opt/dropbox

    sudo tar -xzf ${archive_dir}${fileName} --strip 1 -C /opt/dropbox

    #run after install to link account
    #/opt/dropbox/dropboxd

    sudo curl -sLo /etc/init.d/dropbox https://gist.githubusercontent.com/thisismitch/d0133d91452585ae2adc/raw/699e7909bdae922201b8069fde3011bbf2062048/dropbox

    sudo chmod +x /etc/init.d/dropbox
    sudo update-rc.d dropbox defaults

    cd /opt
    sudo curl -sLO https://www.dropbox.com/download?dl=packages/dropbox.py
    sudo chmod +x /opt/dropbox.py

    if [ -f /usr/bin/dropbox ]; then
        sudo rm /usr/bin/dropbox
    fi

    sudo ln -s /opt/dropbox.py /usr/bin/dropbox

    if [ -f ~/.dropbox-dist ]; then
        sudo rm ~/.dropbox-dist
    fi

    sudo ln -s /opt/dropbox ~/.dropbox-dist
    ~/.dropbox-dist/dropboxd &

}

if [[ $0 == "$BASH_SOURCE" ]]; then
    #not souce so execute
    install_dropbox
fi
