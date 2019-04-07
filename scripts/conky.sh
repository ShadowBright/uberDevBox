#!/bin/bash

source ./init.sh

if [ ! -n "$archive_dir" ]; then
    echo "archive directory not set!"
    exit 1
fi

install_conky() {

    sudo apt-get -qq -y install conky-all

    if [[ -f conky.conf ]]; then
        cp conky.conf ~/.conkyrc
    else
        sudo sed -i 's/left/right/' /etc/conky/conky.conf
        cp /etc/conky/conky.conf ~/.conkyrc
    fi

    cp conky.desktop ~/.config/autostart/
    #get the network that is up
    network="$(ip -o link show | awk '{print [,$9}' | grep UP | cut -d':' -f1)"
    sed -i 's/eth0/${network}/g' ~/.conkrc
}

if [[ $0 == "$BASH_SOURCE" ]]; then
    #not souce so execute
    install_conky
fi
