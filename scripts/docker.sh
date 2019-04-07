#!/bin/bash

source ./init.sh

if [ ! -n "$archive_dir" ]; then
    echo "archive directory not set!"
    exit 1
fi

install_docker () {

    sudo apt-get -qq -y remove docker docker-engine docker.io lxc-docker
    sudo rm /etc/apt/sources.list.d/docker.list

    sudo apt-get -qq update
    sudo apt-get install docker.io
    systemctl unmask docker.service
    systemctl unmask docker.socket
    #NOTE: will have to disable VPN to get this to start...?
    systemctl start docker.service
    sudo systemctl enable docker
    sudo usermod -aG docker $USER
    sudo gpasswd -a $USER docker
    newgrp docker
 }


if [[ $0 == "$BASH_SOURCE" ]]; then
    #not souce so execute
    install_docker
fi
