#!/bin/bash

source ./init.sh

if [ ! -n "$archive_dir" ]; then
    echo "archive directory not set!"
    exit 1
fi

install_expressvpn() {

    remotePath="$(curl --silent https://www.expressvpn.com/latest?utm_source=linux_app | grep -oP 'http.*expressvpn.*deb' | tail -1)"
    fileName="$(echo "$remotePath" | awk -F/ '{print $NF}')"

    sudo dpkg -r expressvpn

    if [ ! -f ${archive_dir}${fileName} ]; then
        sudo wget -q -O ${archive_dir}${fileName} $remotePath
    fi

    sudo dpkg -i ${archive_dir}${fileName}
}


if [[ $0 == "$BASH_SOURCE" ]]; then
    #not souce so execute
    install_expressvpn
fi
