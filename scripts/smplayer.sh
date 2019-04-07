#!/bin/bash

source ./init.sh

if [ ! -n "$archive_dir" ]; then
    echo "archive directory not set!"
    exit 1
fi

install_smplayer(){

sudo add-apt-repository ppa:rvm/smplayer
sudo apt-get -qq update
sudo apt-get -qq -y install smplayer smplayer-themes smplayer-skins


}



if [[ $0 == "$BASH_SOURCE" ]]; then
    #not souce so execute
    install_app
fi
