#!/bin/bash

source ./init.sh

if [ ! -n "$archive_dir" ]; then
    echo "archive directory not set!"
    exit 1
fi

install_insync() {


    #sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ACCAF35C
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys ACCAF35C

    sudo rm /etc/apt/sources.list.d/insync.list

    #NOTE: bonic is not available yet for insync
    #codename="$(lsb_release -c | sed 's/.*Codename:\W\(.*\)/\1/')"
    codename="artful"

    sudo sh -c "echo 'deb http://apt.insynchq.com/ubuntu ${codename} non-free contrib' >> /etc/apt/sources.list.d/insync.list"

    sudo apt-get -qq update
    sudo apt-get -qq -y install insync
}


if [[ $0 == "$BASH_SOURCE" ]]; then
    #not souce so execute
    install_insync
fi
