#!/bin/bash

source ./init.sh

if [ ! -n "$archive_dir" ]; then
    echo "archive directory not set!"
    exit 1
fi

install_bd() {


    sudo apt-get -yq remove avast bitdefender-scanner bitdefender-scanner-gui

    sudo apt-get install -yq libc6-i386 \
    #sudo set -x
    echo "Install Bitdefender..."
    cd /tmp \

    sudo wget -q http://download.bitdefender.com/repos/deb/bd.key.asc
    sudo apt-key add bd.key.asc

    if [ ! -f /etc/apt/sources.list.d/bitdefender.list ]; then
        sudo touch /etc/apt/sources.list.d/bitdefender.list

        echo "deb http://download.bitdefender.com/repos/deb/ bitdefender non-free" | sudo tee -a  /etc/apt/sources.list.d/bitdefender.list

        sudo apt-get update -qq

    fi
    #DEBIAN_FRONTEND=noninteractive
    sudo apt-get install -yq bitdefender-scanner bitdefender-scanner-gui

    echo "LicenseAccepted = True" | sudo tee -a  /opt/BitDefender-scanner/etc/bdscan.conf

    sudo sh ${archive_dir}bd_fix.sh

    # Update Bitdefender definitions
    sudo bdscan --update > bd_output.txt

    #sudo set +x
}


if [[ $0 == "$BASH_SOURCE" ]]; then
    #not souce so execute
    install_bd
fi
