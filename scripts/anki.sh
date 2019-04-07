#!/bin/bash

source ./init.sh

if [ ! -n "$archive_dir" ]; then
    echo "archive directory not set!"
    exit 1
fi

install_anki() {

    #flashcard program
    sudo apt-get install anki

    return 0
    #NOTE: Have not found a way to get latest version of file to download
    fileName="anki-2.0.43-amd64.tar.bz2"

    if [ ! -f ${archive_dir}${fileName} ]; then
        sudo wget -q -O ${archive_dir}${fileName} https://apps.ankiweb.net/downloads/current/${fileName}
    fi

    if [ -d /opt/anki ]; then
        sudo rm -r /opt/anki
    fi

    sudo mkdir /opt/anki

    sudo cp ${archive_dir}${fileName} /opt
    sudo tar xjf /opt/${fileName} -C /opt/anki
    cd /opt/anki
    sudo make install

}


if [[ $0 == "$BASH_SOURCE" ]]; then
    #not souce so execute
    install_anki
fi
