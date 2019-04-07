#!/bin/bash

source ./init.sh

if [ ! -n "$archive_dir" ]; then
    echo "archive directory not set!"
    exit 1
fi

install_avast() {

    sudo apt-get -yq remove avast bitdefender-scanner bitdefender-scanner-gui

    if [ -f /etc/apt/sources.list.d/avast.list ]; then
        sudo rm /etc/apt/sources.list.d/avast.list
    fi

    if [ ! -f /etc/apt/sources.list.d/avast.list ]; then

        sudo touch /etc/apt/sources.list.d/avast.list
        echo "deb http://deb.avast.com/lin/repo debian release" | sudo tee -a  /etc/apt/sources.list.d/avast.list

    fi

    if [ ! -f ${archive_dir}avast.gpg ]; then
        sudo wget -q http://files.avast.com/files/resellers/linux/avast.gpg -O ${archive_dir}avast.gpg
    fi

    sudo apt-key add ${archive_dir}avast.gpg

    sudo apt-get update -qq

    sudo apt-get -yq install avast
    # apt-get install avast-fss
    # apt-get install avast-proxy

    if [ ! -d /etc/avast ]; then
        sudo mkdir -p /etc/avast
    fi

    if [ ! -f /etc/avast/license.avastlic ]; then

        if [ -f ${archive_dir}license.avastlic ]; then
           sudo cp ${archive_dir}license.avastlic /etc/avast
        fi
    fi

    sudo service avast start
}

if [[ $0 == "$BASH_SOURCE" ]]; then
    #not souce so execute
    install_avast
fi
