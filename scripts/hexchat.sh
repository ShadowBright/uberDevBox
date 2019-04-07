#!/bin/bash

source ./init.sh

if [ ! -n "$archive_dir" ]; then
    echo "archive directory not set!"
    exit 1
fi

install_hexchat() {

	#sudo add-apt-repository ppa:overcoder/hexchat
	#sudo add-apt-repository -y ppa:gwendal-lebihan-dev/hexchat-stable
	#sudo apt update -qq && sudo apt-get -qq -y install hexchat
	sudo snap install hexchat

}

if [[ $0 == "$BASH_SOURCE" ]]; then
    #not souce so execute
    install_hexchat
fi
