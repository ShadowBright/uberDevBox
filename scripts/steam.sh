#!/bin/bash

source ./init.sh

if [ ! -n "$archive_dir" ]; then
    echo "archive directory not set!"
    exit 1
fi

install_steam() {

    sudo add-apt-repository multiverse
    sudo apt update && sudo apt install steam

}


if [[ $0 == "$BASH_SOURCE" ]]; then
    #not souce so execute
    install_steam
fi
