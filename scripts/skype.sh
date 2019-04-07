#!/bin/bash

source ./init.sh

if [ ! -n "$archive_dir" ]; then
    echo "archive directory not set!"
    exit 1
fi

install_skype() {

    fileName="skypeforlinux-64.deb"

    #sudo dpkg -r skype

    if [[ ! -f ${archive_dir}${fileName} ]]; then
        sudo wget -q -O ${archive_dir}${fileName} https://repo.skype.com/latest/${fileName}
    fi

    sudo dpkg -i ${archive_dir}${fileName}

}

if [[ $0 == "$BASH_SOURCE" ]]; then
    #not souce so execute
    install_skype
fi
