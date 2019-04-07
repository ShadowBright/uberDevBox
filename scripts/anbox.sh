#!/bin/bash

source ./init.sh

if [ ! -n "$archive_dir" ]; then
    echo "archive directory not set!"
    exit 1
fi

install_anbox() {
    sudo snap install --edge --devmode anbox

    #NOTE: doesnt work on 18.04 *yet*
    #sudo add-apt-repository ppa:morphis/anbox-support
    #sudo apt-get update

    sudo rm -f /etc/apt/sources.list.d/anbox-support.list

    #NOTE: bonic is not available yet
    #codename="$(lsb_release -c | sed 's/.*Codename:\W\(.*\)/\1/')"
    codename="artful"

    sudo sh -c "echo 'deb http://ppa.launchpad.net/morphis/anbox-support/ubuntu ${codename} main' >> /etc/apt/sources.list.d/anbox-support.list"

    sudo sh -c "echo 'deb-src http://ppa.launchpad.net/morphis/anbox-support/ubuntu ${codename} main' >> /etc/apt/sources.list.d/anbox-support.list"

	sudo apt-get -qq update
    sudo apt-get -qq -y install anbox-modules-dkms

    sudo anbox session-manager
	sudo apt-get -qq -y install android-tools-adb android-tools-fastboot
}



if [[ $0 == "$BASH_SOURCE" ]]; then
    #not souce so execute
    install_anbox
fi
