#!/bin/bash

source ./init.sh

if [ ! -n "$archive_dir" ]; then
    echo "archive directory not set!"
    exit 1
fi

install_nvm() {
      sudo apt-get install build-essential checkinstall libssl-dev
      curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.1/install.sh | bash
}

if [[ $0 == "$BASH_SOURCE" ]]; then
    #not souce so execute
    install_nvm
fi
