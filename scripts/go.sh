#!/bin/bash

source ./init.sh

if [ ! -n "$archive_dir" ]; then
    echo "archive directory not set!"
    exit 1
fi

install_go() {

     echo "Install Go..."

     ARCH="$(dpkg --print-architecture)"

     sudo wget https://storage.googleapis.com/golang/go$GO_VERSION.linux-$ARCH.tar.gz
     sudo tar -C /usr/local -xzf go$GO_VERSION.linux-$ARCH.tar.gz

}

if [[ $0 == "$BASH_SOURCE" ]]; then
    #not souce so execute
    install_go
fi
