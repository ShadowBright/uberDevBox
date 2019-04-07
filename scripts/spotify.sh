#!/bin/bash

source ./init.sh

if [ ! -n "$archive_dir" ]; then
    echo "archive directory not set!"
    exit 1
fi

install_spotify() {

    sudo apt-add-repository -y "deb http://repository.spotify.com stable non-free"
    #sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys D2C19886
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0DF731E45CE24F27EEEB1450EFDC8610341D9410
    sudo apt-get update -qq
    sudo apt-get -y install spotify-client

}


if [[ $0 == "$BASH_SOURCE" ]]; then
    #not souce so execute
    install_spotify
fi
