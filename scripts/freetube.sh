#!/bin/bash

source ./init.sh

if [ ! -n "$archive_dir" ]; then
    echo "archive directory not set!"
    exit 1
fi

install_freetube() {

    sudo apt-get install -qq -y wget
    export VER="0.5.3"
    #TODO: automate getting latest version number
    wget -q https://github.com/FreeTubeApp/FreeTube/releases/download/v${VER}-beta/FreeTube_${VER}_amd64.deb
    sudo dpkg -i FreeTube_${VER}_amd64.deb

    #download youtube subscriptions and import
    #https://www.youtube.com/subscription_manager?action_takeout=1
}


if [[ $0 == "$BASH_SOURCE" ]]; then
    #not souce so execute
    install_freetube
fi
