#!/bin/bash

source ./init.sh

if [ ! -n "$archive_dir" ]; then
    echo "archive directory not set!"
    exit 1
fi

install_feedreader() {

    #flatpak install did not install properly
    curl https://raw.githubusercontent.com/jangernert/FeedReader/master/scripts/install_ubuntu.sh | bash
}

if [[ $0 == "$BASH_SOURCE" ]]; then
    #not souce so execute
    install_app
fi
