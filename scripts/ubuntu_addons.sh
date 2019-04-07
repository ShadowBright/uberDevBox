#!/bin/bash

source ./init.sh

if [ ! -n "$archive_dir" ]; then
    echo "archive directory not set!"
    exit 1
fi

install_ubuntu() {
	sudo apt-get -qq -y install gnome-tweak-tool ubuntu-restricted-extras
}


if [[ $0 == "$BASH_SOURCE" ]]; then
    #not souce so execute
    install_ubuntu_addons
fi
