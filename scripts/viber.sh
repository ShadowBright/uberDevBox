#!/bin/bash

source ./init.sh

if [ ! -n "$archive_dir" ]; then
    echo "archive directory not set!"
    exit 1
fi

install_viber() {

    fileName="viber.deb"

    if [ ! -f ${archive_dir}${fileName} ]; then
        echo "Downloading $fileName ..."
        sudo wget -q http://download.cdn.viber.com/cdn/desktop/Linux/${fileName} -O ${archive_dir}${fileName}
    fi

    sudo apt-get -qq -y install libcurl3
    sudo dpkg -i ${archive_dir}${fileName}
    #sudo dpkg -f install

}


if [[ $0 == "$BASH_SOURCE" ]]; then
    #not souce so execute
    install_viber
fi
